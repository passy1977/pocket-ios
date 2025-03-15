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

#define KEY_DEVICE @"device"
#define KEY_EMAIL @"email"
#define KEY_PASSWD @"passwd"

NS_ASSUME_NONNULL_BEGIN


@class User;
@class Session;
@interface Globals : NSObject

typedef NS_ENUM(NSUInteger, Stat)
{
    READY = 0,
    BUSY,
    USER_NOT_FOUND = 600,
    WRONG_SIZE_TOKEN = 601,
    DEVICE_ID_NOT_MATCH = 602,
    DEVICE_NOT_FOUND = 603,
    SECRET_NOT_MATCH = 604,
    USER_ID_NOT_MATCH = 605,
    TIMESTAMP_LAST_UPDATE_NOT_MATCH = 606,
    CACHE_NOT_FOND = 607,
    SECRET_EMPTY = 608,
    TIMESTAMP_LAST_NOT_PARSABLE = 609,
    ERROR = USER_NOT_FOUND + 100,
    JSON_PARSING_ERROR = USER_NOT_FOUND + 100 + 1,
    DB_GROUP_ERROR = USER_NOT_FOUND + 100 + 2,
    DB_GROUP_FIELD_ERROR = USER_NOT_FOUND + 100 + 3,
    DB_FIELD_ERROR = USER_NOT_FOUND + 100 + 4,
    DB_GENERIC_ERROR = USER_NOT_FOUND + 100 + 5,
    NO_NETWORK = USER_NOT_FOUND + 100 + 6,
    MAP_ID_ERROR = USER_NOT_FOUND + 100 + 7,
    LOCAL_DEVICE_ID_NOT_MATCH = DEVICE_ID_NOT_MATCH + 200,
    OK = 200
};

-(instancetype)init;

+(Globals*)shared;

-(BOOL)initialize:(nonnull const NSString*)basePath
       configJson:(nullable const NSString*)configJson
           passwd:(nonnull const NSString*)passwd;

-(Stat)login:(nullable const NSString*)email
      passwd:(nullable const NSString*)passwd;

-(BOOL)sendData;

-(nullable const User *)getUser;
-(nonnull Session *)getSession;

@end

NS_ASSUME_NONNULL_END
