#ifdef __OBJC__
#import <Foundation/Foundation.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Group;
@class Pair;

@interface StackNavigator : NSObject

-(instancetype)init;

-(void)push:(Group*)group search:(NSString*)search;
-(Pair*)get;
-(Pair*)pop;
-(int64_t)size;
-(void)clear;
+(StackNavigator*)getInstance;

@end

NS_ASSUME_NONNULL_END
