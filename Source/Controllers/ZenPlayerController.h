//
//  ZenPlayerController.h
//  Artisan
//
//  Created by roger on 14-9-11.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenSongData.h"
#import "ZenBaseController.h"

typedef enum {
    ZenPlayerPlayModeSequence = 0,
    ZenPlayerPlayModeCycle,
    ZenPlayerPlayRepeatOne
} ZenPlayerPlayMode;

@interface ZenPlayerController : ZenBaseController
{
    NSMutableArray *_list;
    NSUInteger _index;
}

@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, assign) NSUInteger index;

+ (ZenPlayerController *)sharedInstance;

- (void)play;
- (void)prev;
- (void)next:(BOOL)manual;

@end
