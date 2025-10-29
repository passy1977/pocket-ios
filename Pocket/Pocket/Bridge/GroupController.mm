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
#import "Constants.h"

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
    session = static_cast<class session*>([[Pocket shared] getSession]);
    user = [Pocket shared].user;
    viewGroup = session->get_view_group().get();
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
        @throw([NSString stringWithCString:e.what() encoding:NSUTF8StringEncoding]);
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
        viewField->del_by_group_id(group._id);
        viewGroup->del(group._id);
        
        session->set_synchronizer_timeout(SYNCHRONIZER_TIMEOUT);
        session->set_synchronizer_connect_timeout(SYNCHRONIZER_CONNECT_TIMEOUT);
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
        g->user_id = user._id;
        g->synchronized = false;
        g->id = viewGroup->persist(g);
        
        session->set_synchronizer_timeout(SYNCHRONIZER_TIMEOUT);
        session->set_synchronizer_connect_timeout(SYNCHRONIZER_CONNECT_TIMEOUT);
        if(auto&& user = session->send_data(convert(self.user)); user)
        {
            self.user = convert(user.value());
        }

        return static_cast<Stat>(session->get_status());
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return Stat::ERROR;
    }
}

-(nullable Group*)getGroup:(uint32_t)groupId
{
    auto&&group_opt = viewGroup->get(groupId);
    if(group_opt)
    {
        return convert(*group_opt);
    }
    return nullptr;
}

//MARK: - ExportImport

-(BOOL)dataExport:(nonnull const NSString*)fullPathFileExport
{
    try
    {
        
        session->set_synchronizer_timeout(SYNCHRONIZER_TIMEOUT);
        session->set_synchronizer_connect_timeout(0);
        return session->export_data(convert(user), [fullPathFileExport UTF8String], POCKET_ENABLE_AES);
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return false;
    }
}

-(BOOL)dataImport:(nonnull const NSString*)fullPathFileImport
{
    try
    {
        
        session->set_synchronizer_timeout(SYNCHRONIZER_TIMEOUT);
        session->set_synchronizer_connect_timeout(0);
        return session->import_data(convert(user), [fullPathFileImport UTF8String], POCKET_ENABLE_AES);
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return false;
    }
}

-(BOOL)dataImportLegacy:(nonnull const NSString*)fullPathFileImport
{
    try
    {
        session->set_synchronizer_timeout(SYNCHRONIZER_TIMEOUT);
        session->set_synchronizer_connect_timeout(0);
        return session->import_data_legacy(convert(user), [fullPathFileImport UTF8String], POCKET_ENABLE_AES);
    } catch (const runtime_error &e) {
        error(APP_TAG, e.what());
        return false;
    }
}

@end
