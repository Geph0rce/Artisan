//
//  ZenPlaylistController.h
//  Artisan
//
//  Created by roger on 14-9-11.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenLoadingController.h"

@interface ZenPlaylistController : ZenLoadingController
{
    NSString *_name;
    NSString *_pid;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pid;

@end
