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
#import "Group.h"
#import "Pair.h"
#import "StackNavigator.h"

//extern pocket::pods::Group::Ptr convert(const Group* group);
//extern Group* convert(const pocket::pods::Group::Ptr &group);
//extern pocket::pods::Pair::Ptr convert(const Pair* pair);
//extern Pair* convert(const pocket::pods::Pair::Ptr &pair);

namespace
{
    StackNavigator* singleton = Nil;
}


@interface StackNavigator ()
//@property pocket::StackNavigator* stackNavigator;
@end



@implementation StackNavigator
//@synthesize  stackNavigator;

-(instancetype)init
{
    if(self = [super init])
    {
//        stackNavigator = pocket::StackNavigator::getInstance().get();
    }
    return self;
}

-(void)push:(Group*)group search:(NSString*)search
{
//    stackNavigator->push(ONE_SESSION, convert(group), [search UTF8String]);
}

-(Pair*)get
{
//    return convert(stackNavigator->get(ONE_SESSION));
    return nil;
    
}

-(Pair*)pop
{
//    return convert(stackNavigator->pop(ONE_SESSION));
    return nil;
}

-(int64_t)size
{
//    return stackNavigator->size(ONE_SESSION);
    return 0;

}

-(void)clear
{
//    stackNavigator->clear(ONE_SESSION);
}

+(StackNavigator*)getInstance
{
//    if(singleton == Nil)
//    {
//        singleton = [StackNavigator new];
//    }
//    return singleton;
    return nil;
}

@end
