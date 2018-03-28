//
//  ZenBaseModel.m
//  Artisan
//
//  Created by roger on 14-9-9.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenBaseModel.h"

@implementation ZenBaseModel

- (void)send:(NSString *)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:self];
}

- (void)send:(NSString *)notification info:(NSDictionary *)info
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:self userInfo:info];
}

@end
