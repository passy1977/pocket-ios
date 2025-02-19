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

//#include <pocket/pods/group.hpp>

#import "Group.h"

#include <memory>
using namespace std;

@interface Group ()
//@property uint32_t _id;
//@property uint32_t _serverId;
//@property uint32_t _groupId;
//@property uint32_t _serverGroupId;
//@property NSString* _title;
//@property NSString* _icon;
//@property NSString* _note;
//@property BOOL _synchronized;
//@property BOOL _deleted;
//@property BOOL _shared;
//@property uint32_t _referenceUserId;
//@property NSString* _referenceSession;
@end


@implementation Group
//@synthesize  _id;
//@synthesize _serverId;
//@synthesize _groupId;
//@synthesize _serverGroupId;
//@synthesize _title;
//@synthesize _icon;
//@synthesize _note;
//@synthesize _synchronized;
//@synthesize _deleted;
//@synthesize _shared;
//@synthesize _referenceUserId;
//@synthesize _referenceSession;

-(instancetype)init
{
    if(self = [super init])
    {

    }
    return self;
}

-(instancetype)initWithId:(uint32_t)id serverId:(uint32_t)serverId groupId:(uint32_t)groupId serverGroupId:(uint32_t)serverGroupId title:(NSString*)title icon:(NSString*)icon note:(NSString*)note synchronized:(BOOL)synchronized deleted:(BOOL)deleted shared:(BOOL)shared
{
    if(self = [super init])
    {
//        _id = id;
//        _serverId = serverId;
//        _groupId = groupId;
//        _serverGroupId = serverGroupId;
//        _title = title;
//        _icon = icon;
//        _note = note;
//        _synchronized = synchronized;
//        _deleted = deleted;
//        _shared = shared;
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

-(void)setServerGroupId:(uint32_t)serverGroupId
{
//    _serverGroupId = serverGroupId;
}

-(uint32_t)getSerevrGroupId
{
//    return _serverGroupId;
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

-(void)setIcon:(NSString*)icon
{
//    _icon = icon;
}

-(NSString*)getIcon
{
//    return _icon;
    return nil;
}

-(void)setNote:(NSString*)note
{
//    _note = note;
}

-(NSString*)getNote
{
//    return _note;
    return nil;
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

-(void)setShared:(BOOL)shared
{
//    _shared = shared;
}

-(BOOL)getShared
{
//    return _shared;
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
//    _referenceSession = referenceSession;return 0;return 0;
}

-(NSString*)getReferenceSession
{
//    return _referenceSession;
    return nil;
}

@end

//pocket::pods::Group::Ptr convert(const Group* group)
//{
//    auto &&ret = make_shared<pocket::pods::Group>(
//        [group getid]
//        ,[group getServerId]
//        ,[group getGroupId]
//        ,[group getSerevrGroupId]
//        ,[[group getTitle] UTF8String]
//        ,[[group getIcon] UTF8String]
//        ,[[group getNote] UTF8String]
//        ,[group getSynchronized]
//        ,[group getDeleted]
//        ,[group getShared]
//    );
//    
//    ret->referenceSession = [[group getReferenceSession] UTF8String];
//    ret->referenceUserId = [group getReferenceUserId];
//    return ret;
//}

//Group* convert(const pocket::pods::Group::Ptr &group)
//{
//    Group *ret = [[Group alloc] init];
//
//    [ret setid:group->id];
//    [ret setServerId:group->serverId];
//    [ret setGroupId: group->groupId];
//    [ret setServerGroupId: group->serverGroupId];
//    [ret setTitle: [NSString stringWithCString:group->title.c_str() encoding:NSUTF8StringEncoding] ];
//    [ret setIcon: [NSString stringWithCString:group->icon.c_str() encoding:NSUTF8StringEncoding] ];
//    [ret setNote: [NSString stringWithCString:group->note.c_str() encoding:NSUTF8StringEncoding] ];
//    [ret setSynchronized: group->synchronized];
//    [ret setDeleted: group->deleted];
//    [ret setShared: group->shared];
//    [ret setReferenceUserId: group->referenceUserId];
//    [ret setReferenceSession: [NSString stringWithCString:group->referenceSession.c_str() encoding:NSUTF8StringEncoding]];
//    
//    return ret;
//}
