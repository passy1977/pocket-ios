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

@implementation Group
@synthesize _id;
@synthesize serverId;
@synthesize userId;
@synthesize groupId;
@synthesize serverGroupId;
@synthesize groupFieldId;
@synthesize serverGroupFieldId;
@synthesize title;
@synthesize icon;
@synthesize note;
@synthesize isHidden;
@synthesize synchronized;
@synthesize deleted;
@synthesize timestampCreation;

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
        self._id = id;
        self.serverId = serverId;
        self.userId = userId;
        self.groupId = groupId;
        self.serverGroupId = serverGroupId;
        self.groupFieldId = groupFieldId;
        self.serverGroupFieldId = serverGroupFieldId;
        self.title = title;
        self.icon = icon;
        self.note = note;
        self.isHidden = isHidden;
        self.synchronized = synchronized;
        self.deleted = deleted;
        self.timestampCreation = timestampCreation;
    }
    return self;
}

@end

group::ptr convert(const Group* group)
{
    
    auto&& ret = make_unique<struct group>();
    
    ret->id = group._id;
    ret->server_id = group.serverId;
    ret->user_id = group.userId;
    ret->group_id = group.groupId;
    ret->server_group_id = group.serverGroupId;
    ret->title = [group.title UTF8String];
    ret->icon = [group.icon UTF8String];
    ret->note = [group.note UTF8String];
    ret->synchronized = group.synchronized;
    ret->deleted = group.deleted;
    ret->timestamp_creation = group.timestampCreation;
    
    return ret;
}

Group* convert(const group::ptr &group)
{
    auto ret = [Group new];
    
    ret._id = static_cast<uint32_t>(group->id);
    ret.serverId = static_cast<uint32_t>(group->server_id);
    ret.userId = static_cast<uint32_t>(group->user_id);
    ret.groupId = static_cast<uint32_t>(group->group_id);
    ret.serverGroupId = static_cast<uint32_t>(group->server_group_id);
    ret.title = [NSString stringWithCString:group->title.c_str() encoding:NSUTF8StringEncoding];
    ret.icon = [NSString stringWithCString:group->icon.c_str() encoding:NSUTF8StringEncoding];
    ret.note = [NSString stringWithCString:group->note.c_str() encoding:NSUTF8StringEncoding];
    ret.synchronized = group->synchronized;
    ret.deleted = group->deleted;
    ret.timestampCreation = group->timestamp_creation;
    
    return ret;
}
