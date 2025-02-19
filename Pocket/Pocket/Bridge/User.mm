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

//#include <pocket/pods/user.hpp>
#import "User.h"
#import "Device.h"

//extern pocket::pods::Device::Ptr convert(const Device* device);
//extern Device* convert(const pocket::pods::Device::Ptr &group);

#include <memory>
using namespace std;


@interface User ()
//@property uint32_t _id;
//@property uint32_t _serverId;
//@property NSString* _email;
//@property NSString* _name;
//@property NSString* _passwd;
//@property NSString* _host;
//@property NSString* _hostAuthUser;
//@property NSString* _hostAuthPasswd;
//@property NSString* _dateTimeLastUpdate;
//@property uint8_t _status;
//@property NSString* _referenceSession;
//@property Device* _referenceDevice;
@end


@implementation User
//@synthesize  _id;
//@synthesize _serverId;
//@synthesize _email;
//@synthesize _name;
//@synthesize _passwd;
//@synthesize _host;
//@synthesize _hostAuthUser;
//@synthesize _hostAuthPasswd;
//@synthesize _dateTimeLastUpdate;
//@synthesize _status;
//@synthesize _referenceSession;
//@synthesize _referenceDevice;


-(instancetype)init
{
    if(self = [super init])
    {

    }
    return self;
}

-(instancetype)initWithId:(uint32_t)id serverId:(uint32_t)serverId email:(NSString*)email name:(NSString*)name passwd:(NSString*)passwd host:(NSString*)host hostAuthUser:(NSString*)hostAuthUser hostAuthPasswd:(NSString*)hostAuthPasswd dateTimeLastUpdate:(NSString*)dateTimeLastUpdate status:(uint8_t)status
{
    if(self = [super init])
    {
//        _id = id;
//        _serverId = serverId;
//        _email = email;
//        _name = name;
//        _passwd = passwd;
//        _host = host;
//        _hostAuthUser = hostAuthUser;
//        _hostAuthPasswd = hostAuthPasswd;
//        _dateTimeLastUpdate = dateTimeLastUpdate;
//        _status = status;
    }
    return self;
}

-(void)setid:(uint32_t)id
{
//    _id = id;
}

-(uint32_t)getid
{
//    return _id;
    return 0;
}

-(void)setServerId:(uint32_t)id
{
//    _serverId = id;
}

-(uint32_t)getServerId
{
//    return _serverId;
    return 0;
}

-(void)setEmail:(NSString*)email
{
//    _email = email;
}

-(NSString*)getEmail
{
//    return _email;
    return nil;
}

-(void)setName:(NSString*)name
{
//    _name = name;
}

-(NSString*)getName
{
//    return _name;
    return nil;
}

-(void)setPasswd:(NSString*)passwd
{
//    _passwd = passwd;
}

-(NSString*)getPasswd
{
//    return _passwd;
    return nil;
}

-(NSString*)getHost
{
//    return _host;
    return nil;
}

-(void)setHost:(NSString*)host
{
//    _host = host;
}

-(NSString*)getHostAuthUser
{
//    return _hostAuthUser;
    return nil;
}

-(void)setHostAuthUser:(NSString*)hostAuthUser
{
//    _hostAuthUser = hostAuthUser;
}

-(NSString*)getHostAuthPasswd
{
//    return _hostAuthPasswd;
    return nil;
}

-(void)setHostAuthPasswd:(NSString*)hostAuthPasswd
{
//    _hostAuthPasswd = hostAuthPasswd;
}

-(NSString*)getDateTimeLastUpdate
{
//    return _dateTimeLastUpdate;
    return nil;
}

-(void)setDateTimeLastUpdate:(NSString*)dateTimeLastUpdate
{
//    _dateTimeLastUpdate = dateTimeLastUpdate;
}

-(void)setStatus:(uint8_t)status
{
//    _status = status;
}

-(uint8_t)getStatus
{
//    return _status;
    return 0;
}

-(BOOL)isEmpty
{
//    return [_email length] == 0 || [_host length] == 0;
    return 0;
}

-(void)setReferenceDevice:(Device* _Nullable)referenceDevice
{
//    _referenceDevice = referenceDevice;
}

-(Device* _Nullable)getReferenceDevice
{
//    return _referenceDevice;
    return nil;
}

-(void)setReferenceSession:(NSString*)referenceSession
{
//    _referenceSession = referenceSession;
}

-(NSString*)getReferenceSession
{
//    return _referenceSession;
    return nil;
}


@end


//pocket::pods::User::Ptr convert(const User* user)
//{
//    auto &&ret =  make_shared<pocket::pods::User>(
//        [user getid]
//        ,[user getServerId]
//        ,[[user getEmail] UTF8String]
//        ,[[user getName] UTF8String]
//        ,[[user getPasswd] UTF8String]
//        ,[[user getHost] UTF8String]
//        ,[[user getHostAuthUser] UTF8String]
//        ,[[user getHostAuthPasswd] UTF8String]
//        ,[[user getDateTimeLastUpdate] UTF8String]
//        ,pocket::pods::User::Status{[user getStatus]}
//    );
//    if([user getReferenceDevice] != Nil)
//    {
//        ret->referenceDevice = convert([user getReferenceDevice]);
//    }
//    ret->referenceSession = [[user getReferenceSession] UTF8String];
//    
//    return ret;
//}
//
//User* convert(const pocket::pods::User::Ptr &user)
//{
//    User *ret = [[User alloc] init];
//    
//    [ret setid:user->id];
//    [ret setServerId:user->serverId];
//    [ret setEmail: [NSString stringWithCString:user->email.c_str() encoding:NSUTF8StringEncoding] ];
//    [ret setName: [NSString stringWithCString:user->name.c_str() encoding:NSUTF8StringEncoding] ];
//    [ret setPasswd: [NSString stringWithCString:user->passwd.c_str() encoding:NSUTF8StringEncoding] ];
//    [ret setHost: [NSString stringWithCString:user->host.c_str() encoding:NSUTF8StringEncoding] ];
//    [ret setHostAuthUser: [NSString stringWithCString:user->hostAuthUser.c_str() encoding:NSUTF8StringEncoding] ];
//    [ret setHostAuthPasswd: [NSString stringWithCString:user->hostAuthPasswd.c_str() encoding:NSUTF8StringEncoding] ];
//    [ret setDateTimeLastUpdate: [NSString stringWithCString:user->dateTimeLastUpdate.c_str() encoding:NSUTF8StringEncoding] ];
//    [ret setStatus: static_cast<uint8_t>(user->status) ];
//    if(user->referenceDevice.get() != nullptr)
//    {
//        [ret setReferenceDevice:convert(user->referenceDevice)];
//    }
//    [ret setReferenceSession:[NSString stringWithCString:user->referenceSession.c_str() encoding:NSUTF8StringEncoding] ];
//    return ret;
//}
