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


namespace
{
    Globals* singleton = Nil;
}


@interface Globals ()
//@property pocket::Globals* globals;
@end

@implementation Globals
//@synthesize  globals;

-(instancetype)init
{
    if(self = [super init])
    {

    }
    return self;
}

+(Globals*)getInstance
{
    if(singleton == Nil)
    {

    }
    return singleton;
}

-(NSString*)getBasePath
{
    return @"";
}

-(void)setUser:(User*)user
{

}

-(void)setUserLastUpdate:(uint32_t)user_id user:(User*)user
{
    
}


-(User* _Nullable )getUser
{
    return nil;
}

-(User*)getSafeUser
{
    return [User new];
}

-(Device*)getDevice
{
    return nil;
}

-(void)setDevice:(Device*)device
{
}

-(NSString*)getVersion
{
    return @"";
}

-(void)initSystemCrypto:(NSString*)serialNumber
{
}

-(void)initServerCrypto:(NSString*)key
{
}

-(void)initUserCrypto:(NSString*)key
{
}

-(void)initialize:(NSString*)serialNumber basePath:(NSString*)basePath urlFile:(BOOL)urlFile
{

}

@end
