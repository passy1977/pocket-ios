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

#import "Field.h"

#include "pocket-pods/field.hpp"
using pocket::pods::field;

#include <memory>
using namespace std;


@implementation Field
@synthesize  _id;
@synthesize serverId;
@synthesize userId;
@synthesize groupId;
@synthesize serverGroupId;
@synthesize groupFieldId;
@synthesize serverGroupFieldId;
@synthesize title;
@synthesize value;
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
        self.value = value;
        self.isHidden = isHidden;
        self.synchronized = synchronized;
        self.deleted = deleted;
        self.timestampCreation = timestampCreation;
    }
    return self;
}


@end

field::ptr convert(const Field* field)
{
    
    auto&& ret = make_unique<struct field>();
    
    ret->id = field._id;
    ret->server_id = field.serverId;
    ret->user_id = field.userId;
    ret->group_id = field.groupId;
    ret->server_group_id = field.serverGroupId;
    ret->group_field_id = field.groupFieldId;
    ret->server_group_field_id = field.serverGroupFieldId;
    ret->title = [field.title UTF8String];
    ret->value = [field.value UTF8String];
    ret->is_hidden = field.isHidden;
    ret->synchronized = field.synchronized;
    ret->deleted = field.deleted;
    ret->timestamp_creation = field.timestampCreation;
    
    return ret;
}

Field* convert(const field::ptr &field)
{
    auto ret = [Field new];
    
    ret._id = static_cast<uint32_t>(field->id);
    ret.serverId = static_cast<uint32_t>(field->server_id);
    ret.userId = static_cast<uint32_t>(field->user_id);
    ret.groupId = static_cast<uint32_t>(field->group_id);
    ret.serverGroupId = static_cast<uint32_t>(field->server_group_id);
    ret.groupFieldId = static_cast<uint32_t>(field->group_field_id);
    ret.serverGroupFieldId = static_cast<uint32_t>(field->server_group_field_id);
    ret.title = [NSString stringWithCString:field->title.c_str() encoding:NSUTF8StringEncoding];
    ret.value = [NSString stringWithCString:field->value.c_str() encoding:NSUTF8StringEncoding];
    ret.isHidden = field->is_hidden;
    ret.synchronized = field->synchronized;
    ret.deleted = field->deleted;
    ret.timestampCreation = field->timestamp_creation;

    return ret;
}
