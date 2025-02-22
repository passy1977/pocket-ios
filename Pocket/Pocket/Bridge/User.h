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
-(instancetype)initWithId:(uint32_t)id     email:(NSString*)email
    name:(NSString*)name
    passwd:(NSString*)passwd
    timestampLastUpdate:(uint64_t)timestampLastUpdate
    status:(uint8_t)status;

-(void)setid:(uint32_t)id;
-(uint32_t)getid;
-(void)setEmail:(NSString*)email;
-(NSString*)getEmail;
-(void)setName:(NSString*)name;
-(NSString*)getName;
-(void)setPasswd:(NSString*)passwd;
-(NSString*)getPasswd;
-(uint64_t)getTimestampLastUpdate;
-(void)setTimestampLastUpdate:(uint64_t)timestampLastUpdate;
-(void)setStatus:(uint8_t)status;
-(uint8_t)getStatus;
-(BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
