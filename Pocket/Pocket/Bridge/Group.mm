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

#import "Group.h"

#include "pocket-pods/group.hpp"
using pocket::pods::group;

#include <memory>
using namespace std;

@interface Group ()
@property uint32_t _id;
@property uint32_t _serverId;
@property uint32_t _userId;
@property uint32_t _groupId;
@property uint32_t _serverGroupId;
@property uint32_t _groupFieldId;
@property uint32_t _serverGroupFieldId;
@property NSString* _title;
@property NSString* _icon;
@property NSString* _note;
@property BOOL _isHidden;
@property BOOL _synchronized;
@property BOOL _deleted;
@property uint64_t _timestampCreation;
@end


@implementation Group
@synthesize _id;
@synthesize _serverId;
@synthesize _userId;
@synthesize _groupId;
@synthesize _serverGroupId;
@synthesize _groupFieldId;
@synthesize _serverGroupFieldId;
@synthesize _title;
@synthesize _icon;
@synthesize _note;
@synthesize _isHidden;
@synthesize _synchronized;
@synthesize _deleted;
@synthesize _timestampCreation;

-(instancetype)init
{
    if(self = [super init])
    {

    }
    return self;
}

-(instancetype)initWithId:(uint32_t)id
                serverId:(uint32_t)serverId
                userId:(uint32_t)userId
                groupId:(uint32_t)groupId
                serverGroupId:(uint32_t)serverGroupId
                groupFieldId:(uint32_t)groupFieldId
                serverGroupFieldId:(uint32_t)serverGroupFieldId
                title:(nonnull NSString*)title
                icon:(nonnull NSString*)icon
                note:(nonnull NSString*)note
                value:(nonnull NSString*)value
                isHidden:(BOOL)isHidden
                synchronized:(BOOL)synchronized
                deleted:(BOOL)deleted
                timestampCreation:(uint64_t)timestampCreation
{
    if(self = [super init])
    {
        _id = id;
        _serverId = serverId;
        _userId = userId;
        _groupId = groupId;
        _serverGroupId = serverGroupId;
        _groupFieldId = groupFieldId;
        _serverGroupFieldId = serverGroupFieldId;
        _title = title;
        _icon = icon;
        _note = note;
        _isHidden = isHidden;
        _synchronized = synchronized;
        _deleted = deleted;
        _timestampCreation = timestampCreation;
    }
    return self;
}

-(void)setid:(uint32_t)id
{
    _id = id;
}

-(uint32_t)getid
{
    return _id;
}

-(void)setServerId:(uint32_t)id
{
    _serverId = id;
}

-(uint32_t)getServerId
{
    return _serverId;
}

-(void)setUserId:(uint32_t)id
{
    _userId = id;
}

-(uint32_t)getUserId
{
    return _userId;
}

-(void)setGroupId:(uint32_t)groupId
{
    _groupId = groupId;
}

-(uint32_t)getGroupId
{
    return _groupId;
}

-(void)setServerGroupId:(uint32_t)serverGroupId
{
    _serverGroupId = serverGroupId;
}

-(uint32_t)getServerGroupId
{
    return _serverGroupId;
}

-(void)setGroupFieldId:(uint32_t)groupFieldId
{
    _groupFieldId = groupFieldId;
}

-(uint32_t)getGroupFieldId
{
    return _groupFieldId;
}

-(void)setServerGroupFieldId:(uint32_t)serverGroupFieldId
{
    _serverGroupFieldId = serverGroupFieldId;
}

-(uint32_t)getServerGroupFieldId
{
    return _serverGroupFieldId;
}

-(void)setTitle:(nonnull NSString*)title
{
    _title = title;
}

-(nonnull const NSString*)getTitle
{
    return _title;
}

-(void)setIcon:(nonnull NSString*)icon
{
    _icon = icon;
}

-(nonnull const NSString*)getIcon
{
    return _icon;
}

-(void)setNote:(nonnull NSString*)note
{
    _note = note;
}

-(nonnull const NSString*)getNote
{
    return _note;
}

-(void)setIsHidden:(BOOL)isHidden
{
    _isHidden = isHidden;
}

-(BOOL)getIsHidden
{
    return _isHidden;
}

-(void)setSynchronized:(BOOL)synchronized
{
    _synchronized = synchronized;
}

-(BOOL)getSynchronized
{
    return _synchronized;
}

-(void)setDeleted:(BOOL)deleted
{
    _deleted = deleted;
}

-(BOOL)getDeleted
{
    return _deleted;
}

-(uint64_t)getTimestampCreation
{
    return _timestampCreation;
}

-(void)setTimestampCreation:(uint64_t)timestampCreation
{
    _timestampCreation = timestampCreation;
}


@end

group::ptr convert(const Group* group)
{
    
    auto&& ret = make_unique<struct group>();
    
    ret->id = [group getid];
    ret->server_id = [group getServerId];
    ret->user_id = [group getUserId];
    ret->group_id = [group getGroupId];
    ret->server_group_id = [group getServerGroupId];
    ret->title = [[group getTitle] UTF8String];
    ret->icon = [[group getIcon] UTF8String];
    ret->note = [[group getNote] UTF8String];
    ret->synchronized = [group getSynchronized];
    ret->deleted = [group getDeleted];
    ret->timestamp_creation = [group getTimestampCreation];
    
    return ret;
}

Group* convert(const group::ptr &field)
{
    auto ret = [[Group alloc] init];
    
    [ret setid: static_cast<uint32_t>(field->id)];
    [ret setServerId: static_cast<uint32_t>(field->server_id)];
    [ret setUserId: static_cast<uint32_t>(field->user_id)];
    [ret setGroupId: static_cast<uint32_t>(field->group_id)];
    [ret setServerGroupId: static_cast<uint32_t>(field->server_group_id)];
    [ret setTitle: [NSString stringWithCString:field->title.c_str() encoding:NSUTF8StringEncoding] ];
    [ret setIcon: [NSString stringWithCString:field->icon.c_str() encoding:NSUTF8StringEncoding] ];
    [ret setNote: [NSString stringWithCString:field->note.c_str() encoding:NSUTF8StringEncoding] ];
    [ret setSynchronized: field->synchronized];
    [ret setDeleted: field->deleted];
    [ret setTimestampCreation: field->timestamp_creation];
    
    return ret;
}
