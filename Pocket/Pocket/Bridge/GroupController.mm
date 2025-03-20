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

#include "pocket/globals.hpp"
using namespace pocket;

#include "pocket-views/view-group.hpp"
#include "pocket-views/view-group-field.hpp"
using views::view;

#include "pocket-pods/group.hpp"
#include "pocket-pods/group-field.hpp"
#include "pocket-pods/field.hpp"
using namespace pods;

#include "pocket-controllers/session.hpp"
using controllers::session;

#include "tinyxml2/tinyxml2.h"
using namespace tinyxml2;

#include <stdexcept>
#include <fstream>
using namespace std;

extern group::ptr convert(const Group* group);
extern Group* convert(const group::ptr &field);
extern group_field::ptr convert(const GroupField* group_field);
extern GroupField* convert(const group_field::ptr &group);
extern field::ptr convert(const Field* field);
extern Field* convert(const field::ptr &field);
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
@property view<field> *viewField;
@property const User *user;
@property (strong) NSMutableDictionary<NSNumber *, GroupField *> *showList;
@end


@implementation GroupController
@synthesize reachability;
@synthesize session;
@synthesize user;
@synthesize viewGroup;
@synthesize viewGroupField;
@synthesize viewField;
@synthesize showList;

//MARK: - System
-(instancetype)init
{
    if(self = [super init])
    {
        reachability = false;
        session = nullptr;
        user = nullptr;
        viewGroup = nullptr;
        viewGroupField = nullptr;
        viewField = nullptr;
        showList = [NSMutableDictionary new];
    }
    return self;
}

-(void)initialize
{
    session = [[Globals shared] getSession].session;
    user = [[Globals shared] getUser];
    viewGroup = session->get_view_group().get();
    viewGroupField = session->get_view_group_field().get();
    viewField = session->get_view_field().get();
}

//MARK: - Group
-(nonnull NSArray<Group*>*)getListGroup:(uint32_t)groupId search:(nonnull const NSString*)search
{
    NSMutableArray<Group*> *ret = [NSMutableArray new];
    try
    {
        for(auto &&it : viewGroup->get_list(groupId, [search UTF8String]))
        {
            [ret addObject:convert(it)];
        }
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
    }
    return ret;
}

-(int32_t)countChild:(nonnull const Group*)group
{
    try
    {
        return static_cast<uint32_t>(viewGroup->get_list(group._id).size()) + static_cast<uint32_t>(viewField->get_list(group._id).size());
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return 0;
    }
}

-(Stat)delGroup:(nonnull const Group*)group
{
    try
    {
        viewGroupField->del_by_group_id(group._id);
        viewField->del_by_group_id(group._id);
        viewGroup->del(group._id);
        if(auto&& user = session->send_data(convert(self.user)); user)
        {
            self.user = convert(user.value());
            return OK;
        }
        else
        {
            return static_cast<Stat>(session->get_status());
        }
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return Stat::ERROR;
    }
}

-(Stat)persistGroup:(nonnull const Group*)group
{
    try
    {
        auto&& g = convert(group);
        g->user_id = [user getid];
        g->synchronized = false;
        g->id = viewGroup->persist(g);
        
        for (NSNumber *key in showList)
        {
            GroupField *gfObjC = showList[key];
            auto&& gf = convert(gfObjC);
            if(gfObjC.newInsertion)
            {
                gf->id = 0;
            }
            gf->user_id = [user getid];
            gf->group_id = g->id;
            gf->server_group_id = g->server_id;
            gf->synchronized = false;
            
            gf->id = viewGroupField->persist(gf);
            gfObjC._id = static_cast<uint32_t>(gf->id);
            
            Field *fObjC = [Field new];
            fObjC.title = gfObjC.title;
            fObjC.value = @"";
            fObjC.isHidden = gf->is_hidden;
            auto&& f = convert(fObjC);
            f->user_id = [user getid];
            f->group_id = g->id;
            f->server_group_id = g->server_id;
            f->group_field_id = gf->id;
            f->server_group_id = gf->server_id;
            f->synchronized = false;
            
            f->id = viewField->persist(f);
            fObjC._id = static_cast<uint32_t>(f->id);
        }
        
        if(auto&& user = session->send_data(convert(self.user)); user)
        {
            self.user = convert(user.value());
            [showList removeAllObjects];
        }

        return static_cast<Stat>(session->get_status());
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return Stat::ERROR;
    }
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

//MARK: - ExportImport

-(BOOL)dataExport:(NSString*)fullPathFileExport
{
    try
    {
        return session->export_data(convert(user), [fullPathFileExport UTF8String], POCKET_ENABLE_AES);
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return false;
    }
}

-(BOOL)dataImport:(NSString*)fullPathFileImport
{
    try
    {
        return session->import_data(convert(user), [fullPathFileImport UTF8String], POCKET_ENABLE_AES);
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return false;
    }
}

-(BOOL)dataImportLegacy:(NSString*)fullPathFileImport
{
    try
    {
        return session->import_data_legacy(convert(user), [fullPathFileImport UTF8String], POCKET_ENABLE_AES);
    } catch (const runtime_error &e) {
        error(APP_TAG, e.what());
        return false;
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
    //id value = [showList objectForKey: [NSNumber numberWithLongLong:[groupField getid]]];
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
            
            if([it getid] == idGroupField)
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
