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


#import "User.h"

#include "pocket-pods/user.hpp"
using pocket::pods::user;

#include <memory>
using namespace std;

@implementation User
@synthesize  _id;
@synthesize email;
@synthesize name;
@synthesize passwd;
@synthesize timestampLastUpdate;
@synthesize status;


-(instancetype)init
{
    if(self = [super init])
    {

    }
    return self;
}

-(instancetype)initWithId:(uint32_t)_id
    email:(NSString*)email
    name:(NSString*)name
    passwd:(NSString*)passwd
    timestampLastUpdate:(uint64_t)timestampLastUpdate
    status:(UserStat)status
{
    if(self = [super init])
    {
        self._id = _id;
        self.email = email;
        self.name = name;
        self.passwd = passwd;
        self.timestampLastUpdate = timestampLastUpdate;
        self.status = status;
    }
    return self;
}

@end


user::ptr convert(const User* user)
{
    return make_unique<struct user>(
                                    user._id
                                    ,[user.name UTF8String]
                                    ,[user.email UTF8String]
                                    ,[user.passwd UTF8String]
                                    ,static_cast<user::stat>(user.status)
                                    ,user.timestampLastUpdate
                                    );
}

User* convert(const user::ptr &user)
{
    User *ret = [User new];
    
    ret._id = static_cast<uint32_t>(user->id);
    ret.email = [NSString stringWithCString:user->email.c_str() encoding:NSUTF8StringEncoding];
    ret.name = [NSString stringWithCString:user->name.c_str() encoding:NSUTF8StringEncoding];
    ret.passwd = [NSString stringWithCString:user->passwd.c_str() encoding:NSUTF8StringEncoding];
    ret.status = static_cast<UserStat>(user->status);
    ret.timestampLastUpdate = user->timestamp_last_update;
    
    return ret;
}
