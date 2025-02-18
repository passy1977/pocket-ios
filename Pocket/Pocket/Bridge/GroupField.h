#ifdef __OBJC__
#import <Foundation/Foundation.h>
#endif


NS_ASSUME_NONNULL_BEGIN

@interface GroupField : NSObject

-(instancetype)init;
-(instancetype)initWithId:(uint32_t)id serverId:(uint32_t)serverId groupId:(uint32_t)groupId title:(NSString*)title isHidden:(BOOL)isHidden synchronized:(BOOL)synchronized deleted:(BOOL)deleted;

-(void)setid:(uint32_t)id;
-(uint32_t)getid;
-(void)setServerId:(uint32_t)id;
-(uint32_t)getServerId;
-(void)setGroupId:(uint32_t)groupId;
-(uint32_t)getGroupId;
-(void)setTitle:(NSString*)title;
-(NSString*)getTitle;
-(void)setIsHidden:(BOOL)isHidden;
-(BOOL)getIsHidden;
-(void)setSynchronized:(BOOL)synchronized;
-(BOOL)getSynchronized;
-(void)setDeleted:(BOOL)deleted;
-(BOOL)getDeleted;

-(void)setReferenceUserId:(uint32_t)referenceUserId;
-(uint32_t)getReferenceUserId;
-(void)setReferenceSession:(NSString*)referenceSession;
-(NSString*)getReferenceSession;

@end

NS_ASSUME_NONNULL_END
