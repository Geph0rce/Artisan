//
//  ZenAlbumController.m
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "ZenAlbumModel.h"
#import "ZenAlbumCell.h"
#import "ZenProfileView.h"
#import "ZenNavigationBar.h"
#import "ZenAlbumController.h"
#import "ZenPlaylistController.h"

#define kZenAlbumCellId @"ZenAlbumCellId"
#define kZenAlbumHeaderId @"ZenAlbumHeaderId"

@interface ZenAlbumController ()
{
    ZenAlbumModel *_model;
    ZenProfileView *_profileView;
}

@property (nonatomic, strong) ZenProfileView *profileView;

@end

@implementation ZenAlbumController

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
    _model = [[ZenAlbumModel alloc] init];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(requestFinished:) name:kZenAlbumRequestFinished object:_model];
    [defaultCenter addObserver:self selector:@selector(requestFailed:) name:kZenAlbumRequestFailed object:_model];
    
    ZenNavigationBar *bar = [[ZenNavigationBar alloc] init];
    [bar addLeftItemWithStyle:ZenNavigationItemStyleBack target:self action:@selector(back:)];
    [bar setTitle:@"播放列表"];
    [_container addSubview:bar];
    _table.frame = CGRectMake(0.0f, bar.height, CGRectGetWidth(_container.frame), CGRectGetHeight(_container.frame) - bar.height);
    
    [_table registerNib:[UINib nibWithNibName:@"ZenAlbumCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kZenAlbumCellId];
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ZenProfileView" owner:self options:NULL];
    if (array && array.count > 0) {
        self.profileView = array[0];
    }
    [self enablePanRightGestureWithDismissBlock:NULL];
    [self load];
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


#pragma mark
#pragma mark override model load methods

- (void)modelReload
{
    [_model refresh:_aid];
}

#pragma mark
#pragma mark UITableViewDataSource and UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _model.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_model.artist) {
        [_profileView load:_model.artist];
    }
    
    return _profileView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZenAlbumData *album = _model.list[indexPath.row];
    ZenAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:kZenAlbumCellId];
    [cell load:album.name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZenAlbumData *album = _model.list[indexPath.row];
    ZenPlaylistController *controller = [[ZenPlaylistController alloc] init];
    controller.name = album.name;
    controller.pid = album.aid;
    controller.view.frame = _container.bounds;
    [self presentViewController:controller option:ZenAnimationOptionHorizontal completion:NULL];
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

@end
