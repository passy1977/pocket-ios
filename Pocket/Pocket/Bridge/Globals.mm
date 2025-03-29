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



#import "Globals.h"
#import "User.h"
#import "Constants.h"

#include "pocket/globals.hpp"
using namespace pocket;

#include "pocket-controllers/session.hpp"
using controllers::session;

#include "pocket-services/crypto.hpp"
using namespace services;

#include "pocket-pods/user.hpp"
using pods::user;

#include <memory>
using namespace std;

#ifndef DEVICE_AES_CBC_IV
#error XCode config issue, not set Sercets.xcconfig and DEVICE_AES_CBC_IV macro
#endif

user::ptr convert(const User* user);
User* convert(const user::ptr &user);

namespace
{

Globals* singleton = nullptr;
constexpr char APP_TAG[] = "Globals";

}
 
@interface Globals ()
@property class session* session;
@property class aes* aes;
@end

@implementation Globals
@synthesize session;
@synthesize user;
@synthesize aes;

-(instancetype)init
{
    if(self = [super init])
    {
        session = nullptr;
        user = nullptr;
        aes = nullptr;
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
    
    if(aes)
    {
        delete aes;
        aes = nullptr;
    }

}

+(Globals*)shared
{
    if(singleton == nullptr)
    {
        singleton = [Globals new];
    }
    return singleton;
}

-(BOOL)initialize:(nonnull const NSString*)basePath
       configJson:(nullable const NSString*)configJson
           passwd:(nonnull const NSString*)passwd
{
    if(self.session && self.aes)
    {
        return true;
    }
    
    const NSString* deviceStr = [[NSUserDefaults standardUserDefaults] stringForKey: KEY_DEVICE];
    if(deviceStr)
    {
        try
        {
            aes = new(nothrow) class aes(DEVICE_AES_CBC_IV, [passwd UTF8String]);
            if(aes == nullptr)
            {
                error(APP_TAG, "Impossbile alloc aes");
                return false;
            }
            
            session = new(nothrow) class session(aes->decrypt([deviceStr UTF8String]), [basePath UTF8String]);
            if(session == nullptr)
            {
                if(aes)
                {
                    delete aes;
                    aes = nullptr;
                }
                error(APP_TAG, "Impossbile alloc session");
                return false;
            }
            
            session->init();
            return true;
        }
        catch (const runtime_error& e)
        {
            if(session)
            {
                delete session;
                session = nullptr;
            }
            
            if(aes)
            {
                delete aes;
                aes = nullptr;
            }
            
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey: KEY_DEVICE];
//            [[NSUserDefaults standardUserDefaults] synchronize];
            error(APP_TAG, e.what());
            return false;
        }
    }
    else
    {
        //no encrypt configJson and not stored
        
        if (configJson == nullptr)
        {
            error(APP_TAG, "configJson == nullptr");
            return false;
        }
        
        
        try
        {
            session = new(nothrow) class session([configJson UTF8String], [basePath UTF8String]);
            if(session == nullptr)
            {
                error(APP_TAG, "Impossbile alloc session");
                return false;
            }
            session->init();
            
            aes = new(nothrow) class aes(DEVICE_AES_CBC_IV, [passwd UTF8String]);
            if(aes == nullptr)
            {
                if(session)
                {
                    delete session;
                    session = nullptr;
                }
                error(APP_TAG, "Impossbile alloc aes");
                return false;
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithCString:aes->encrypt([configJson UTF8String]).c_str() encoding:NSUTF8StringEncoding] forKey: KEY_DEVICE];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return true;
        }
        catch (const runtime_error& e)
        {
            if(session)
            {
                delete session;
                session = nullptr;
            }
            
            if(aes)
            {
                delete aes;
                aes = nullptr;
            }
            error(APP_TAG, e.what());
            return false;
        }
    }
}

