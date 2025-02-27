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


//#include <pocket/controllers/fieldcontroller.hpp>
//using namespace std;

#import "Field.h"
#import "FieldController.h"
#import "Globals.h"
#import "Group.h"
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

@interface FieldController ()

//@property pocket::controllers::FieldController *controller;

@end


@implementation FieldController
//@synthesize controller;
@synthesize reachability;

-(instancetype)init
{
    if(self = [super init])
    {
        reachability = false;
//        controller = new(nothrow) pocket::controllers::FieldController(ONE_SESSION);
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

-(NSArray<Field*>*)getListField:(uint32_t)groupId search:(NSString*)search
{
    NSMutableArray<Field*> *ret = [NSMutableArray new];
//    uint32_t count = 0;
//    for(auto &&it : controller->getListField(groupId, [search UTF8String]))
//    {
//        [ret addObject:convert(it)];
//        count++;
//    }
    
    return ret;
}

-(void)insertField:(Field*)field callback:(void(^)(NSString*))callback
{
//    [field setReferenceSession: [NSString stringWithCString:controller->getSession().c_str() encoding:NSUTF8StringEncoding]];
//    [field setReferenceUserId: controller->getUser()->id];
//    
//    promise<string> p;
//    controller->insertField(convert(field), p, false, [callback](auto status)
//    {
//        callback([NSString stringWithCString:status.c_str() encoding:NSUTF8StringEncoding]);
//        
//    });
}

-(void)updateField:(Field*)field callback:(void(^)(NSString*))callback
{
//    [field setReferenceSession: [NSString stringWithCString:controller->getSession().c_str() encoding:NSUTF8StringEncoding]];
//    [field setReferenceUserId: controller->getUser()->id];
//    
//    promise<string> p;
//    controller->updateField(convert(field), p, false, [callback](auto status)
//    {
//        callback([NSString stringWithCString:status.c_str() encoding:NSUTF8StringEncoding]);
//        
//    });
}

-(void)delField:(Field*)field callback:(void(^)(NSString*))callback
{
//    callback(SYNCHRONIZATOR_START);
//    [field setReferenceSession: [NSString stringWithCString:controller->getSession().c_str() encoding:NSUTF8StringEncoding]];
//    [field setReferenceUserId: controller->getUser()->id];
//  
//
//    
//    try
//    {
//        pocket::controllers::FieldDao::getInstance()->del(controller->getUser(), convert(field));
//    }
//    catch(const cppcommons::Exception &e)
//    {
//        callback([NSString stringWithCString:e.what() encoding:NSUTF8StringEncoding]);
//    }
//    callback(SYNCHRONIZATOR_END);
}

-(int64_t)sizeFiled:(uint32_t)groupId
{
//	return controller->sizeFiled(groupId);
    return 0;
}

-(void)initialize
{
//    controller->initialize();
}


@end
