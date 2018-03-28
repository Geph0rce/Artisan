//
//  ZenPlaylistModel.m
//  Artisan
//
//  Created by roger on 14-9-11.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "DoubanArtist.h"
#import "ZenCategory.h"
#import "ZenConnection.h"
#import "ZenSongData.h"
#import "ZenPlaylistModel.h"

@interface ZenPlaylistModel () <ZenConnectionDelegate>
{
    ZenConnection *_connection;
}

@property (nonatomic, strong) ZenConnection *connection;

@end

@implementation ZenPlaylistModel

- (void)dealloc
{
    if (_connection) {
        [_connection cancel];
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        _list = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)load:(NSString *)pid
{
    NSString *url = [[DoubanArtist sharedInstance] songs:pid];
    ZenConnection *conn = [ZenConnection connectionWithURL:[NSURL URLWithString:url]];
    conn.delegate = self;
    self.connection = conn;
    [conn startAsynchronous];
}

#pragma mark
#pragma mark ZenConnectionDelegate Methods

- (void)requestDidFinished:(ZenConnection *)conn
{
    @try {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:[conn.responseData filter] options:NSJSONReadingMutableLeaves error:NULL];
        NSLog(@"response: %@", [response description]);
        NSArray *songs = response[@"songs"];
        [_list removeAllObjects];
        for (NSDictionary *item in songs){
            ZenSongData *song = [[ZenSongData alloc] init];
            song.artist = item[@"artist"];
            song.name = item[@"name"];
            song.length = item[@"length"];
            song.picture = item[@"picture"];
            song.src = item[@"src"];
            song.songHash = [[NSString stringWithFormat:@"%@-%@", song.artist, song.name] md5];
            song.status = ZenSongStatusNone;
            [_list addObject:song];
        }
        [self send:kZenPlaylistRequestFinished];
        return;
    }
    @catch (NSException *exception) {
        NSLog(@"ZenPlaylistModel requestFinished exception: %@", [exception description]);
    }
    [self send:kZenPlaylistRequestFailed];
}

- (void)requestDidFailed:(ZenConnection *)conn
{
    [self send:kZenPlaylistRequestFailed];
}

@end
