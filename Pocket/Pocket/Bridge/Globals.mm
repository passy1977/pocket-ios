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


#import "Constants.h"
#import "Globals.h"
#import "User.h"


#include <pocket/globals.hpp>
using namespace pocket;

#include <pocket-controllers/session.hpp>
using controllers::session;

#include <pocket-services/crypto.hpp>
using namespace services;

#include <pocket-pods/user.hpp>
using pods::user;

#include <memory>
using namespace std;

namespace
{

Globals* singleton = nullptr;
constexpr char APP_TAG[] = "Globals";

}

 
@interface Globals ()
@property class session* session;
@property User* user;
@end

@implementation Globals
@synthesize session;
@synthesize user;

-(instancetype)init
{
    if(self = [super init])
    {
        session = nullptr;
        user = nullptr;
    }
    return self;
}

- (void)dealloc
{
    if(session)
    {
        delete session;
        session = nullptr;
    }

}

+(Globals*)getInstance
{
    if(singleton == nullptr)
    {
        singleton = [[Globals new] init];
    }
    return singleton;
}

-(BOOL)initialize:(nonnull const NSString*)basePath
       configJson:(nullable const NSString*)configJson
           passwd:(nonnull const NSString*)passwd
{
    
    
    NSString* deviceStr = [[NSUserDefaults standardUserDefaults] stringForKey: KEY_DEVICE];
    if(deviceStr)
    {
        try
        {
            session = new(nothrow) class session([deviceStr UTF8String], [basePath UTF8String]);
            if(session == nullptr)
            {
                error(APP_TAG, "Impossbile alloc session");
                return false;
            }
            else
            {
                return true;
            }
        }
        catch (const runtime_error& e)
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey: KEY_DEVICE];
            error(APP_TAG, e.what());
            return false;
        }
    }
    else
    {
        if (configJson == nullptr)
        {
            error(APP_TAG, "configJson == nullptr");
            return false;
        }
        
        NSString* ivValue = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"DEVICE_AES_CBC_IV"];
        if (ivValue)
        {
            try
            {
                session = new(nothrow) class session([configJson UTF8String], [basePath UTF8String]);
            }
            catch (const runtime_error& e)
            {

                error(APP_TAG, e.what());
                return false;
            }

            if(session == nullptr)
            {
                error(APP_TAG, "Impossbile alloc session");
                return false;
            }
            else
            {
                string encrypted;
                try
                {
                    class aes aes([ivValue UTF8String], [passwd UTF8String]);
                    
                    encrypted = aes.encrypt(encrypted);
                }
                catch(const runtime_error& e)
                {
                    error(APP_TAG, e.what());
                    return false;
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithCString:encrypted.c_str() encoding:NSUTF8StringEncoding] forKey: KEY_DEVICE];
                [[NSUserDefaults standardUserDefaults] synchronize];
                return true;
            }
            
        }
        else
        {
            error(APP_TAG, "Key 'DEVICE_AES_CBC_IV' not found in Info.plist.");
        }
        return false;
    }
}

-(Stat)login:(nonnull const NSString*)email
      passwd:(nonnull const NSString*)passwd
{
    extern User* convert(const user::ptr &user);
    
    auto&& userOpt = session->login([email UTF8String], [passwd UTF8String]);
    if(userOpt.has_value())
    {
        user = convert(*userOpt);
        return OK;
    }
    else
    {
        return static_cast<Stat>(session->get_status());
    }
}

-(nullable const User *)getUser
{
    return user;
}

@end
