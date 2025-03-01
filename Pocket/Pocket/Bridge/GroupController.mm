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

#import "Group.h"
#import "Field.h"
#import "GroupField.h"
#import "Session.h"

#import "Globals.h"
#import "GroupController.h"

#import "User.h"

#include "pocket-views/view-group.hpp"
#include "pocket-views/view-group-field.hpp"
using pocket::views::view;

#include "pocket-pods/group.hpp"
#include "pocket-pods/group-field.hpp"
using namespace pocket::pods;

#include "pocket-controllers/session.hpp"
using pocket::controllers::session;

extern group::ptr convert(const Group* group);
extern Group* convert(const group::ptr &field);
extern group_field::ptr convert(const GroupField* group_field);
extern GroupField* convert(const group_field::ptr &field);

@interface GroupController ()
@property view<group> *viewGroup;
@property view<group_field> *viewGroupField;
@property view<field> *viewField;
@property NSMutableDictionary<NSNumber *, NSString *> *showList;
@end


@implementation GroupController
@synthesize reachability;
@synthesize lastIdGroupField;
@synthesize viewGroup;
@synthesize viewGroupField;
@synthesize showList;

//MARK: - System
-(instancetype)init
{
    if(self = [super init])
    {
        reachability = false;
        lastIdGroupField = 0;
        viewGroup = nullptr;
        viewGroupField = nullptr;
        showList = [NSMutableDictionary new];
    }
    return self;
}

-(void)initialize
{
    viewGroup = [[Globals getInstance] getSession].session->get_view_group().get();
    viewGroupField = [[Globals getInstance] getSession].session->get_view_group_field().get();
}

//MARK: - Group
-(nonnull NSArray<Group*>*)getListGroup:(uint32_t)groupId search:(NSString*)search
{
    NSMutableArray<Group*> *ret = [NSMutableArray new];
    for(auto &&it : viewGroup->get_list(groupId, [search UTF8String]))
    {
        [ret addObject:convert(it)];
    }
    return ret;
}

-(int32_t)countChild:(Group*)group
{
    return static_cast<uint32_t>(viewGroup->get_list([group getid]).size());
}

-(void)delGroup:(Group*)group callback:(void(^)(NSString*))callback
{
    
}

-(void)insertGroup:(Group*)group callback:(void(^)(NSString*, Group* _Nullable))callback
{

}

-(void)updateGroup:(Group*)group callback:(void(^)(NSString*))callback
{

    
}

//MARK: - ExportImport
-(nonnull NSArray<GroupField*>*)getListGroupField:(Group*)group
{
    NSMutableArray<GroupField*> *ret = [NSMutableArray new];
    for(auto &&it : viewGroupField->get_list([group getGroupId]))
    {
        [ret addObject:convert(it)];
    }
    return ret;
}


-(GroupField*)insertGroupField:(GroupField*)groupField
{
//    [groupField setReferenceSession: [NSString stringWithCString:controller->getSession().c_str() encoding:NSUTF8StringEncoding]];
//    [groupField setReferenceUserId: controller->getUser()->id];
//    return convert(controller->insertGroupField(convert(groupField)));
    lastIdGroupField = 0; //todo: handle last id
    return nil;
}

-(void)updateGroupField:(GroupField*)groupField
{
//    [groupField setReferenceSession: [NSString stringWithCString:controller->getSession().c_str() encoding:NSUTF8StringEncoding]];
//    [groupField setReferenceUserId: controller->getUser()->id];
//    controller->updateGroupField(convert(groupField));
}

-(void)delGroupField:(GroupField*)groupField callback:(void(^)(NSString*))callback
{
//    callback(SYNCHRONIZATOR_START);
//    [groupField setReferenceSession: [NSString stringWithCString:controller->getSession().c_str() encoding:NSUTF8StringEncoding]];
//    [groupField setReferenceUserId: controller->getUser()->id];
//    controller->delGroupField(convert(groupField));
//    callback(SYNCHRONIZATOR_END);
}


//MARK: - Generic

-(void)xmlExport:(NSString*)fullPathFileXmlExport callback:(void(^)(BOOL))callback
{

}

-(void)xmlImport:(NSString*)fullPathFileXmlImport callback:(void(^)(BOOL))callback
{

}

-(void)exit
{

}


//MARK: - Virtual list for handling new GroupField
-(void)cleanShowList
{
}

-(void)fillShowList:(Group *)group copy:(bool)copy
{
}

-(void)fillShowList:(Group *)group
{
}

-(NSArray<GroupField*>*)getShowList
{
    return 0;

}

-(BOOL)addToShowList:(GroupField *)groupField
{
//    return controller->addToShowList(convert(groupField));
    return 0;
}

-(BOOL)delFromShowList:(uint32_t)idGroupField
{
//    return controller->delFromShowList(idGroupField);
    return 0;
}

-(uint8_t)sizeShowList
{
//    return controller->sizeShowList();
    return 0;
}

@end
