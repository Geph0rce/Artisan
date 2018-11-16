//
//  ZenArtistDetailViewController.m
//  Artisan
//
//  Created by qianjie on 2018/5/18.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenArtistHeaderView.h"
#import "ZenTopArtistRow.h"
#import "ZenArtistDetailViewController.h"


#define kZenArtistHeaderViewHeight (102.0 + RFStatusBarHeight + RFNavigationBarHeight)

@interface ZenArtistDetailViewController () <UITableViewDelegate>

@property (nonatomic, strong) RFTableView *tableView;
@property (nonatomic, strong) RFTableDataSource *dataSource;
@property (nonatomic, strong) RFTableSection *section;
@property (nonatomic, strong) ZenArtistHeaderView *headerContentView;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation ZenArtistDetailViewController

- (void)dealloc {
    DLog(@"dealloc");
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    self.title = self.model.name;
    [self setCustomNavigationBarHidden:YES animated:NO];
    FORBIDDEN_ADJUST_SCROLLVIEW_INSETS(self, self.tableView);
    [self setLeftTopBarItems:@[self.backBarButtonItem]];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerContentView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_edges_equalTo(self.view);
    }];
    
    [self.headerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_top_equalTo(0.0);
        make_left_equalTo(self.view);
        make_right_equalTo(self.view);
        make_height_equalTo(kZenArtistHeaderViewHeight);
    }];
    
    self.tableView.contentInset = UIEdgeInsetsMake(kZenArtistHeaderViewHeight, 0.0, 0.0, 0.0);
    [self.headerContentView reloadData:self.model];
    
    [self.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZenTopArtistRow *row = [[ZenTopArtistRow alloc] init];
        row.model = obj;
        [self.section addRow:row];
    }];
    [self.tableView reloadData];
//    [self.tableView layoutIfNeeded];
    [self.tableView setContentOffset:CGPointMake(0.0, -kZenArtistHeaderViewHeight)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)backBarButtonDidClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    return;
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
        
        if (yOffset < 0) {
            self.headerContentView.top = yOffset;
            self.headerContentView.height = -yOffset + kZenArtistHeaderViewHeight;
        }
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


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isEqual:self.tableView]) {
        CGPoint offset = self.tableView.contentOffset;
        DLog(@"offset: %@", @(offset.y));
        CGFloat top = -(offset.y + kZenArtistHeaderViewHeight);
        top = MAX(top, -64.0);
        top = MIN(top, 0.0);
        [self.headerContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make_top_equalTo(top);
        }];
        CGFloat insetTop = MIN(kZenArtistHeaderViewHeight, -offset.y);
       // self.tableView.contentInset = UIEdgeInsetsMake(insetTop, 0.0, 0.0, 0.0);

        [self.headerContentView layoutIfNeeded];
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
        [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
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


- (ZenArtistHeaderView *)headerContentView {
    if (!_headerContentView) {
        _headerContentView = [[ZenArtistHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, kZenArtistHeaderViewHeight)];
        _headerContentView.didSelectAvatar = ^{
            DLog(@"ava avatar!!!");
        };
    }
    return _headerContentView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        [_headerView addSubview:self.headerContentView];
        _headerView.frame = _headerContentView.bounds;
    }
    return _headerView;
}

@end
