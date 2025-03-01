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
#import "Session.h"

#include "pocket-pods/field.hpp"
using namespace pocket::pods;

#include "pocket-views/view-field.hpp"
using pocket::views::view;

#include "pocket-controllers/session.hpp"
using pocket::controllers::session;

extern field::ptr convert(const Field* group_field);
extern Field* convert(const field::ptr &field);

@interface FieldController ()
@property view<field> *viewField;
@end


@implementation FieldController
@synthesize reachability;
@synthesize viewField;

-(instancetype)init
{
    if(self = [super init])
    {
        reachability = false;
        viewField = nullptr;
    }
    return self;
}

-(void)initialize
{
    viewField = [[Globals getInstance] getSession].session->get_view_field().get();
}


-(NSArray<Field*>*)getListField:(uint32_t)groupId search:(NSString*)search
{
    NSMutableArray<Field*> *ret = [NSMutableArray new];
    for(auto &&it : viewField->get_list(groupId, [search UTF8String]))
    {
        [ret addObject:convert(it)];
    }
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

@end
