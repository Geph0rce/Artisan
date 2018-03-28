//
//  ZenSongData.h
//  Artisan
//
//  Created by roger on 14-9-9.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioFile.h"

typedef enum {
    ZenSongStatusNone,
    ZenSongStatusPlay,
    ZenSongStatusPause,
    ZenSongStatusDownloading,
} ZenSongStatus;

@interface ZenSongData : NSObject <DOUAudioFile>
{
    NSString *_artist;
    NSString *_name;
    NSString *_length;
    NSString *_picture;
    NSString *_src;
    NSString *_songHash;
    ZenSongStatus _status;
    NSUInteger _progress;
}

@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *src;
@property (nonatomic, strong) NSString *songHash;
@property (nonatomic, assign) ZenSongStatus status;
@property (nonatomic, assign) NSUInteger progress;

- (NSDictionary *)dictionary;

@end
