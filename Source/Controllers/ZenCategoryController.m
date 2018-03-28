//
//  ZenCategoryController.m
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenNavigationBar.h"
#import "ZenCategoryModel.h"
#import "ZenArtistCell.h"
#import "ZenCategoryController.h"

#import "ZenAlbumController.h"

#define kZenArtistCellId @"ZenArtistCellId"

@interface ZenCategoryController ()
{
    ZenCategoryModel *_model;
}
@end

@implementation ZenCategoryController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    self = [super init];
    if (self) {
        _enableLoadMore = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _model = [[ZenCategoryModel alloc] init];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(requestFinished:) name:kZenCategoryRequestFinished object:_model];
    [defaultCenter addObserver:self selector:@selector(requestFailed:) name:kZenCategoryReuqestFailed object:_model];
    
    ZenNavigationBar *bar = [[ZenNavigationBar alloc] init];
    [bar addLeftItemWithStyle:ZenNavigationItemStyleMenu target:self action:@selector(menu:)];
    [bar setTitle:_name];
    [_container addSubview:bar];
    _table.frame = CGRectMake(0.0f, bar.height, CGRectGetWidth(_container.frame), CGRectGetHeight(_container.frame) - bar.height);
    
    UINib *nib = [UINib nibWithNibName:@"ZenArtistCell" bundle:[NSBundle mainBundle]];
    [_table registerNib:nib forCellReuseIdentifier:kZenArtistCellId];
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

#pragma mark
#pragma mark override model load methods

- (void)modelReload
{
    [_model load:_gid];
}

- (void)modelLoadMore
{
    [_model next:_gid];
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
    ZenArtistData *artist = _model.list[indexPath.row];
    ZenArtistCell *cell = [tableView dequeueReusableCellWithIdentifier:kZenArtistCellId];
    [cell load:artist];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZenArtistData *artist = _model.list[indexPath.row];
    ZenAlbumController *controller = [[ZenAlbumController alloc] init];
    controller.aid = artist.aid;
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
