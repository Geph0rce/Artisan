//
//  ZenOfflineController.h
//  Artisan
//
//  Created by roger on 14-9-24.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenBaseController.h"

typedef enum {
    ZenOfflineTypeDownloading,
    ZenOfflineTypeOfflineSongs,
    ZenOfflineTypeOfflineArtists
} ZenOfflineType;

@interface ZenOfflineController : ZenBaseController
{
    ZenOfflineType _type;
}

@property (nonatomic, assign) ZenOfflineType type;

- (IBAction)offlinePause:(id)sender;
- (IBAction)offlineStart:(id)sender;

@end
