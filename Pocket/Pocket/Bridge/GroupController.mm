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

//#include <pocket/controllers/groupcontroller.hpp>
#import "Constants.h"
#import "Field.h"
#import "Globals.h"
#import "Group.h"
#import "GroupController.h"
#import "GroupField.h"
#import "User.h"

//extern pocket::pods::Device::Ptr convert(const Device* device);
//extern Device* convert(const pocket::pods::Device::Ptr &group);
//extern pocket::pods::User::Ptr convert(const User* user);
//extern User* convert(const pocket::pods::User::Ptr &user);
//extern pocket::pods::Field::Ptr convert(const Field* group);
//extern Field* convert(const pocket::pods::Field::Ptr &group);
//extern pocket::pods::Group::Ptr convert(const Group* group);
//extern Group* convert(const pocket::pods::Group::Ptr &group);
//extern pocket::pods::GroupField::Ptr convert(const GroupField* groupField);
//extern GroupField* convert(const pocket::pods::GroupField::Ptr &groupField);

@interface GroupController ()

//@property pocket::controllers::GroupController *controller;

@end


@implementation GroupController
//@synthesize controller;

-(instancetype)init
{
    if(self = [super init])
    {
//        controller = new(nothrow) pocket::controllers::GroupController(ONE_SESSION);
//        if(controller == nullptr)
//        {
//            return Nil;
//        }
    }
    return self;
}

-(void)dealloc
{

//    if(controller)
//    {
//        delete controller;
//    }
}


-(void)setReachability:(BOOL)reachability
{
//    controller->setReachability(reachability);
}

-(NSArray<GroupField*>*)getListGroupField:(Group*)group
{
//    NSMutableArray<GroupField*> *ret = [NSMutableArray new];
//    uint32_t count = 0;
//    for(auto &&it : controller->getListGroupField(convert(group)))
//    {
//        [ret addObject:convert(it)];
//        count++;
//    }
//    
//    return ret;
    return nil;
}

-(NSArray<GroupField*>*)getAllGroupField
{
//    NSMutableArray<GroupField*> *ret = [NSMutableArray new];
//    uint32_t count = 0;
//    for(auto &&it : controller->getAllGroupField())
//    {
//        [ret addObject:convert(it)];
//        count++;
//    }
//    
//    return ret;
    return nil;
}

-(NSArray<GroupField*>*)getListGroupFieldWithGroupId:(uint32_t)groupId
{
//    NSMutableArray<GroupField*> *ret = [NSMutableArray new];
//    uint32_t count = 0;
//    for(auto &&it : controller->getListGroupFieldWithGroupId(groupId))
//    {
//        [ret addObject:convert(it)];
//        count++;
//    }
//    
//    return ret;
    return nil;
}

-(GroupField*)insertGroupField:(GroupField*)groupField
{
//    [groupField setReferenceSession: [NSString stringWithCString:controller->getSession().c_str() encoding:NSUTF8StringEncoding]];
//    [groupField setReferenceUserId: controller->getUser()->id];
//    return convert(controller->insertGroupField(convert(groupField)));
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

-(NSArray<Group*>*)getListGroup:(uint32_t)groupId search:(NSString*)search
{
//    NSMutableArray<Group*> *ret = [NSMutableArray new];
//    uint32_t count = 0;
//    for(auto &&it : controller->getListGroup(groupId, [search UTF8String]))
//    {
//        [ret addObject:convert(it)];
//        count++;
//    }
//    
//    return ret;
    return nil;
}

-(uint32_t)getLastIdGroupField
{
//    return controller->getLastIdGroupField();
    return 0;
}

-(uint32_t)getLastIdGroupField:(User*)user
{
//    return controller->getLastIdGroupField(convert(user));
    return 0;
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

-(uint32_t)getLastIdGroup
{
    return 0;
}

-(uint32_t)getLastIdGroup:(User*)user
{
    return 0;
}

-(int64_t)countChild:(Group*)group
{
    return 0;
}

-(void)xmlExport:(NSString*)fullPathFileXmlExport callback:(void(^)(BOOL))callback
{

}

-(void)xmlImport:(NSString*)fullPathFileXmlImport callback:(void(^)(BOOL))callback
{

}

-(void)exit
{

}

-(void)initialize
{

}

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
