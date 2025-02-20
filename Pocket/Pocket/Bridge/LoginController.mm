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

//#include <pocket/controllers/logincontroller.hpp>
//using namespace std;

#import "Field.h"
#import "Globals.h"
#import "Group.h"
#import "Groupfield.h"
#import "LoginController.h"
#import "User.h"
#import "Constants.h"

//extern pocket::pods::User::Ptr convert(const User* user);

@interface LoginController ()

//@property pocket::controllers::LoginController *controller;

@end


@implementation LoginController
//@synthesize controller;


-(instancetype)init
{
    if(self = [super init])
    {
//        controller = new(nothrow) pocket::controllers::LoginController(ONE_SESSION);
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

-(void)loginBiometric:(void(^)(NSString*))callback
{
//    controller->loginBiometric([callback](auto pwd)
//    {
//        callback([NSString stringWithCString:pwd.c_str() encoding:NSUTF8StringEncoding]);
//    });
}

-(void)login:(NSString*)system deviceSerial:(NSString*)deviceSerial host:(NSString*)host hostAuthUser:(NSString*)hostAuthUser hostAuthPasswd:(NSString*)hostAuthPasswd email:(NSString*)email passwd:(NSString*)passwd callback:(void(^)(uint8_t))callback
{
//    promise<pocket::controllers::LoginController::Status> p;
//    auto &&t = controller->login([system UTF8String]
//                      , [deviceSerial UTF8String]
//                      , [host UTF8String]
//                      , [hostAuthUser UTF8String]
//                      , [hostAuthPasswd UTF8String]
//                      , [email UTF8String]
//                      , [passwd UTF8String]
//                      , p);
//    
//    t.join();
//    
//    callback(static_cast<uint8_t>(p.get_future().get()));
}

-(uint8_t)insertUser:(User*)user
{
//    auto &&cppUser = convert(user);
//    promise<pocket::controllers::LoginController::Status> p;
//    
//    auto &&t = controller->insertUser(cppUser, p);
//    
    return 0;
}

+(uint8_t)getStatus
{
//    return static_cast<uint8_t>(pocket::controllers::LoginController::getStatus());
    return 1;
}

@end
