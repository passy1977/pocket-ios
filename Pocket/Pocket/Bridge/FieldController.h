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

@interface FieldController : NSObject

-(instancetype)init;

-(NSArray<Field*>*)getListField:(uint32_t)groupId search:(NSString*)search;
-(void)insertField:(Field*)field callback:(void(^)(NSString*))callback;
-(void)updateField:(Field*)field callback:(void(^)(NSString*))callback;
-(void)delField:(Field*)field callback:(void(^)(NSString*))callback;
-(int64_t)sizeFiled:(uint32_t)groupId;
-(void)initialize;
-(void)setReachability:(BOOL)reachability;

@end

NS_ASSUME_NONNULL_END
