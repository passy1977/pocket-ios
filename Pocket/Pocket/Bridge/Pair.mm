
#include <pocket/pods/pair.hpp>

#import "Group.h"
#import "Pair.h"

#include <memory>
using namespace std;


extern pocket::pods::Group::Ptr convert(const Group* group);
extern Group* convert(const pocket::pods::Group::Ptr &group);

@interface Pair ()
@property Group* _group;
@property NSString* _search;
@end


@implementation Pair
@synthesize  _group;
@synthesize _search;

-(instancetype)initWithGroup:(Group*)group search:(NSString*)search
{
    if(self = [super init])
    {
        _group = group;
        _search = search;
    }
    return self;
}

-(Group*)getGroup
{
    return _group;
}

-(NSString*)getSearch
{
    return _search;
}

@end

pocket::pods::Pair::Ptr convert(const Pair* pair)
{
    return make_shared<pocket::pods::Pair>(
       convert([pair getGroup])
        ,[[pair getSearch] UTF8String]
    );
}

Pair* convert(const pocket::pods::Pair::Ptr &pair)
{
    return [[Pair alloc] initWithGroup: convert(pair->group) search:[NSString stringWithCString:pair->search.c_str() encoding:NSUTF8StringEncoding]];
}
