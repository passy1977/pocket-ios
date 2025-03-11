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

@class User;
@class Group;
@class GroupField;
@class Session;

@interface GroupController : NSObject
@property BOOL reachability;

//MARK: - System
-(instancetype)init;
-(void)initialize;

//MARK: - Group
-(nonnull NSArray<Group*>*)getListGroup:(uint32_t)groupId search:(nonnull const NSString*)search;
-(int32_t)countChild:(nonnull const Group*)group;
-(Stat)delGroup:(nonnull const Group*)group;
-(Stat)persistGroup:(nonnull const Group*)group;

//MARK: - GroupField
-(uint32_t)getLastIdGroupField;

//MARK: - ExportImport
-(void)xmlExport:(NSString*)fullPathFileXmlExport callback:(void(^)(BOOL))callback;
-(void)xmlImport:(NSString*)fullPathFileXmlImport callback:(void(^)(BOOL))callback;
-(void)exit;

//MARK: - Virtual list for handling new GroupField
-(void)cleanShowList;
-(void)fillShowList:(nonnull const Group *)group insert:(bool)insert;
-(void)fillShowList:(nonnull const Group *)group;
-(nonnull NSArray<GroupField*>*)getShowList;
-(BOOL)addToShowList:(nonnull GroupField *)groupField;
-(BOOL)delFromShowList:(uint32_t)idGroupField;
-(uint8_t)sizeShowList;

@end

NS_ASSUME_NONNULL_END
