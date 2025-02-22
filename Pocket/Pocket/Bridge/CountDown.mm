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


//#include <pocket/services/countdown.hpp>

#import "Constants.h"
#import "CountDown.h"
#import "Globals.h"
#import "Property.h"
#import "User.h"


@interface CountDown ()
//@property pocket::services::CountDown* countDown;
@end



@implementation CountDown
//@synthesize  countDown;

-(instancetype)initWithUser:( User* )user sessionTimeoutInSeconds:(int16_t)sessionTimeoutInSeconds;
{

    return self;
}

-(void)dealloc
{
//
//    if(countDown)
//    {
//        delete countDown;
//    }
}

-(void)setCallback:(void(^)(void))callback
{

}


-(void)start
{
//    countDown->start();
}

-(void)stop
{
//    countDown->stop();
}

-(void)updateTimeLeft
{
//    countDown->updateTimeLeft();
}

-(BOOL)isStarted
{
//	return countDown->isStarted();
    return false;
}

@end
