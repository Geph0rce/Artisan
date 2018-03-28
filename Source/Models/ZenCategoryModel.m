//
//  ZenCategoryModel.m
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "DoubanArtist.h"
#import "ZenCategory.h"
#import "ZenConnection.h"
#import "ZenCategoryModel.h"

@interface ZenCategoryModel () <ZenConnectionDelegate>
{
    ZenConnection *_connection;
    int _currentPage;
}

@property (nonatomic, strong) ZenConnection *connection;

@end

@implementation ZenCategoryModel

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

- (void)load:(NSString *)categoryId
{
    _currentPage = 1;
    [self load:categoryId page:_currentPage];
}

- (void)next:(NSString *)categoryId
{
    [self load:categoryId page:(_currentPage+1)];
}

- (void)load:(NSString *)categoryId page:(int)page
{
    NSString *url = [[DoubanArtist sharedInstance] genre:categoryId page:page];
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
        if (_currentPage == 1) {
            [_list removeAllObjects];
        }
        NSArray *artists = response[@"artists"];
        for (NSDictionary *artist in artists) {
            ZenArtistData *item = [[ZenArtistData alloc] init];
            item.name = artist[@"name"];
            item.follower = [NSString stringWithFormat:@"%ld", (long)[artist[@"follower"] integerValue]];
            item.picture = artist[@"picture"];
            item.aid = artist[@"id"];
            [_list addObject:item];
        }
        _currentPage++;
        [self send:kZenCategoryRequestFinished];
        return;
        
    }
    @catch (NSException *exception) {
        NSLog(@"ZenCategoryModel requestFinished exception: %@", [exception description]);
    }
    [self send:kZenCategoryReuqestFailed];
}

- (void)requestDidFailed:(ZenConnection *)conn
{
    [self send:kZenCategoryReuqestFailed];
}

@end
