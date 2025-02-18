#ifdef __OBJC__
#import <Foundation/Foundation.h>
#endif


NS_ASSUME_NONNULL_BEGIN

@interface Group : NSObject

-(instancetype)init;
-(instancetype)initWithId:(uint32_t)id serverId:(uint32_t)serverId groupId:(uint32_t)groupId serverGroupId:(uint32_t)serverGroupId title:(NSString*)title icon:(NSString*)icon note:(NSString*)note synchronized:(BOOL)synchronized deleted:(BOOL)deleted shared:(BOOL)shared;

-(void)setid:(uint32_t)id;
-(uint32_t)getid;
-(void)setServerId:(uint32_t)id;
-(uint32_t)getServerId;
-(void)setGroupId:(uint32_t)groupId;
-(uint32_t)getGroupId;
-(void)setServerGroupId:(uint32_t)serverGroupId;
-(uint32_t)getSerevrGroupId;
-(void)setTitle:(NSString*)title;
-(NSString*)getTitle;
-(void)setIcon:(NSString*)icon;
-(NSString*)getIcon;
-(void)setNote:(NSString*)note;
-(NSString*)getNote;
-(void)setSynchronized:(BOOL)synchronized;
-(BOOL)getSynchronized;
-(void)setDeleted:(BOOL)deleted;
-(BOOL)getDeleted;
-(void)setShared:(BOOL)shared;
-(BOOL)getShared;

-(void)setReferenceUserId:(uint32_t)referenceUserId;
-(uint32_t)getReferenceUserId;
-(void)setReferenceSession:(NSString*)referenceSession;
-(NSString*)getReferenceSession;

@end

NS_ASSUME_NONNULL_END
