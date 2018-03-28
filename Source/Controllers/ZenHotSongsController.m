//
//  ZenHotSongsController.m
//  Artisan
//
//  Created by roger on 14-9-9.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenConfig.h"
#import "ZenOfflineModel.h"
#import "ZenHotSongsModel.h"
#import "ZenNavigationBar.h"
#import "ZenSongCell.h"
#import "ZenHotSongsController.h"
#import "ZenPlayerController.h"

#define kZenSongCellId @"ZenSongCellId"

@interface ZenHotSongsController () <ZenSongCellDelegate>
{
    ZenHotSongsModel *_model;
    ZenConfig *_config;
}
@end

@implementation ZenHotSongsController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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
    _model = [[ZenHotSongsModel alloc] init];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(requestFinished:) name:kZenHotSongsRequestFinished object:_model];
    [defaultCenter addObserver:self selector:@selector(requestFailed:) name:kZenHotSongsRequestFailed object:_model];
    
    ZenNavigationBar *bar = [[ZenNavigationBar alloc] init];
    [bar addLeftItemWithStyle:ZenNavigationItemStyleMenu target:self action:@selector(menu:)];
    [bar addRightItemWithStyle:ZenNavigationItemStyleOffline target:self action:@selector(offline:)];
    [bar setTitle:@"热门单曲"];
    [_container addSubview:bar];
    _table.frame = CGRectMake(0.0f, bar.height, CGRectGetWidth(_container.frame), CGRectGetHeight(_container.frame) - bar.height);
    
    UINib *nib = [UINib nibWithNibName:@"ZenSongCell" bundle:[NSBundle mainBundle]];
    [_table registerNib:nib forCellReuseIdentifier:kZenSongCellId];
    [self load];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)menu:(id)sender
{
    DDMenuController *menuController = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    [menuController showLeftController:YES];
}

- (void)offline:(id)sender
{
    if ([_config allowOffline]) {
        
        [self success:@"已加入[离线]队列"];
        [[ZenOfflineModel sharedInstance] offline:_model.list];
    }
    else {
        [self alert:@"请在[设置]中允许使用2G/3G/4G离线"];
    }
}

#pragma mark
#pragma mark override model load methods

- (void)modelReload
{
    [_model refresh];
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
    ZenSongCell *cell = [tableView dequeueReusableCellWithIdentifier:kZenSongCellId];
    [cell load:song];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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

#pragma mark
#pragma mark Handel Notifications From Model 

- (void)requestFinished:(NSNotification *)notification
{
    [self done];
    [_table reloadData];
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
