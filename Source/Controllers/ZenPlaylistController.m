//
//  ZenPlaylistController.m
//  Artisan
//
//  Created by roger on 14-9-11.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenConfig.h"
#import "ZenOfflineModel.h"
#import "ZenNavigationBar.h"
#import "ZenPlaylistModel.h"
#import "ZenSongCell.h"
#import "ZenPlaylistController.h"

#import "ZenPlayerController.h"

#define kZenPlaylistCellId @"ZenPlaylistCellId"

@interface ZenPlaylistController () <ZenSongCellDelegate>
{
    ZenPlaylistModel *_model;
    ZenOfflineModel *_offline;
    ZenConfig *_config;
}
@end

@implementation ZenPlaylistController

- (id)init
{
    self = [super init];
    if (self) {
        _enableLoadMore = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _config = [ZenConfig sharedInstance];
    _model = [[ZenPlaylistModel alloc] init];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(requestFinished:) name:kZenPlaylistRequestFinished object:_model];
    [defaultCenter addObserver:self selector:@selector(requestFailed:) name:kZenPlaylistRequestFailed object:_model];
    
    _offline = [ZenOfflineModel sharedInstance];
    
    ZenNavigationBar *bar = [[ZenNavigationBar alloc] init];
    [bar addLeftItemWithStyle:ZenNavigationItemStyleBack target:self action:@selector(back:)];
    [bar addRightItemWithStyle:ZenNavigationItemStyleOffline target:self action:@selector(offline:)];
    [bar setTitle:_name];
    [_container addSubview:bar];
    _table.frame = CGRectMake(0.0f, bar.height, CGRectGetWidth(_container.frame), CGRectGetHeight(_container.frame) - bar.height);
    
    [_table registerNib:[UINib nibWithNibName:@"ZenSongCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kZenPlaylistCellId];
    [self enablePanRightGestureWithDismissBlock:NULL];
    [self load];
}


- (void)back:(id)sender
{
    [self dismissViewControllerWithOption:ZenAnimationOptionHorizontal completion:NULL];
}

- (void)offline:(id)sender
{
    if ([_config allowOffline]) {
        
        [self success:@"已加入[离线]队列"];
        [_offline offline:_model.list];
    }
    else {
        [self alert:@"请在[设置]中允许使用2G/3G/4G离线"];
    }
}


#pragma mark
#pragma mark override model load methods

- (void)modelReload
{
    [_model load:_pid];
}

#pragma mark
#pragma mark UITableViewDataSource and UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _model.list.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZenSongData *song = _model.list[indexPath.row];
    ZenSongCell *cell = [tableView dequeueReusableCellWithIdentifier:kZenPlaylistCellId];
    cell.delegate = self;
    [cell load:song];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        if ([_config allowPlay]) {
            
            ZenPlayerController *controller = [ZenPlayerController sharedInstance];
            controller.list = [[NSMutableArray alloc] initWithArray:_model.list];
            controller.index = indexPath.row;
            controller.view.frame = _container.bounds;
            [self presentViewController:controller option:ZenAnimationOptionHorizontal completion:NULL];
        }
        else {
            [self alert:@"请在[设置]中允许使用2G/3G/4G播放"];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception: %@", [exception description]);
    }
}

#pragma mark
#pragma mark Handel Notifications From Model

- (void)requestFinished:(NSNotification *)notification
{
    [_table reloadData];
    [self done];
}

- (void)requestFailed:(NSNotification *)notification
{
    [self done];
    [self failed:@"加载失败..."];
}

#pragma mark
#pragma mark ZenSongCellDelegate Method

- (void)offlineDidClick:(ZenSongData *)song
{
    if ([_config allowOffline]) {
        
        [self success:@"已加入[离线]队列"];
        if (song) {
            ZenOfflineModel *manager = [ZenOfflineModel sharedInstance];
            [manager offline:@[song]];
        }
    }
    else {
        [self alert:@"请在[设置]中允许使用2G/3G/4G离线"];
    }
}


@end
