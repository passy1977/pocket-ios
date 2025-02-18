#ifdef __OBJC__
#import <Foundation/Foundation.h>
#endif


NS_ASSUME_NONNULL_BEGIN

@class Device;

@interface User : NSObject

-(instancetype)init;
-(instancetype)initWithId:(uint32_t)id serverId:(uint32_t)serverId email:(NSString*)email name:(NSString*)name passwd:(NSString*)passwd host:(NSString*)host hostAuthUser:(NSString*)hostAuthUser hostAuthPasswd:(NSString*)hostAuthPasswd dateTimeLastUpdate:(NSString*)dateTimeLastUpdate status:(uint8_t)status;

-(void)setid:(uint32_t)id;
-(uint32_t)getid;
-(void)setServerId:(uint32_t)id;
-(uint32_t)getServerId;
-(void)setEmail:(NSString*)email;
-(NSString*)getEmail;
-(void)setName:(NSString*)name;
-(NSString*)getName;
-(void)setPasswd:(NSString*)passwd;
-(NSString*)getPasswd;
-(NSString*)getHost;
-(void)setHost:(NSString*)host;
-(NSString*)getHostAuthUser;
-(void)setHostAuthUser:(NSString*)hostAuthUser;
-(NSString*)getHostAuthPasswd;
-(void)setHostAuthPasswd:(NSString*)hostAuthPasswd;
-(NSString*)getDateTimeLastUpdate;
-(void)setDateTimeLastUpdate:(NSString*)dateTimeLastUpdate;
-(void)setStatus:(uint8_t)status;
-(uint8_t)getStatus;
-(BOOL)isEmpty;

-(void)setReferenceDevice:(Device* _Nullable)referenceDevice;
-(Device* _Nullable)getReferenceDevice;
-(void)setReferenceSession:(NSString*)referenceSession;
-(NSString*)getReferenceSession;

@end

NS_ASSUME_NONNULL_END
