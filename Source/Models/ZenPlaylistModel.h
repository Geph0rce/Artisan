//
//  ZenPlaylistModel.h
//  Artisan
//
//  Created by roger on 14-9-11.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenBaseModel.h"

#define kZenPlaylistRequestFinished @"ZenPlaylistRequestFinished"
#define kZenPlaylistRequestFailed @"ZenPlaylistRequestFailed"

@interface ZenPlaylistModel : ZenBaseModel
{
    NSMutableArray *_list;
}

@property (nonatomic, strong) NSMutableArray *list;

- (void)load:(NSString *)pid;

@end
