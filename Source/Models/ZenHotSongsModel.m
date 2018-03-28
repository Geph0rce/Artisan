//
//  ZenHotSongsModel.m
//  Artisan
//
//  Created by roger on 14-9-9.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenConnection.h"
#import "ZenHotSongsModel.h"

@interface ZenHotSongsModel () <ZenConnectionDelegate>
{
    ZenConnection *_connection;
}

@property (nonatomic, strong) ZenConnection *connection;

@end

@implementation ZenHotSongsModel

- (void)dealloc
{
    [self cancel];
}

- (id)init
{
    self = [super init];
    if (self) {
        _list = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)cancel
{
    if (_connection) {
        [_connection cancel];
    }
}

- (void)refresh
{
    NSString *url = [[DoubanArtist sharedInstance] songs];
    ZenConnection *connection = [ZenConnection connectionWithURL:[NSURL URLWithString:url]];
    connection.delegate = self;
    self.connection = connection;
    [_connection startAsynchronous];
}

#pragma mark
#pragma mark ZenConnectionDelegate Methods

- (void)requestDidFinished:(ZenConnection *)conn
{
    @try {
        NSData *responseData = [conn.responseData filter];
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:NULL];
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
        [self send:kZenHotSongsRequestFinished];
        return;
    }
    @catch (NSException *exception) {
        NSLog(@"ZenHotSongsModel requestFinished exception: %@", [exception description]);
    }
    [self send:kZenHotSongsRequestFailed];
}

- (void)requestDidFailed:(ZenConnection *)conn
{
    [self send:kZenHotSongsRequestFailed];
}

@end
