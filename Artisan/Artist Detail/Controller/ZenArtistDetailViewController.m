//
//  ZenArtistDetailViewController.m
//  Artisan
//
//  Created by qianjie on 2018/5/18.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenArtistHeaderRow.h"
#import "ZenArtistDetailViewController.h"

@interface ZenArtistDetailViewController () <UITableViewDelegate>

@property (nonatomic, strong) RFTableView *tableView;
@property (nonatomic, strong) RFTableDataSource *dataSource;
@property (nonatomic, strong) RFTableSection *section;

@end

@implementation ZenArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.name;
    FORBIDDEN_ADJUST_SCROLLVIEW_INSETS(self, self.tableView);
    [self setLeftTopBarItems:@[self.backBarButtonItem]];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_edges_equalTo(self.view);
    }];
    
    ZenArtistHeaderRow *row = [[ZenArtistHeaderRow alloc] init];
    row.model = self.model;
    [self.section addRow:row];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)backBarButtonDidClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat maxOpaqueOffset = 102.0;
    if (scrollView == self.tableView) {
        let yOffset = self.tableView.contentOffset.y;
        CGFloat alpha = 0;
        if (yOffset > 0 && yOffset <= maxOpaqueOffset) {
            alpha = yOffset / maxOpaqueOffset;
        }
        else if (yOffset > maxOpaqueOffset) {
            alpha = 1;
        } 
        [self updateCustomTopBarBackgroundAlpha:alpha];
    }
}


#pragma mark - Custom Top Bar

- (void)updateCustomTopBarBackgroundAlpha:(CGFloat)alpha {
    alpha = MIN(1, alpha);
    alpha = MAX(0, alpha);
    [super updateCustomTopBarBackgroundAlpha:alpha];
    [self.customTopBar.titleLabel setAlpha:alpha];
    UIButton *backButton = (id)[[self.leftTopBarItems firstObject] view];
    if (alpha > 0.7) {
        backButton.titleLabel.backgroundColor = [UIColor clearColor];
        [backButton setTitleColor:[UIColor zenBlackColor] forState:UIControlStateNormal];
    } else {
        backButton.titleLabel.backgroundColor = [[UIColor zenBlackColor] colorWithAlphaComponent:0.6];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (BOOL)shouldCustomTopBarBackgroundAppearedAlpha0 {
    return YES;
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
