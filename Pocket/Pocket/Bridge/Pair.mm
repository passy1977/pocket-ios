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

//#include <pocket/pods/pair.hpp>

#import "Group.h"
#import "Pair.h"

#include <memory>
using namespace std;


//extern pocket::pods::Group::Ptr convert(const Group* group);
//extern Group* convert(const pocket::pods::Group::Ptr &group);

@interface Pair ()
//@property Group* _group;
//@property NSString* _search;
@end


@implementation Pair
//@synthesize  _group;
//@synthesize _search;

-(instancetype)initWithGroup:(Group*)group search:(NSString*)search
{
    if(self = [super init])
    {
//        _group = group;
//        _search = search;
    }
    return self;
}

-(Group*)getGroup
{
//    return _group;
    return nil;
}

-(NSString*)getSearch
{
//    return _search;
    return nil;
}

@end

//pocket::pods::Pair::Ptr convert(const Pair* pair)
//{
////    return make_shared<pocket::pods::Pair>(
////       convert([pair getGroup])
////        ,[[pair getSearch] UTF8String]
////    );
//}
//
//Pair* convert(const pocket::pods::Pair::Ptr &pair)
//{
////    return [[Pair alloc] initWithGroup: convert(pair->group) search:[NSString stringWithCString:pair->search.c_str() encoding:NSUTF8StringEncoding]];
//}
