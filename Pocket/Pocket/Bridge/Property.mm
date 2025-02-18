
//#include <pocket/pods/property.hpp>

#import "Property.h"

#include <memory>
using namespace std;

@interface Property ()
@property uint32_t _id;
@property uint32_t _serverId;
@property NSString* _key;
@property NSString* _value;
@end


@implementation Property
@synthesize  _id;
@synthesize _serverId;
@synthesize _key;
@synthesize _value;

-(instancetype)init
{
    if(self = [super init])
    {

    }
    return self;
}

-(instancetype)initWithId:(uint32_t)id serverId:(uint32_t)serverId key:(NSString*)key value:(NSString*)value
{
    if(self = [super init])
    {
        _id = id;
        _serverId = serverId;
        _key = key;
        _value = value;
    }
    return self;
}

-(void)setid:(uint32_t)id
{
    _id = id;
}

-(uint32_t)getid
{
	return _id;
}

-(void)setServerId:(uint32_t)id
{
    _serverId = id;
}

-(uint32_t)getServerId
{
	return _serverId;
}

-(void)setKey:(NSString*)key
{
    _key = key;
}

-(NSString*)getKey
{
	return _key;
}

-(void)setValue:(NSString*)value
{
    _value = value;
}

-(NSString*)getValue
{
    return _value;
}

@end

//pocket::pods::Property::Ptr convert(const Property* user)
//{
//    return make_shared<pocket::pods::Property>(
//        [user getid]
//        ,[user getServerId]
//        ,[[user getKey] UTF8String]
//        ,[[user getValue] UTF8String]
//    );
//}

//Property* convert(const pocket::pods::Property::Ptr &property)
//{
//    Property *ret = [[Property alloc] init];
//    
//    [ret setid:property->id];
//    [ret setServerId:property->serverId];
//    [ret setKey: [NSString stringWithCString:property->key.c_str() encoding:NSUTF8StringEncoding] ];
//    [ret setValue: [NSString stringWithCString:property->value.c_str() encoding:NSUTF8StringEncoding] ];
//    
//    return ret;
//}
