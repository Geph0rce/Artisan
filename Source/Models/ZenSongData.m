//
//  ZenSongData.m
//  Artisan
//
//  Created by roger on 14-9-9.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenOfflineModel.h"
#import "ZenSongData.h"

@implementation ZenSongData

- (NSDictionary *)dictionary
{
    NSString *artist = _artist == nil ? @"null" : _artist;
    NSString *name = _name == nil ? @"null" : _name;
    NSString *picture = _picture == nil ? @"null" : _picture;
    NSString *hash = _songHash == nil ? @"null" : _songHash;
    return @{ @"artist" : artist, @"name" : name, @"picture" : picture, @"hash" : hash };
}

- (NSURL *)audioFileURL
{
    if ([ZenOfflineModel songExists:self]) {
        return [ZenOfflineModel urlForSong:self];
    }
    else {
        return [NSURL URLWithString:self.src];
    }
}

@end
