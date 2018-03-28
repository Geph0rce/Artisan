//
//  ZenHotArtistsModel.m
//  Artisan
//
//  Created by roger on 14-9-11.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "DoubanArtist.h"
#import "ZenMacros.h"
#import "ZenConnection.h"
#import "ZenCategory.h"
#import "ZenHotArtistsModel.h"

@interface ZenHotArtistsModel () <ZenConnectionDelegate>
{
    ZenConnection *_connection;
}

@property (nonatomic, strong) ZenConnection *connection;

@end

@implementation ZenHotArtistsModel

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

- (void)load
{
    NSString *url = [[DoubanArtist sharedInstance] artists];
    ZenConnection *conn = [ZenConnection connectionWithURL:[NSURL URLWithString:url]];
    conn.delegate = self;
    self.connection = conn;
    [conn startAsynchronous];
}

#pragma mark
#pragma mark  ZenConnectionDelegate Methods

- (void)requestDidFinished:(ZenConnection *)conn
{
    @try {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:[conn.responseData filter] options:NSJSONReadingMutableLeaves error:NULL];
        NSLog(@"response: %@", [response description]);
        [_list removeAllObjects];
        NSArray *artists = response[@"artists"];
        for (NSDictionary *artist in artists) {
            ZenArtistData *item = [[ZenArtistData alloc] init];
            item.name = artist[@"name"];
            item.follower = [NSString stringWithFormat:@"%ld", (long)[artist[@"follower"] integerValue]];
            item.picture = artist[@"picture"];
            item.aid = artist[@"id"];
            [_list addObject:item];
        }
        [self send:kZenHotArtistsRequestFinished];
        return;
    }
    @catch (NSException *exception) {
        NSLog(@"ZenHotArtistsModel requestFinished exception: %@", [exception description]);
    }
    [self send:kZenHotArtistsRequestFailed];
}

- (void)requestDidFailed:(ZenConnection *)conn
{
    [self send:kZenHotArtistsRequestFailed];
}

@end
