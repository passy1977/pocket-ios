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

@class Field;
@class User;
@class Device;
@class Globals;
@class Group;
@class GroupField;

@interface FieldController : NSObject

-(instancetype)init;

-(NSArray<Field*>*)getListField:(uint32_t)groupId search:(NSString*)search;
-(void)insertField:(Field*)field callback:(void(^)(NSString*))callback;
-(void)updateField:(Field*)field callback:(void(^)(NSString*))callback;
-(void)delField:(Field*)field callback:(void(^)(NSString*))callback;
-(int64_t)sizeFiled:(uint32_t)groupId;
-(void)initialize;
-(void)setReachability:(BOOL)reachability;

@end

NS_ASSUME_NONNULL_END
