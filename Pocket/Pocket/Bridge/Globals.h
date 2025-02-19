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

@class User;
@class Device;

@interface Globals : NSObject

-(instancetype)init;

+(Globals*)getInstance;
-(NSString*)getBasePath;
-(void)setUser:(User*)user;
-(void)setUserLastUpdate:(uint32_t)user_id user:(User*)user;

-(User* _Nullable )getUser;
-(User*)getSafeUser;
-(Device*)getDevice;
-(void)setDevice:(Device*)device;
-(NSString*)getVersion;
-(void)initSystemCrypto:(NSString*)serialNumber;
-(void)initServerCrypto:(NSString*)key;
-(void)initUserCrypto:(NSString*)key;
-(void)initialize:(NSString*)serialNumber basePath:(NSString*)basePath urlFile:(BOOL)urlFile;

@end

NS_ASSUME_NONNULL_END
