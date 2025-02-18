
#ifdef __OBJC__
#import <Foundation/Foundation.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface Device : NSObject

-(instancetype)init;
-(instancetype)initWithId:(uint32_t)id serverId:(uint32_t)serverId deviceSerial:(NSString*)deviceSerial token:(NSString*)token status:(int)status;

-(void)setid:(uint32_t)id;
-(uint32_t)getid;
-(void)setServerId:(uint32_t)p1;
-(uint32_t)getServerId;
-(void)setDeviceSerial:(NSString*)deviceSerial;
-(NSString*)getDeviceSerial;
-(void)setToken:(NSString*)token;
-(NSString*)getToken;
-(void)setStatus:(uint8_t)status;
-(uint8_t)getStatus;

@end

NS_ASSUME_NONNULL_END
