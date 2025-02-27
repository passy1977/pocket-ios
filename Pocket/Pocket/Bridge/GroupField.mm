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

#include "pocket-pods/group-field.hpp"
using pocket::pods::group_field;

#include <memory>
using namespace std;

@interface GroupField ()
@property uint32_t _id;
@property uint32_t _serverId;
@property uint32_t _userId;
@property uint32_t _groupId;
@property uint32_t _serverGroupId;
@property NSString* _title;
@property BOOL _isHidden;
@property BOOL _synchronized;
@property BOOL _deleted;
@property uint64_t _timestampCreation;

@end


@implementation GroupField
@synthesize  _id;
@synthesize _serverId;
@synthesize _groupId;
@synthesize _userId;
@synthesize _serverGroupId;
@synthesize _title;
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
                title:(nonnull NSString*)title
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
        _title = title;
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

-(void)setTitle:(nonnull NSString*)title
{
    _title = title;
}

-(nonnull const NSString*)getTitle
{
    return _title;
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

group_field::ptr convert(const GroupField* group_field)
{
    
    auto&& ret = make_unique<struct group_field>();
    
    ret->id = [group_field getid];
    ret->server_id = [group_field getServerId];
    ret->user_id = [group_field getUserId];
    ret->group_id = [group_field getGroupId];
    ret->server_group_id = [group_field getServerGroupId];
    ret->title = [[group_field getTitle] UTF8String];
    ret->is_hidden = [group_field getIsHidden];
    ret->synchronized = [group_field getSynchronized];
    ret->deleted = [group_field getDeleted];
    ret->timestamp_creation = [group_field getTimestampCreation];
    
    return ret;
}

GroupField* convert(const group_field::ptr &field)
{
    auto ret = [[GroupField alloc] init];
    
    [ret setid: static_cast<uint32_t>(field->id)];
    [ret setServerId: static_cast<uint32_t>(field->server_id)];
    [ret setUserId: static_cast<uint32_t>(field->user_id)];
    [ret setGroupId: static_cast<uint32_t>(field->group_id)];
    [ret setServerGroupId: static_cast<uint32_t>(field->server_group_id)];
    [ret setTitle: [NSString stringWithCString:field->title.c_str() encoding:NSUTF8StringEncoding] ];
    [ret setIsHidden: field->is_hidden];
    [ret setSynchronized: field->synchronized];
    [ret setDeleted: field->deleted];
    [ret setTimestampCreation: field->timestamp_creation];
    
    return ret;
}