-(Stat)login:(nullable const NSString*)email
      passwd:(nullable const NSString*)passwd
{
    if(email == nullptr || passwd == nullptr)
    {
        return Stat::ERROR;
    }
    
    extern User* convert(const user::ptr &user);
    
    try
    {
        session->set_synchronizer_timeout(SYNCHRONIZER_TIMEOUT);
        session->set_synchronizer_connect_timeout(SYNCHRONIZER_CONNECT_TIMEOUT);
        auto&& userOpt = session->login([email UTF8String], [passwd UTF8String], POCKET_ENABLE_AES);
        if(userOpt)
        {
            user = convert(*userOpt);
            
            session->send_data(userOpt);
            return OK;
        }
        else
        {
            return static_cast<Stat>(session->get_status());
        }
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return static_cast<Stat>(session->get_status());
    }
}

-(Stat)logout:(BOOL)softLogout
{
    try
    {
        
        session->set_synchronizer_timeout(SYNCHRONIZER_TIMEOUT);
        session->set_synchronizer_connect_timeout(SYNCHRONIZER_CONNECT_TIMEOUT);
        if(!softLogout)
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey: KEY_DEVICE];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return session->logout(convert(user)) ? OK : static_cast<Stat>(session->get_status());
        }
        else
        {
            return session->soft_logout(convert(user)) ? OK : static_cast<Stat>(session->get_status());
        }
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return static_cast<Stat>(session->get_status());
    }
}

-(Stat)changePasswd:(nonnull const NSString*)fullPathFile newPasswd:(nonnull const NSString*)newPasswd
{
    try
    {
        
        const NSString* deviceStr = [[NSUserDefaults standardUserDefaults] stringForKey: KEY_DEVICE];
        
        session->set_synchronizer_timeout(SYNCHRONIZER_TIMEOUT);
        session->set_synchronizer_connect_timeout(0);
        if( auto&& userOpt = session->change_passwd(convert(user), [fullPathFile UTF8String], [newPasswd UTF8String], POCKET_ENABLE_AES); userOpt)
        {
            user = convert(*userOpt);

            if(aes)
            {
                delete aes;
                aes = nullptr;
            }
            aes = new(nothrow) class aes(DEVICE_AES_CBC_IV, [newPasswd UTF8String]);
            if(aes == nullptr)
            {
                if(session)
                {
                    delete session;
                    session = nullptr;
                }
                error(APP_TAG, "Impossbile alloc aes");
                return ERROR;
            }
            

            [[NSUserDefaults standardUserDefaults] removeObjectForKey: KEY_DEVICE];
            [[NSUserDefaults standardUserDefaults] setObject:deviceStr forKey: KEY_DEVICE];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return OK;
        }
        else
        {
            return static_cast<Stat>(session->get_status());
        }
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return static_cast<Stat>(session->get_status());
    }
}

-(BOOL)copyGroup:(uint32_t)groupIdSrc groupIdDst:(uint32_t)groupIdDst copy:(BOOL)move
{
    try
    {
        bool ret = session->copy_group(convert(user), static_cast<int64_t>(groupIdSrc), static_cast<int64_t>(groupIdDst), move);
        if(ret)
        {
            if(auto u = session->send_data(convert(user)); u)
            {
                user = convert(*u);
            }
            else
            {
                ret = false;
            }
        }
        
        return ret;
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return false;
    }
}

-(BOOL)copyField:(uint32_t)fieldIdSrc groupIdDst:(uint32_t)groupIdDst copy:(BOOL)move
{
    try
    {
        bool ret = session->copy_field(convert(user), static_cast<int64_t>(fieldIdSrc), static_cast<int64_t>(groupIdDst), move);
        if(ret)
        {
            if(auto u = session->send_data(convert(user)); u)
            {
                user = convert(*u);
            }
            else
            {
                ret = false;
            }
        }
        
        return ret;
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return false;
    }
}

-(Stat)sendData
{
    try
    {
        
        session->set_synchronizer_timeout(SYNCHRONIZER_TIMEOUT);
        session->set_synchronizer_connect_timeout(SYNCHRONIZER_CONNECT_TIMEOUT);
        if(auto&& user = session->send_data(convert(self.user)); user)
        {
            self.user = convert(user.value());
            return OK;
        }
        else
        {
            return static_cast<Stat>(session->get_status());
        }
    }
    catch(const runtime_error& e)
    {
        error(APP_TAG, e.what());
        return static_cast<Stat>(session->get_status());
    }
}

-(nullable const User *)getUser
{
    return user;
}

-(nonnull void *)getSession
{
    return session;
}

@end
