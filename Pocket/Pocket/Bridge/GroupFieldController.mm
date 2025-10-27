/***************************************************************************
 *
 * Pocket
 * Copyright (C) 2018/2025 Antonio Salsi <passy.linux@zresa.it>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 ***************************************************************************/

#import "Group.h"
#import "GroupField.h"
#import "Constants.h"

#import "GroupFieldController.h"

#import "User.h"

#include "pocket/globals.hpp"
using namespace pocket;

#include "pocket-views/view-group-field.hpp"
using views::view;

#include "pocket-pods/group-field.hpp"
using namespace pods;

#include "pocket-controllers/session.hpp"
using controllers::session;

#include <stdexcept>
using namespace std;

extern group_field::ptr convert(const GroupField* group_field);
extern GroupField* convert(const group_field::ptr &group);

namespace
{

constexpr char APP_TAG[] = "GroupFieldController";

}
 

@interface GroupFieldController ()
@property session *session;
@property view<group_field> *viewGroupField;
@property const User *user;
@property (strong) NSMutableDictionary<NSNumber *, GroupField *> *showList;
@end


@implementation GroupFieldController
@synthesize session;
@synthesize user;
@synthesize viewGroupField;
@synthesize showList;

//MARK: - System
-(instancetype)init
{
    if(self = [super init])
    {
        session = nullptr;
        user = nullptr;
        viewGroupField = nullptr;
        showList = [NSMutableDictionary new];
    }
    return self;
}

-(void)initialize
{
    session = static_cast<class session*>([[Globals shared] getSession]);
    user = [Globals shared].user;
    viewGroupField = session->get_view_group_field().get();
}

//MARK: - GroupField
-(uint32_t)getLastIdGroupField
{
    try
    {
        auto lastGroupFieldId = viewGroupField->get_last_id();
        
        return lastGroupFieldId > 0 ? static_cast<uint32_t>(lastGroupFieldId) : 1;
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return 0;
    }
}

//MARK: - Virtual list for handling new GroupField
-(void)cleanShowList
{
    [showList removeAllObjects];
}

-(void)fillShowList:(nonnull const Group *)group insert:(bool)insert
{
    try
    {
        [self cleanShowList];
        for(auto&& it : viewGroupField->get_list(group._id))
        {
            GroupField *gf = convert(it);
            if(insert)
            {
                gf.newInsertion = true;
                [gf setServerId:0];
                [gf setGroupId: group._id];
                [gf setServerGroupId: 0];
            }
            [showList setObject:gf forKey:[NSNumber numberWithLongLong:it->id]];
        }
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
    }
}

-(void)fillShowList:(nonnull const Group *)group
{
    [self fillShowList:group insert:false];
}

-(nonnull NSArray<GroupField*>*)getShowList
{
    return [[showList allValues] sortedArrayUsingComparator:^(id obj1, id obj2) {
        return [[[obj1 title] lowercaseString] compare:[[obj2 title] lowercaseString]];
    }];
}

-(BOOL)addToShowList:(nonnull GroupField *)groupField
{
    id value = showList[[NSNumber numberWithLongLong:[groupField _id]]];
    if(value)
    {
        [value setSynchronized:false];
        [value setTitle: [groupField title]];
        [value setIsHidden: [groupField isHidden]];
        return true;
    }
    else
    {
        [groupField setSynchronized:false];
        [showList setObject:groupField forKey:[NSNumber numberWithLongLong:groupField._id]];
        return true;
    }
}

-(BOOL)delFromShowList:(uint32_t)idGroupField
{
    try
    {
        int64_t toDelete = -1, i = 0;
        for (NSNumber *key in showList)
        {
            id it = showList[key];
            
            if([it _id] == idGroupField)
            {
                if([it serverId] > 0)
                {
                    viewGroupField->del([it _id]);
                }
                toDelete = i;
                break;
            }
            i++;
        }
            
        if(toDelete > -1)
        {
            [showList removeObjectForKey:[NSNumber numberWithLongLong:toDelete]];
            return true;
        }
        else
        {
            return false;
        }
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return false;
    }
}

-(uint8_t)sizeShowList
{
    return [[showList allKeys] count];
}

@end
