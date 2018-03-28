//
//  ZenHotSongsModel.h
//  Artisan
//
//  Created by roger on 14-9-9.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenBaseModel.h"
#import "ZenSongData.h"

#define kZenHotSongsRequestFinished @"ZenHotSongsRequestFinished"
#define kZenHotSongsRequestFailed @"ZenHotSongsRequestFailed"

@interface ZenHotSongsModel : ZenBaseModel
{
    NSMutableArray *_list;
}

@property (nonatomic, strong) NSMutableArray *list;

- (void)refresh;

@end
