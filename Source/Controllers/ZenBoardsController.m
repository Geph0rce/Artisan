//
//  ZenBoardsController.m
//  Zen
//
//  Created by roger on 13-10-17.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import "AppDelegate.h"

#import "Singleton.h"
#import "ZenMacros.h"
#import "ZenMenuItem.h"
#import "ZenCategory.h"

#import "ZenColorManager.h"
#import "ZenTableViewCell.h"
#import "ZenBoardsController.h"

#import "ZenHotArtistsController.h"
#import "ZenCategoryController.h"
#import "ZenOfflineController.h"
#import "ZenSettingsController.h"

#import "ZenTopSongsViewController.h"
#import "ZenTopArtistViewController.h"

#define kZenBoardWidth 240.0f
#define kZenMenuItemHeight 64.0f
#define kZenMenuItemBeginY 20.0f
#define kZenMenuCellMarginX 20.0f

#define kZenMenuCellHighlightColor kZenHighlightColor
#define kZenMenuCellFontColor kZenMainFontColor

#define kZenBoardTag 1001
#define kZenHotSongsFid @"1001"
#define kZenHotArtistsFid @"1002"
#define kZenDownloadFid @"1003"
#define kZenSettingsFid @"1004"

#define kZenOfflineDone @"2001"
#define kZenOfflineDownloading @"2002"


@interface ZenBoardsController () <UITableViewDataSource, UITableViewDelegate, ZenMenuItemDelegate>
{
    ZenMenuItem *_item;
    UIView *_statusBarMask;
    UITableView *_boards;
    NSMutableArray *_boardsData;
    NSMutableArray *_childBoardsData;
    NSMutableArray *_dataSource;
    NSArray *_menuColors;
    NSArray *_menuHLColors;
    NSMutableArray *_headers;
}

@property (nonatomic, strong) NSArray *menuColors;
@property (nonatomic, strong) NSArray *menuHLColors;

- (void)initDataSource;

@end


@implementation ZenBoardsController

SINGLETON_FOR_CLASS(ZenBoardsController);


