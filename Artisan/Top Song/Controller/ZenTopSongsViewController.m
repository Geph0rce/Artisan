//
//  ZenTopSongsViewController.m
//  Artisan
//
//  Created by qianjie on 2018/4/20.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenTopSongRow.h"
#import "ZenTopSongsViewController.h"

@interface ZenTopSongsViewController () <UITableViewDelegate>

@property (nonatomic, strong) RFTableView *tableView;
@property (nonatomic, strong) RFTableDataSource *dataSource;
@property (nonatomic, strong) RFTableSection *section;

@end

@implementation ZenTopSongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热门歌曲";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    FORBIDDEN_ADJUST_SCROLLVIEW_INSETS(self, self.tableView);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_top_equalTo(self.topViewAttribute);
        make.right.left.bottom.mas_equalTo(self.view);
    }];
    [self reloadData];
}

- (void)reloadData {
    [self startActivityIndicator];
    weakify(self);
    NSString *url = [[DoubanArtist sharedInstance] songs];
    [self get:url params:nil complete:^(__kindof NSObject * _Nullable responseData, NSInteger statusCode, NSError * _Nullable error) {
        strongify(self);
        [self stopActivityIndicator];
        NSString *json = [responseData json];
        ZenTopSongResponse *response = [ZenTopSongResponse yy_modelWithJSON:json];
        [self appendRows:response];
    }];
}

- (void)appendRows:(ZenTopSongResponse *)response {
    if (response.songs.count > 0) {
        [self.section removeAllChildren];
        [response.songs enumerateObjectsUsingBlock:^(ZenTopSongModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZenTopSongRow *row = [[ZenTopSongRow alloc] init];
            row.model = obj;
            [self.section addRow:row];
        }];
        [self.tableView reloadData];
    }
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

- (RFTableView *)tableView {
    if (!_tableView) {
        _tableView = [[RFTableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self.dataSource;
        _tableView.estimatedRowHeight = 0.0;
        _tableView.estimatedSectionHeaderHeight = 0.0;
        _tableView.estimatedSectionFooterHeight = 0.0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (RFTableDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[RFTableDataSource alloc] init];
        [_dataSource addSection:self.section];
    }
    return _dataSource;
}

- (RFTableSection *)section {
    if (!_section) {
        _section = [[RFTableSection alloc] init];
    }
    return _section;
}


@end
