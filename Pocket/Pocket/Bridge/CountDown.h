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

@class Property;
@class User;
@class Device;
@class Globals;

@interface CountDown : NSObject

-(instancetype)initWithUser:( User* )user sessionTimeoutInSeconds:(int16_t)sessionTimeoutInSeconds;

-(void)setCallback:(void(^)(void))callback;
-(void)start;
-(void)stop;
-(void)updateTimeLeft;
-(BOOL)isStarted;

@end

NS_ASSUME_NONNULL_END