- (id)init
{
    self = [super init];
    if (self) {
        [self initDataSource];
        ZenColorManager *colorManager = [ZenColorManager sharedInstance];
        
        self.menuColors = colorManager.normal;
        self.menuHLColors = colorManager.highlight;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = kZenBackgroundColor;
    
    UITableView *boards = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kZenBoardWidth, CGRectGetHeight(self.view.frame))];
    boards.dataSource = self;
    boards.delegate = self;
    boards.scrollsToTop = NO;
    boards.backgroundColor = kZenBackgroundColor;
    boards.separatorStyle = UITableViewCellSeparatorStyleNone;

    _boards = boards;
    [self.view addSubview:boards];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        UIView *statusBarMask = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.frame), 20.0f)];
        _statusBarMask = statusBarMask;
        statusBarMask.backgroundColor = kZenBackgroundColor;
        statusBarMask.alpha = 0.8;
        [self.view addSubview:statusBarMask];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initDataSource
{
    @try {
        _boardsData = [[NSMutableArray alloc] init];
        _childBoardsData = [[NSMutableArray alloc] init];
        _headers = [[NSMutableArray alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"boards" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        if (array) {
            [_boardsData addObjectsFromArray:array];
            for (NSDictionary *board in array) {
                ZenMenuItem *item = [[ZenMenuItem alloc] initWithFrame:CGRectMake(1.0f, 1.0f, 250.0f, kZenMenuItemHeight)];
                item.delegate = self;
                [_headers addObject:item];
                
                
                NSString *fid = [board stringForKey:@"fid"];
                if ([fid isEqualToString:kZenHotSongsFid] || [fid isEqualToString:kZenSettingsFid] || [fid isEqualToString:kZenHotArtistsFid] || [fid isEqualToString:kZenDownloadFid]) {
                    [_childBoardsData addObject:[NSArray array]];
                    continue;
                }
                NSString *fileName = [NSString stringWithFormat:@"board_%@", fid];
                NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
                NSArray *childArray = [NSArray arrayWithContentsOfFile:filePath];
                if (childArray) {
                    [_childBoardsData addObject:childArray];
                }
                
            }
        }
        _dataSource = [[NSMutableArray alloc] init];
        for (int i = 0; i < _childBoardsData.count; i++) {
            [_dataSource addObject:[NSArray array]];
        }

    }
    @catch (NSException *exception) {
        NSLog(@"ZenBoardsController initDataSource Exception: %@", [exception description]);
    }
    
}

#pragma mark -
#pragma mark UITableViewDataSource and UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return [_boardsData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [_dataSource safeObjectAtIndex:section];
    if (array) {
        return [array count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kZenMenuItemHeight;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *counter = [_dataSource safeObjectAtIndex:section];
    ZenMenuItem *item = [_headers safeObjectAtIndex:section];
    if (counter.count > 0) {
        item.status = ZenMenuItemStatusExpanded;
    }
    
    NSDictionary *board = [_boardsData safeObjectAtIndex:section];
    NSString *title = [board stringForKey:@"name"];
    NSString *fid = [board stringForKey:@"fid"];
    [item setTitle:title];
    if ([fid isEqualToString:kZenHotSongsFid]) {
        item.style = ZenMenuItemStyleHotSongs;
    }
    else if ([fid isEqualToString:kZenHotArtistsFid]) {
        item.style = ZenMenuItemStyleHotArtists;
    }
    else if ([fid isEqualToString:kZenSettingsFid]) {
        item.style = ZenMenuItemStyleSettings;
    }
    else if ([fid isEqualToString:kZenDownloadFid]) {
        item.style = ZenMenuItemStyleDownload;
    }
    else {
        item.style = ZenMenuItemStyleExpandable;
    }

    
    NSUInteger colorIndex = (section % _menuColors.count);
    
    UIColor *colorNarmal = [_menuColors safeObjectAtIndex:colorIndex];
    UIColor *colorHighlight = [_menuHLColors safeObjectAtIndex:colorIndex];
    [item setColor:colorNarmal highlight:colorHighlight];
    item.tag = section;
    return item;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"ZenBoardCell";
    ZenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ZenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        UILabel *boardTitle = [[UILabel alloc] initWithFrame:cell.bounds];
        boardTitle.backgroundColor = [UIColor clearColor];
        boardTitle.font = kZenFont15;
        
        boardTitle.tag = kZenBoardTag;
        CGRect labelFrame = boardTitle.frame;
        labelFrame.origin.x += kZenMenuCellMarginX;
        boardTitle.frame = labelFrame;
        
        [cell.contentView addSubview:boardTitle];
        
        UIView *backColor = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView = backColor;
    }
    cell.backgroundColor = kZenBackgroundColor;
    cell.selectedBackgroundView.backgroundColor = kZenMenuCellHighlightColor;
    NSArray *array = [_dataSource safeObjectAtIndex:indexPath.section];
    NSDictionary *board = [array safeObjectAtIndex:indexPath.row];
    NSString *title = [board stringForKey:@"name"];
    UILabel *boardTitle = (UILabel *)[cell.contentView viewWithTag:kZenBoardTag];
    if (boardTitle) {
        boardTitle.textColor = kZenMenuCellFontColor;
        boardTitle.text = title;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *boards = [_childBoardsData safeObjectAtIndex:indexPath.section];
    if (boards) {
        
        NSDictionary *board = [boards safeObjectAtIndex:indexPath.row];
        if (board) {
            NSString *gid = [board stringForKey:@"gid"];
            NSString *name = [board stringForKey:@"name"];
            NSLog(@"gid: %@", gid);
             DDMenuController *menuController = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
            if ([gid isEqualToString:kZenOfflineDone]) {
                ZenOfflineController *controller = [[ZenOfflineController alloc] init];
                controller.type = ZenOfflineTypeOfflineSongs;
                [menuController setRootController:controller animated:YES];
            }
            else if ([gid isEqualToString:kZenOfflineDownloading]) {
                ZenOfflineController *controller = [[ZenOfflineController alloc] init];
                controller.type = ZenOfflineTypeDownloading;
                [menuController setRootController:controller animated:YES];
            }
            else {
               
                ZenCategoryController *controller = [[ZenCategoryController alloc] init];
                controller.name = name;
                controller.gid = gid;
                [menuController setRootController:controller animated:YES];
            }
        }
    }
}


#pragma mark -
#pragma mark ZenMenuItemDelegate

- (void)menuItemClicked:(ZenMenuItem *)item
{
    @try {
        NSUInteger section = item.tag;
        NSDictionary *board = [_boardsData safeObjectAtIndex:section];
        DDMenuController *menuController = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
        if (board) {
            NSString *fid = [board stringForKey:@"fid"];
            if ([fid isEqualToString:kZenHotSongsFid]) {
                // top songs
                ZenTopSongsViewController *controller = [[ZenTopSongsViewController alloc] init];
                [menuController setRootController:controller animated:YES];
            }
            else if ([fid isEqualToString:kZenHotArtistsFid]) {
                // top artists
                ZenTopArtistViewController *controller = [[ZenTopArtistViewController alloc] init];
                [menuController setRootController:controller animated:YES];
            }
            else if ([fid isEqualToString:kZenSettingsFid]) {
                // settings
                ZenSettingsController *controller = [[ZenSettingsController alloc] init];
                [menuController setRootController:controller animated:YES];
            }
            else if ([fid isEqualToString:kZenDownloadFid]) {
                // offline
                ZenOfflineController *controller = [[ZenOfflineController alloc] init];
                [menuController setRootController:controller animated:YES];
            }
        }
        
        NSArray *childBoards = [_childBoardsData safeObjectAtIndex:section];
        NSArray *dataSource = [_dataSource safeObjectAtIndex:section];
        
        if (childBoards && dataSource) {
            
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            for (int i = 0; i < childBoards.count; i++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
                [indexPaths addObject:indexPath];
            }
            
            if (dataSource.count == 0) {
                
                [_dataSource replaceObjectAtIndex:section withObject:childBoards];
                [_boards insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            }
            else
            {
                [_dataSource replaceObjectAtIndex:section withObject:[NSArray array]];
                [_boards deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                
            }
        }    

    }
    @catch (NSException *exception) {
        NSLog(@"menu item clicked exception: %@", [exception description]);
    }
    
}

@end
