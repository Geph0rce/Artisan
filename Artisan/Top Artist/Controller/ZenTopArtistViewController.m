//
//  ZenTopArtistViewController.m
//  Artisan
//
//  Created by Roger on 26/04/2018.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenTopArtistRow.h"
#import "ZenTopArtistViewController.h"

@interface ZenTopArtistViewController () <UITableViewDelegate>

@property (nonatomic, strong) RFTableView *tableView;
@property (nonatomic, strong) RFTableDataSource *dataSource;
@property (nonatomic, strong) RFTableSection *section;

@end

@implementation ZenTopArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热门音乐人";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_top_equalTo(RFStatusBarHeight);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reloadData {
    [self hideNetworkErrorView];
    [self startActivityIndicator];
    NSString *url = [[DoubanArtist sharedInstance] artists];
    weakify(self);
    [self get:url params:nil complete:^(__kindof NSObject * _Nullable responseData, NSInteger statusCode, NSError * _Nullable error) {
        strongify(self);
        [self stopActivityIndicator];
        if (error) {
            [self showNetworkErrorView];
            return;
        }
        
        NSString *json = [responseData json];
        DLog(@"json: %@", json);
        ZenTopArtistReponse *response = [ZenTopArtistReponse yy_modelWithJSON:json];
        [self appendRows:response];
    }];
}


- (void)appendRows:(ZenTopArtistReponse *)response {
    if (response.artists.count > 0) {
        [self.section removeAllChildren];
        [response.artists enumerateObjectsUsingBlock:^(ZenTopArtistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZenTopArtistRow *row = [[ZenTopArtistRow alloc] init];
            row.model = obj;
            [self.section addRow:row];
        }];
        [self.tableView reloadData];
    }
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

- (ZenTabBarItem *)zenTabBarItem {
    if (!_zenTabBarItem) {
        _zenTabBarItem = [[ZenTabBarItem alloc] init];
        _zenTabBarItem.tabBarItemStyle = ZenTabBarItemStyleIconfont;
        _zenTabBarItem.controller = self;
        [_zenTabBarItem setTitle:@"音乐人" forState:UIControlStateNormal];
        [_zenTabBarItem setIcon:icon_users forState:UIControlStateNormal];
        [_zenTabBarItem setColor:[UIColor zenBlackColor] forState:UIControlStateNormal];
        [_zenTabBarItem setColor:[UIColor zenGreenColor] forState:UIControlStateSelected];
    }
    return _zenTabBarItem;
}

@end
