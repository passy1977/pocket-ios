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

#import "Globals.h"

NS_ASSUME_NONNULL_BEGIN


@interface FieldController : NSObject
@property BOOL reachability;

-(instancetype)init;
-(void)initialize;

-(NSArray<Field*>*)getListField:(uint32_t)groupId search:(nonnull const NSString*)search;
-(Stat)persistField:(nonnull const Field*)field;
-(Stat)delField:(Field*)field;
-(int32_t)sizeFiled:(uint32_t)groupId;

@end

NS_ASSUME_NONNULL_END
