/***************************************************************************
 *
 * Pocket
 * Copyright (C) 2018/2025 Antonio Salsi <passy.linux@zresa.it>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 ***************************************************************************/

//#include <pocket/pods/groupfield.hpp>

#import "Groupfield.h"

#include <memory>
using namespace std;

@interface GroupField ()
//@property uint32_t _id;
//@property uint32_t _serverId;
//@property uint32_t _groupId;
//@property NSString* _title;
//@property BOOL _isHidden;
//@property BOOL _synchronized;
//@property BOOL _deleted;
//@property uint32_t _referenceUserId;
//@property NSString* _referenceSession;

@end


@implementation GroupField
//@synthesize  _id;
//@synthesize _serverId;
//@synthesize _groupId;
//@synthesize _title;
//@synthesize _isHidden;
//@synthesize _synchronized;
//@synthesize _deleted;
//@synthesize _referenceUserId;
//@synthesize _referenceSession;

-(instancetype)init
{
    if(self = [super init])
    {

    }
    return self;
}

-(instancetype)initWithId:(uint32_t)id serverId:(uint32_t)serverId groupId:(uint32_t)groupId title:(NSString*)title isHidden:(BOOL)isHidden synchronized:(BOOL)synchronized deleted:(BOOL)deleted
{
    if(self = [super init])
    {
//        _id = id;
//        _serverId = serverId;
//        _groupId = groupId;
//        _title = title;
//        _isHidden = isHidden;
//        _synchronized = synchronized;
//        _deleted = deleted;
    }
    return self;
}

-(void)setid:(uint32_t)id
{
//    _id = id;
}

-(uint32_t)getid
{
//    return _id;
    return 0;
}

-(void)setServerId:(uint32_t)id
{
//    _serverId = id;
}

-(uint32_t)getServerId
{
//    return _serverId;
    return 0;
}

-(void)setGroupId:(uint32_t)groupId
{
//    _groupId = groupId;
}

-(uint32_t)getGroupId
{
//    return _groupId;
    return 0;
}

-(void)setTitle:(NSString*)title
{
//    _title = title;
}

-(NSString*)getTitle
{
//    return _title;
    return nil;
}

-(void)setIsHidden:(BOOL)isHidden
{
//    _isHidden = isHidden;
}

-(BOOL)getIsHidden
{
//    return _isHidden;
    return 0;
}

-(void)setSynchronized:(BOOL)synchronized
{
//    _synchronized = synchronized;
}

-(BOOL)getSynchronized
{
//    return _synchronized;
    return 0;
}

-(void)setDeleted:(BOOL)deleted
{
//    _deleted = deleted;
}

-(BOOL)getDeleted
{
//    return _deleted;
    return 0;
}

-(void)setReferenceUserId:(uint32_t)referenceUserId
{
//    _referenceUserId = referenceUserId;
}

-(uint32_t)getReferenceUserId
{
//    return _referenceUserId;
    return 0;
}

-(void)setReferenceSession:(NSString*)referenceSession
{
//    _referenceSession = referenceSession;
}

-(NSString*)getReferenceSession
{
//    return _referenceSession;
    return 0;
}

@end

//pocket::pods::GroupField::Ptr convert(const GroupField* groupField)
//{
//    auto &&ret = make_shared<pocket::pods::GroupField>(
//        [groupField getid]
//        ,[groupField getServerId]
//        ,[groupField getGroupId]
//        ,[[groupField getTitle] UTF8String]
//        ,[groupField getIsHidden]
//        ,[groupField getSynchronized]
//        ,[groupField getDeleted]
//    );
//    
//    ret->referenceSession = [[groupField getReferenceSession] UTF8String];
//    ret->referenceUserId = [groupField getReferenceUserId];
//    return ret;
//}

//GroupField* convert(const pocket::pods::GroupField::Ptr &groupField)
//{
//    GroupField *ret = [[GroupField alloc] init];
//    
//    [ret setid:groupField->id];
//    [ret setServerId:groupField->serverId];
//    [ret setGroupId: groupField->groupId];
//    [ret setTitle: [NSString stringWithCString:groupField->title.c_str() encoding:NSUTF8StringEncoding] ];
//    [ret setIsHidden: groupField->isHidden];
//    [ret setSynchronized: groupField->synchronized];
//    [ret setDeleted: groupField->deleted];
//    [ret setReferenceUserId: groupField->referenceUserId];
//    [ret setReferenceSession: [NSString stringWithCString:groupField->referenceSession.c_str() encoding:NSUTF8StringEncoding]];
//    
//    return ret;
//}
