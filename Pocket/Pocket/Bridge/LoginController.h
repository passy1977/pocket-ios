#ifdef __OBJC__
#import <Foundation/Foundation.h>
#endif


NS_ASSUME_NONNULL_BEGIN

@class Field;
@class User;
@class Device;
@class Globals;
@class Group;
@class GroupField;

@interface LoginController : NSObject

-(instancetype)init;

-(void)loginBiometric:(void(^)(NSString*))callback;
-(void)login:(NSString*)system deviceSerial:(NSString*)deviceSerial host:(NSString*)host hostAuthUser:(NSString*)hostAuthUser hostAuthPasswd:(NSString*)hostAuthPasswd email:(NSString*)email passwd:(NSString*)passwd callback:(void(^)(uint8_t))callback;
-(uint8_t)insertUser:(User*)user;
+(uint8_t)getStatus;

@end

NS_ASSUME_NONNULL_END
