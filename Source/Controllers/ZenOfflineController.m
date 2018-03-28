//
//  ZenOfflineController.m
//  Artisan
//
//  Created by roger on 14-9-24.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "ZenNavigationBar.h"
#import "ZenSwitchHeader.h"
#import "ZenOfflineFooter.h"
#import "ZenOfflineArtistCell.h"
#import "ZenOfflineCell.h"
#import "ZenOfflineModel.h"
#import "ZenOfflineController.h"
#import "ZenPlayerController.h"
#import "ZenOfflineSongsController.h"

#define kZenOfflineSongCellId @"ZenOfflineSongCell"
#define kZenOfflineArtistCellId @"ZenOfflineArtistCell"

@interface ZenOfflineController () <UITableViewDataSource, UITableViewDelegate, ZenSwitchHeaderDelegate>
{
    ZenOfflineModel *_model;
    UITableView *_table;
    ZenNavigationBar *_bar;
    BOOL _editing;
    UILabel *_empty;
    UIView *_header;
    UIView *_footer;
}

@property (nonatomic, strong) UIView *header;

@end

@implementation ZenOfflineController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    _model = [ZenOfflineModel sharedInstance];
    [defaultCenter addObserver:self selector:@selector(offlineStateChanged:) name:kZenOfflineStateChange object:_model];
    
    ZenNavigationBar *bar = [[ZenNavigationBar alloc] init];
    [bar addLeftItemWithStyle:ZenNavigationItemStyleMenu target:self action:@selector(menu:)];
    [bar addRightButtonWithTarget:self action:@selector(edit:)];
    [bar setRightButtonTitle:@"编辑"];
    [_container addSubview:bar];
    _bar = bar;
    
    UITableView *table = [[UITableView alloc] initWithFrame:_container.bounds];
    _table = table;
    _table.delegate = self;
    _table.dataSource = self;
    _table.scrollsToTop = YES;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 18.0f)];
    label.font = kZenFont15;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.hidden = YES;
    _empty = label;
    if (_type == ZenOfflineTypeOfflineSongs) {
        [_table setAllowsSelection:YES];
        [bar setTitle:@"已离线"];
        [label setText:@"离线完成的歌曲会出现在这里"];
        if (_model.offline.count == 0) {
            _empty.hidden = NO;
        }
    }
    else {
        [bar setTitle:@"离线中"];
        [_table setAllowsSelection:NO];
        [label setText:@"没有离线任务"];
        if (_model.download.count == 0) {
            _empty.hidden = NO;
        }
    }
    
    [_container addSubview:table];
    _table.frame = CGRectMake(0.0f, bar.height, CGRectGetWidth(_container.frame), CGRectGetHeight(_container.frame) - bar.height);
    
    [_table registerNib:[UINib nibWithNibName:@"ZenOfflineCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kZenOfflineSongCellId];
    [_table registerNib:[UINib nibWithNibName:@"ZenOfflineArtistCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kZenOfflineArtistCellId];
    _editing = NO;
    
    [_container addSubview:label];
    [_empty centerInGravity];
     
    if (_type == ZenOfflineTypeOfflineSongs) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ZenSwitchHeader" owner:self options:NULL];
        if (array && array.count > 0) {
            self.header = array[0];
            ZenSwitchHeader *header = (ZenSwitchHeader *)_header;
            header.delegate = self;
        }
    }
    else if (_type == ZenOfflineTypeDownloading) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ZenOfflineFooter" owner:self options:NULL];
        if (array && array.count > 0) {
            _footer = array[0];
            _footer.frame = CGRectMake(0.0f, CGRectGetHeight(_container.bounds) - 44.0f, 320.0f, 44.0f);
            _table.frame = CGRectMake(0.0f, _bar.height, CGRectGetWidth(_container.frame),CGRectGetHeight(_container.frame) - _bar.height - 44.0f);
            [_container addSubview:_footer];
            if (_model.download.count > 0) {
                _footer.hidden = NO;
            }
            else {
                _footer.hidden = YES;
            }
        }
    }
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

- (void)edit:(id)sender
{
    if (_table.isEditing) {
        [_bar setRightButtonTitle:@"编辑"];
        [_table setEditing:NO animated:YES];
        _editing = NO;
    }
    else {
        [_bar setRightButtonTitle:@"完成"];
        [_table setEditing:YES animated:YES];
        _editing = YES;
    }
    
}

#pragma mark
#pragma mark UITableViewDataSource and UITableViewDelegate Methods

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == ZenOfflineTypeOfflineArtists) {
        return NO;
    }
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (_type == ZenOfflineTypeOfflineSongs) {
            [_model removeOfflineObjectAtIndex:indexPath.row];
        }
        else {
            [_model removeDownloadingObjectAtIndex:indexPath.row];
        }
        [_table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                       withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_type == ZenOfflineTypeOfflineSongs) {
        return _model.offline.count;
    }
    else if (_type == ZenOfflineTypeOfflineArtists) {
        return _model.artists.count;
    }
    else {
        return _model.download.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_model.offline.count > 0) {
        if (_type == ZenOfflineTypeOfflineSongs || _type == ZenOfflineTypeOfflineArtists) {
            return 46.0f;
        }
    }

    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZenSongData *song = nil;
    if (_type == ZenOfflineTypeOfflineSongs) {
        song = _model.offline[indexPath.row];
        ZenOfflineCell *cell = [tableView dequeueReusableCellWithIdentifier:kZenOfflineSongCellId];
        [cell load:song];
        return cell;
    }
    else if (_type == ZenOfflineTypeDownloading){
         song = _model.download[indexPath.row];
        ZenOfflineCell *cell = [tableView dequeueReusableCellWithIdentifier:kZenOfflineSongCellId];
        [cell load:song];
        return cell;
    }
    else {
        ZenOfflineArtistData *artist = _model.artists[indexPath.row];
        ZenOfflineArtistCell *cell = [tableView dequeueReusableCellWithIdentifier:kZenOfflineArtistCellId];
        [cell load:artist];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        if (_type == ZenOfflineTypeOfflineSongs) {
            ZenPlayerController *controller = [ZenPlayerController sharedInstance];
            controller.list = [[NSMutableArray alloc] initWithArray:_model.offline];
            controller.index = indexPath.row;
            controller.view.frame = _container.bounds;
            [self presentViewController:controller option:ZenAnimationOptionHorizontal completion:NULL];
        }
        else if (_type == ZenOfflineTypeOfflineArtists) {
            ZenOfflineArtistData *artist = _model.artists[indexPath.row];
            ZenOfflineSongsController *controller = [[ZenOfflineSongsController alloc] init];
            controller.artist = artist.name;
            [self presentViewController:controller option:ZenAnimationOptionHorizontal completion:NULL];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception: %@", [exception description]);
    }
}

#pragma mark
#pragma mark ZenSwitchHeaderDelegate Method

- (void)onZenSwitchHeaderValueChanged:(ZenSwitchTag)tag
{
    NSLog(@"onZenSwitchHeaderValueChanged: %d", tag);
    if (tag == ZenSwitchTagFirst) {
        // offline songs
        [_bar setRightButtonHidden:NO];
        _type = ZenOfflineTypeOfflineSongs;
    }
    else {
        [_bar setRightButtonHidden:YES];
        _type = ZenOfflineTypeOfflineArtists;
        [_model loadArtists];
    }
    [_table reloadData];
    
}


#pragma mark
#pragma mark Handle Notifications from ZenOfflineModel

- (void)offlineStateChanged:(NSNotification *)notification
{
    if (!_editing) {
        [_table reloadData];
    }
    if (_type == ZenOfflineTypeDownloading) {
        if (_model.download.count == 0) {
            _empty.hidden = NO;
            [self success:@"离线完成～"];
            _footer.hidden = YES;
        }
    }
    else {
        if (_model.offline.count == 0) {
            _empty.hidden = NO;
        }
    }
}

- (IBAction)offlinePause:(id)sender
{
    [_model pause];
}

- (IBAction)offlineStart:(id)sender
{
    [_model start];
}

@end
