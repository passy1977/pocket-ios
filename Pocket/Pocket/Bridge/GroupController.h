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

@interface GroupController : NSObject

-(instancetype)init;

-(void)setReachability:(BOOL)reachability;
-(NSArray<GroupField*>*)getListGroupField:(Group*)group;
-(NSArray<GroupField*>*)getAllGroupField;
-(NSArray<GroupField*>*)getListGroupFieldWithGroupId:(uint32_t)groupId;
-(GroupField*)insertGroupField:(GroupField*)groupField;
-(void)updateGroupField:(GroupField*)groupField;
-(void)delGroupField:(GroupField*)groupField callback:(void(^)(NSString*))callback;
-(NSArray<Group*>*)getListGroup:(uint32_t)groupId search:(NSString*)search;
-(uint32_t)getLastIdGroupField;
-(uint32_t)getLastIdGroupField:(User*)user;
-(void)delGroup:(Group*)group callback:(void(^)(NSString*))callback;
-(void)insertGroup:(Group*)group callback:(void(^)(NSString*, Group* _Nullable))callback;
-(void)updateGroup:(Group*)group callback:(void(^)(NSString*))callback;
-(uint32_t)getLastIdGroup;
-(uint32_t)getLastIdGroup:(User*)user;
-(int64_t)countChild:(Group*)group;
-(void)xmlExport:(NSString*)fullPathFileXmlExport callback:(void(^)(BOOL))callback;
-(void)xmlImport:(NSString*)fullPathFileXmlImport callback:(void(^)(BOOL))callback;
-(void)exit;
-(void)initialize;
-(void)cleanShowList;
-(void)fillShowList:(Group *)group copy:(bool)copy;
-(void)fillShowList:(Group *)group;
-(NSArray<GroupField*>*)getShowList;
-(BOOL)addToShowList:(GroupField *)groupField;
-(BOOL)delFromShowList:(uint32_t)idGroupField;
-(uint8_t)sizeShowList;

@end

NS_ASSUME_NONNULL_END
