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
@class Group;
@class GroupField;
@class Session;

@interface GroupController : NSObject
@property BOOL reachability;
@property uint32_t lastIdGroupField;

//MARK: - System
-(instancetype)init;
-(void)initialize;

//MARK: - Group
-(nonnull NSArray<Group*>*)getListGroup:(uint32_t)groupId search:(NSString*)search;
-(int32_t)countChild:(Group*)group;
-(void)delGroup:(Group*)group callback:(void(^)(NSString*))callback;
-(void)insertGroup:(Group*)group callback:(void(^)(NSString*, Group* _Nullable))callback;
-(void)updateGroup:(Group*)group callback:(void(^)(NSString*))callback;

//MARK: - GroupField
-(nonnull NSArray<GroupField*>*)getListGroupField:(Group*)group;
-(GroupField*)insertGroupField:(GroupField*)groupField;
-(void)updateGroupField:(GroupField*)groupField;
-(void)delGroupField:(GroupField*)groupField callback:(void(^)(NSString*))callback;

//MARK: - ExportImport
-(void)xmlExport:(NSString*)fullPathFileXmlExport callback:(void(^)(BOOL))callback;
-(void)xmlImport:(NSString*)fullPathFileXmlImport callback:(void(^)(BOOL))callback;
-(void)exit;

//MARK: - Virtual list for handling new GroupField
-(void)cleanShowList;
-(void)fillShowList:(Group *)group copy:(bool)copy;
-(void)fillShowList:(Group *)group;
-(NSArray<GroupField*>*)getShowList;
-(BOOL)addToShowList:(GroupField *)groupField;
-(BOOL)delFromShowList:(uint32_t)idGroupField;
-(uint8_t)sizeShowList;

@end

NS_ASSUME_NONNULL_END
