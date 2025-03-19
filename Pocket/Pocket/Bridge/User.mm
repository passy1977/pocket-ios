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

@interface User ()
@property uint32_t _id;
@property NSString* _email;
@property NSString* _name;
@property NSString* _passwd;
@property UserStat _status;
@property uint64_t _timestampLastUpdate;
@end


@implementation User
@synthesize  _id;
@synthesize _email;
@synthesize _name;
@synthesize _passwd;
@synthesize _timestampLastUpdate;
@synthesize _status;


-(instancetype)init
{
    if(self = [super init])
    {

    }
    return self;
}

-(instancetype)initWithId:(uint32_t)id
    email:(NSString*)email
    name:(NSString*)name
    passwd:(NSString*)passwd
    timestampLastUpdate:(uint64_t)timestampLastUpdate
    status:(UserStat)status
{
    if(self = [super init])
    {
        _id = id;
        _email = email;
        _name = name;
        _passwd = passwd;
        _timestampLastUpdate = timestampLastUpdate;
        _status = status;
    }
    return self;
}

-(void)setid:(uint32_t)id
{
    _id = id;
}

-(uint32_t)getid
{
    return _id;
}

-(void)setEmail:(NSString*)email
{
    _email = email;
}

-(NSString*)getEmail
{
    return _email;
}

-(void)setName:(NSString*)name
{
    _name = name;
}

-(NSString*)getName
{
    return _name;
}

-(void)setPasswd:(NSString*)passwd
{
    _passwd = passwd;
}

-(NSString*)getPasswd
{
    return _passwd;
}


-(uint64_t)getTimestampLastUpdate
{
    return _timestampLastUpdate;
}

-(void)setTimestampLastUpdate:(uint64_t)timestampLastUpdate
{
    _timestampLastUpdate = timestampLastUpdate;
}

-(void)setStatus:(UserStat)status
{
    _status = status;
}

-(UserStat)getStatus
{
    return _status;
}

@end


user::ptr convert(const User* user)
{
    return make_unique<struct user>(
        [user getid]
        ,[[user getName] UTF8String]
        ,[[user getEmail] UTF8String]
        ,[[user getPasswd] UTF8String]
        ,static_cast<user::stat>([user getStatus])
        ,[user getTimestampLastUpdate]
    );;
}

User* convert(const user::ptr &user)
{
    User *ret = [User new];
    
    [ret setid: static_cast<uint32_t>(user->id)];
    [ret setEmail: [NSString stringWithCString:user->email.c_str() encoding:NSUTF8StringEncoding] ];
    [ret setName: [NSString stringWithCString:user->name.c_str() encoding:NSUTF8StringEncoding] ];
    [ret setPasswd: [NSString stringWithCString:user->passwd.c_str() encoding:NSUTF8StringEncoding] ];
    [ret setStatus: static_cast<UserStat>(user->status) ];
    [ret setTimestampLastUpdate: user->timestamp_last_update ];
    
    return ret;
}
