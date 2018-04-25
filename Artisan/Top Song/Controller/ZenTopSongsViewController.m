//
//  ZenTopSongsViewController.m
//  Artisan
//
//  Created by qianjie on 2018/4/20.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenTopSongsViewController.h"

@interface ZenTopSongsViewController ()

@property (nonatomic, strong) RFTableView *tableView;
@property (nonatomic, strong) RFTableDataSource *dataSource;
@property (nonatomic, strong) RFTableSection *section;

@end

@implementation ZenTopSongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"热门歌曲";
    [self reloadData];
}

- (void)reloadData {
    [self startActivityIndicator];
    weakify(self);
    NSString *url = [[DoubanArtist sharedInstance] songs];
    [self get:url params:nil complete:^(__kindof NSObject * _Nullable response, NSInteger statusCode, NSError * _Nullable error) {
        strongify(self);
        [self stopActivityIndicator];
        NSData *data = [response filter];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Custom Top Bar

- (BOOL)shouldUseCustomTopBar {
    return YES;
}

- (BOOL)automaticallyShowBackButton {
    return NO;
}

#pragma mark - Getters



@end
