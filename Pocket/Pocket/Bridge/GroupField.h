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

@interface GroupField : NSObject
@property BOOL newInsertion;

-(instancetype)init;
-(instancetype)initWithId:(uint32_t)id
                serverId:(uint32_t)serverId
                userId:(uint32_t)userId
                groupId:(uint32_t)groupId
                serverGroupId:(uint32_t)serverGroupId
                title:(nonnull NSString*)title
                isHidden:(BOOL)isHidden
                synchronized:(BOOL)synchronized
                deleted:(BOOL)deleted
                timestampCreation:(uint64_t)timestampCreation;

-(void)setid:(uint32_t)id;
-(uint32_t)getid;
-(void)setServerId:(uint32_t)id;
-(uint32_t)getServerId;
-(void)setUserId:(uint32_t)id;
-(uint32_t)getUserId;
-(void)setGroupId:(uint32_t)groupId;
-(uint32_t)getGroupId;
-(void)setServerGroupId:(uint32_t)serverGroupId;
-(uint32_t)getServerGroupId;
-(void)setTitle:(nonnull NSString*)title;
-(nonnull NSString*)getTitle;
-(void)setIsHidden:(BOOL)isHidden;
-(BOOL)getIsHidden;
-(void)setSynchronized:(BOOL)synchronized;
-(BOOL)getSynchronized;
-(void)setDeleted:(BOOL)deleted;
-(BOOL)getDeleted;
-(uint64_t)getTimestampCreation;
-(void)setTimestampCreation:(uint64_t)timestampCreation;

@end

NS_ASSUME_NONNULL_END
