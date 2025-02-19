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

#ifdef __OBJC__
#import <Foundation/Foundation.h>
#endif


NS_ASSUME_NONNULL_BEGIN

@class Device;

@interface User : NSObject

-(instancetype)init;
-(instancetype)initWithId:(uint32_t)id serverId:(uint32_t)serverId email:(NSString*)email name:(NSString*)name passwd:(NSString*)passwd host:(NSString*)host hostAuthUser:(NSString*)hostAuthUser hostAuthPasswd:(NSString*)hostAuthPasswd dateTimeLastUpdate:(NSString*)dateTimeLastUpdate status:(uint8_t)status;

-(void)setid:(uint32_t)id;
-(uint32_t)getid;
-(void)setServerId:(uint32_t)id;
-(uint32_t)getServerId;
-(void)setEmail:(NSString*)email;
-(NSString*)getEmail;
-(void)setName:(NSString*)name;
-(NSString*)getName;
-(void)setPasswd:(NSString*)passwd;
-(NSString*)getPasswd;
-(NSString*)getHost;
-(void)setHost:(NSString*)host;
-(NSString*)getHostAuthUser;
-(void)setHostAuthUser:(NSString*)hostAuthUser;
-(NSString*)getHostAuthPasswd;
-(void)setHostAuthPasswd:(NSString*)hostAuthPasswd;
-(NSString*)getDateTimeLastUpdate;
-(void)setDateTimeLastUpdate:(NSString*)dateTimeLastUpdate;
-(void)setStatus:(uint8_t)status;
-(uint8_t)getStatus;
-(BOOL)isEmpty;

-(void)setReferenceDevice:(Device* _Nullable)referenceDevice;
-(Device* _Nullable)getReferenceDevice;
-(void)setReferenceSession:(NSString*)referenceSession;
-(NSString*)getReferenceSession;

@end

NS_ASSUME_NONNULL_END
