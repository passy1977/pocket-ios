
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
