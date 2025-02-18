//
//  SystemInfo.h
//  Pocket
//
//  Created by Antonio Salsi on 03/05/2020.
//  Copyright © 2020 Scapix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemInfo : NSObject

@property (copy, nonatomic) NSString * _Nonnull modelName;
@property (copy, nonatomic) NSString * _Nonnull modelNameAndOSVersion;

-(id _Nonnull) init;

@end
