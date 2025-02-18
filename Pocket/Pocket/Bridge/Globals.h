#ifdef __OBJC__
#import <Foundation/Foundation.h>
#endif


NS_ASSUME_NONNULL_BEGIN

@class User;
@class Device;

@interface Globals : NSObject

-(instancetype)init;

+(Globals*)getInstance;
-(NSString*)getBasePath;
-(void)setUser:(User*)user;
-(void)setUserLastUpdate:(uint32_t)user_id user:(User*)user;

-(User* _Nullable )getUser;
-(User*)getSafeUser;
-(Device*)getDevice;
-(void)setDevice:(Device*)device;
-(NSString*)getVersion;
-(void)initSystemCrypto:(NSString*)serialNumber;
-(void)initServerCrypto:(NSString*)key;
-(void)initUserCrypto:(NSString*)key;
-(void)initialize:(NSString*)serialNumber basePath:(NSString*)basePath urlFile:(BOOL)urlFile;

@end

NS_ASSUME_NONNULL_END
