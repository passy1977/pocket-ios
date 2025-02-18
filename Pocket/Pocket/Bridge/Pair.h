#ifdef __OBJC__
#import <Foundation/Foundation.h>
#endif


NS_ASSUME_NONNULL_BEGIN

@class Group;

@interface Pair : NSObject

-(instancetype)initWithGroup:(Group*)group search:(NSString*)search;

-(Group*)getGroup;
-(NSString*)getSearch;

@end

NS_ASSUME_NONNULL_END
