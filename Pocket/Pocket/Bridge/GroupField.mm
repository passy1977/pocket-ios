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

@implementation GroupField
@synthesize newInsertion;
@synthesize _id;
@synthesize serverId;
@synthesize groupId;
@synthesize serverGroupId;
@synthesize title;
@synthesize isHidden;
@synthesize synchronized;
@synthesize deleted;
@synthesize timestampCreation;

-(instancetype)init
{
    if(self = [super init])
    {
        newInsertion = false;
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
        self._id = id;
        self.serverId = serverId;
        self.groupId = groupId;
        self.serverGroupId = serverGroupId;
        self.title = title;
        self.isHidden = isHidden;
        self.synchronized = synchronized;
        self.deleted = deleted;
        self.timestampCreation = timestampCreation;
    }
    return self;
}

@end

group_field::ptr convert(const GroupField* group_field)
{
    
    auto&& ret = make_unique<struct group_field>();
    
    ret->id = group_field._id;
    ret->server_id = group_field.serverId;
    ret->group_id = group_field.groupId;
    ret->server_group_id = group_field.serverGroupId;
    ret->title = [group_field.title UTF8String];
    ret->is_hidden = group_field.isHidden;
    ret->synchronized = group_field.synchronized;
    ret->deleted = group_field.deleted;
    ret->timestamp_creation = group_field.timestampCreation;
    
    return ret;
}

GroupField* convert(const group_field::ptr &group_field)
{
    auto ret = [GroupField new];
    
    ret._id = static_cast<uint32_t>(group_field->id);
    ret.serverId = static_cast<uint32_t>(group_field->server_id);
    ret.groupId = static_cast<uint32_t>(group_field->group_id);
    ret.serverGroupId = static_cast<uint32_t>(group_field->server_group_id);
    ret.title = [NSString stringWithCString:group_field->title.c_str() encoding:NSUTF8StringEncoding];
    ret.isHidden = group_field->is_hidden;
    ret.synchronized = group_field->synchronized;
    ret.deleted = group_field->deleted;
    ret.timestampCreation = group_field->timestamp_creation;
    
    return ret;
}
