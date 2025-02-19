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

//#include <pocket/pods/device.hpp>

#import "Device.h"


#include <memory>
using namespace std;


@interface Device ()
//@property uint32_t _id;
//@property uint32_t _serverId;
//@property NSString* _deviceSerial;
//@property NSString* _token;
//@property int _status;
@end


@implementation Device

//@synthesize  _id;
//@synthesize _serverId;
//@synthesize _deviceSerial;
//@synthesize _token;
//@synthesize _status;

-(instancetype)init
{
    if(self = [super init])
    {

    }
    return self;
}

-(instancetype)initWithId:(uint32_t)id serverId:(uint32_t)serverId deviceSerial:(NSString*)deviceSerial token:(NSString*)token status:(int)status
{
    if(self = [super init])
    {
//        _id = id;
//        _serverId = serverId;
//        _deviceSerial = deviceSerial;
//        _token = token;
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

-(void)setDeviceSerial:(NSString*)deviceSerial
{
//    _deviceSerial = deviceSerial;
}

-(NSString*)getDeviceSerial
{
//    return _deviceSerial;
    return nil;
}

-(void)setToken:(NSString*)token
{
//    _token = token;
}

-(NSString*)getToken
{
//    return _token;
    return nil;
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

@end


//pocket::pods::Device::Ptr convert(const Device* device)
//{
////    return make_shared<pocket::pods::Device>(
////        [device getid]
////        ,[device getServerId]
////        ,[[device getDeviceSerial] UTF8String]
////        ,[[device getToken] UTF8String]
////        ,pocket::pods::Device::Status{[device getStatus]}
////    );
//}
//
//Device* convert(const pocket::pods::Device::Ptr &group)
//{
////    Device *ret = [[Device alloc] init];
////    
////    [ret setid:group->id];
////    [ret setServerId:group->serverId];
////    [ret setDeviceSerial: [NSString stringWithCString:group->deviceSerial.c_str() encoding:NSUTF8StringEncoding] ];
////    [ret setToken: [NSString stringWithCString:group->token.c_str() encoding:NSUTF8StringEncoding] ];
////    [ret setStatus: static_cast<uint8_t>(group->status)];
////    
////    return ret;
//}
