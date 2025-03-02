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
#import "Field.h"
#import "GroupField.h"
#import "Session.h"

#import "GroupController.h"

#import "User.h"

#include "pocket-views/view-group.hpp"
#include "pocket-views/view-group-field.hpp"
using namespace pocket;
using views::view;

#include "pocket-pods/group.hpp"
#include "pocket-pods/group-field.hpp"
using namespace pods;

#include "pocket-controllers/session.hpp"
using controllers::session;

#include <stdexcept>
using namespace std;

extern group::ptr convert(const Group* group);
extern Group* convert(const group::ptr &field);
extern group_field::ptr convert(const GroupField* group_field);
extern GroupField* convert(const group_field::ptr &field);
extern user::ptr convert(const User* user);
extern User* convert(const user::ptr &user);

namespace
{

constexpr char APP_TAG[] = "GroupController";

}
 

@interface GroupController ()
@property session *session;
@property view<group> *viewGroup;
@property view<group_field> *viewGroupField;
@property (strong) NSMutableDictionary<NSNumber *, GroupField *> *showList;
@end


@implementation GroupController
@synthesize reachability;
@synthesize lastIdGroupField;
@synthesize session;
@synthesize viewGroup;
@synthesize viewGroupField;
@synthesize showList;

//MARK: - System
-(instancetype)init
{
    if(self = [super init])
    {
        reachability = false;
        lastIdGroupField = 0;
        session = nullptr;
        viewGroup = nullptr;
        viewGroupField = nullptr;
        showList = [NSMutableDictionary new];
    }
    return self;
}

-(void)initialize
{
    session = [[Globals getInstance] getSession].session;
    viewGroup = session->get_view_group().get();
    viewGroupField = session->get_view_group_field().get();
}

//MARK: - Group
-(nonnull NSArray<Group*>*)getListGroup:(uint32_t)groupId search:(NSString*)search
{
    NSMutableArray<Group*> *ret = [NSMutableArray new];
    for(auto &&it : viewGroup->get_list(groupId, [search UTF8String]))
    {
        [ret addObject:convert(it)];
    }
    return ret;
}

-(int32_t)countChild:(Group*)group
{
    return static_cast<uint32_t>(viewGroup->get_list([group getid]).size());
}

-(void)delGroup:(Group*)group callback:(void(^)(NSString*))callback
{
    
}

-(Stat)insertGroup:(Group*)group
{
    try
    {
        auto&& g = convert(group);
        g->synchronized = false;
        g->id = viewGroup->persist(g);
        
        for (NSNumber *key in showList)
        {
            auto&& gf = convert(showList[key]);
            gf->group_id = g->id;
            gf->synchronized = false;
            
            gf->id = viewGroupField->persist(gf);
            
            NSLog(@"Key: %@, Value: %lld %s", key, gf->id , gf->title.c_str());
        }
        
        session->send_data(convert([[Globals getInstance] getUser]));
        
        return static_cast<Stat>(session->get_status());
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return Stat::ERROR;
    }
}

-(void)updateGroup:(Group*)group
{

    
}


//MARK: - ExportImport

-(void)xmlExport:(NSString*)fullPathFileXmlExport callback:(void(^)(BOOL))callback
{

}

-(void)xmlImport:(NSString*)fullPathFileXmlImport callback:(void(^)(BOOL))callback
{

}

-(void)exit
{

}


//MARK: - Virtual list for handling new GroupField
-(void)cleanShowList
{
    [showList removeAllObjects];
}

-(void)fillShowList:(nonnull const Group *)group copy:(bool)copy
{
    [self cleanShowList];
    for(auto&& it : viewGroupField->get_list([group getid]))
    {
        [showList setObject:convert(it) forKey:[NSNumber numberWithLongLong:it->id]];
    }
}

-(void)fillShowList:(nonnull const Group *)group
{
    [self fillShowList:group copy:false];
}

-(nonnull NSArray<GroupField*>*)getShowList
{
    return [showList allValues];
}

-(BOOL)addToShowList:(nonnull GroupField *)groupField
{
    //id value = [showList objectForKey: [NSNumber numberWithLongLong:[groupField getid]]];
    id value = showList[[NSNumber numberWithLongLong:[groupField getid]]];
    if(value)
    {
        [value setSynchronized:false];
        [value setTitle: [groupField getTitle]];
        [value setIsHidden: [groupField getIsHidden]];
        return true;
    }
    else
    {
        [groupField setSynchronized:false];
        [showList setObject:groupField forKey:[NSNumber numberWithLongLong:[groupField getid]]];
        return true;
    }
}

-(BOOL)delFromShowList:(uint32_t)idGroupField
{
    int64_t toDelete = -1, i = 0;
    for (NSNumber *key in showList)
    {
        id it = showList[key];
        
        if([it getid] == idGroupField)
        {
            if([it getServerId] > 0)
            {
                viewGroupField->del([it getServerId]);
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

-(uint8_t)sizeShowList
{
    return [[showList allKeys] count];
}

@end
