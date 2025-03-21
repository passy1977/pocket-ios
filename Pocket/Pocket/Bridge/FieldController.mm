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


//#include <pocket/controllers/fieldcontroller.hpp>
//using namespace std;

#import "Field.h"
#import "FieldController.h"
#import "User.h"

#include "pocket/globals.hpp"
using namespace pocket;

#include "pocket-pods/field.hpp"
using namespace pods;

#include "pocket-views/view.hpp"
using views::view;

#include "pocket-controllers/session.hpp"
using controllers::session;

#include <stdexcept>
using namespace std;


extern field::ptr convert(const Field* field);
extern Field* convert(const field::ptr &field);
extern user::ptr convert(const User* user);
extern User* convert(const user::ptr &user);

namespace
{

constexpr char APP_TAG[] = "FieldController";

}
 

@interface FieldController ()
@property session *session;
@property view<field> *viewField;
@property const User *user;
@end


@implementation FieldController
@synthesize reachability;
@synthesize session;
@synthesize viewField;
@synthesize user;

-(instancetype)init
{
    if(self = [super init])
    {
        reachability = false;
        session = nullptr;
        viewField = nullptr;
        user = nullptr;
    }
    return self;
}

-(void)initialize
{
    session = static_cast<class session*>([[Globals shared] getSession]);
    user = [Globals shared].user;
    viewField = session->get_view_field().get();
}

//MARK: - Field
-(NSArray<Field*>*)getListField:(uint32_t)groupId search:(nonnull const NSString*)search
{
    
    NSMutableArray<Field*> *ret = [NSMutableArray new];
    try
    {
        for(auto &&it : viewField->get_list(groupId, [search UTF8String]))
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

-(Stat)persistField:(nonnull const Field*)field
{
    try
    {
        auto&& f = convert(field);
        viewField->persist(f);
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


-(Stat)delField:(Field*)field
{
    try
    {
        viewField->del(field._id);
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

-(int32_t)sizeFiled:(uint32_t)groupId
{
    try
    {
        return static_cast<int32_t>(viewField->get_list(groupId).size());
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return 0;
    }
}

@end
