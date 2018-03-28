//
//  ZenAlbumModel.m
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "DoubanArtist.h"
#import "ZenCategory.h"
#import "ZenConnection.h"
#import "ZenAlbumModel.h"

@interface ZenAlbumModel () <ZenConnectionDelegate>
{
    ZenConnection *_connection;
}

@property (nonatomic, strong) ZenConnection *connection;

@end

@implementation ZenAlbumModel

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

- (void)refresh:(NSString *)aid
{
    NSString *url = [[DoubanArtist sharedInstance] playlist:aid];
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
        
        // parser artist profile
        ZenArtistData *item = [[ZenArtistData alloc] init];
        item.name = response[@"name"];
        item.follower = [NSString stringWithFormat:@"%ld", (long)[response[@"follower"] integerValue]];
        item.picture = response[@"picture"];
        item.aid = response[@"id"];
        item.style = response[@"style"];
        self.artist = item;
        
        // parser playlist
        [_list removeAllObjects];
        NSArray *playlist = response[@"playlist"];
        for (NSDictionary *album in playlist) {
            ZenAlbumData *item = [[ZenAlbumData alloc] init];
            item.aid = album[@"id"];
            item.name = album[@"title"];
            [_list addObject:item];
        }
        
        [self send:kZenAlbumRequestFinished];
        return;
    }
    @catch (NSException *exception) {
        NSLog(@"ZenAlbumModel requestFinished exception: %@", [exception description]);
    }
    [self send:kZenAlbumRequestFailed];
}

- (void)requestDidFailed:(ZenConnection *)conn
{
    [self send:kZenAlbumRequestFailed];
}


@end
