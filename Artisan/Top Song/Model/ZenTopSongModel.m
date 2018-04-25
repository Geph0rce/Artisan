//
//  ZenTopSongModel.m
//  Artisan
//
//  Created by qianjie on 2018/4/25.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenTopSongModel.h"

@implementation ZenTopSongModel

@end

@implementation ZenTopSongResponse

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"songs" : [ZenTopSongModel class]
            };
}

@end
