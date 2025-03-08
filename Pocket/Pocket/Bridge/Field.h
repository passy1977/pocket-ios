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

@interface Field : NSObject
@property uint32_t _id;
@property uint32_t serverId;
@property uint32_t userId;
@property uint32_t groupId;
@property uint32_t serverGroupId;
@property uint32_t groupFieldId;
@property uint32_t serverGroupFieldId;
@property NSString* title;
@property NSString* value;
@property BOOL isHidden;
@property BOOL synchronized;
@property BOOL deleted;
@property uint64_t timestampCreation;

-(instancetype)init;
-(instancetype)initWithId:(uint32_t)id
                serverId:(uint32_t)serverId
                userId:(uint32_t)userId
                groupId:(uint32_t)groupId
                serverGroupId:(uint32_t)serverGroupId
                groupFieldId:(uint32_t)groupFieldId
                serverGroupFieldId:(uint32_t)serverGroupFieldId
                title:(nonnull NSString*)title
                value:(nonnull NSString*)value
                isHidden:(BOOL)isHidden
                synchronized:(BOOL)synchronized
                deleted:(BOOL)deleted
                timestampCreation:(uint64_t)timestampCreation;

@end

NS_ASSUME_NONNULL_END
