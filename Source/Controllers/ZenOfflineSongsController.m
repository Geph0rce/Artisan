//
//  ZenOfflineSongsController.m
//  Artisan
//
//  Created by roger on 14-10-9.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenNavigationBar.h"
#import "ZenOfflineModel.h"
#import "ZenOfflineCell.h"
#import "ZenOfflineSongsController.h"
#import "ZenPlayerController.h"

#define kZenOfflineSongsCellId @"ZenOfflineSongsCellId"

@interface ZenOfflineSongsController () <UITableViewDataSource, UITableViewDelegate>
{
    ZenOfflineModel *_model;
    UITableView *_table;
}

@end

@implementation ZenOfflineSongsController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    _model = [ZenOfflineModel sharedInstance];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadSongsFinished:) name:kZenOfflineLoadSongsFinished object:_model];
    
    ZenNavigationBar *bar = [[ZenNavigationBar alloc] init];
    [bar addLeftItemWithStyle:ZenNavigationItemStyleBack target:self action:@selector(back:)];
    [bar setTitle:_artist];
    [_container addSubview:bar];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, bar.height, CGRectGetWidth(_container.frame), CGRectGetHeight(_container.frame) - bar.height)];
    _table = table;
    _table.delegate = self;
    _table.dataSource = self;
    _table.scrollsToTop = YES;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_table setAllowsSelection:YES];
    [_container addSubview:table];
    
    UINib *nib = [UINib nibWithNibName:@"ZenOfflineCell" bundle:[NSBundle mainBundle]];
    [_table registerNib:nib forCellReuseIdentifier:kZenOfflineSongsCellId];

    [self enablePanRightGestureWithDismissBlock:NULL];
    [_model loadSongsWithArtist:_artist];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(id)sender
{
    [self dismissViewControllerWithOption:ZenAnimationOptionHorizontal completion:NULL];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _model.songs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZenSongData *song = _model.songs[indexPath.row];
    ZenOfflineCell *cell = [_table dequeueReusableCellWithIdentifier:kZenOfflineSongsCellId];
    [cell load:song];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZenPlayerController *controller = [ZenPlayerController sharedInstance];
    controller.list = [[NSMutableArray alloc] initWithArray:_model.songs];
    controller.index = indexPath.row;
    controller.view.frame = _container.bounds;
    [self presentViewController:controller option:ZenAnimationOptionHorizontal completion:NULL];

}

#pragma mark
#pragma mark Handle ZenOfflineModel Notifications

- (void)loadSongsFinished:(NSNotification *)notification
{
    [_table reloadData];
}


@end
