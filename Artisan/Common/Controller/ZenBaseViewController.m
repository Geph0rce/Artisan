//
//  ZenBaseViewController.m
//  Artisan
//
//  Created by qianjie on 2018/4/20.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenBaseViewController.h"
#import "DGActivityIndicatorView.h"

@interface ZenBaseViewController ()

@property (nonatomic, strong) DGActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UIView *networkErrorView;
@property (nonatomic, strong) UILabel *networkErrorIconLabel;
@property (nonatomic, strong) UILabel *networkErrorTitleLabel;
@property (nonatomic, strong) UILabel *networkErrorActionLabel;

@end

@implementation ZenBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.indicatorView];
    [self setupNetworkErrorView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.indicatorView.center = CGPointMake(self.view.width / 2.0, self.view.height / 2.0);
    [self.view bringSubviewToFront:self.indicatorView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Activity Indicator

- (void)startActivityIndicator {
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
}

- (void)stopActivityIndicator {
    [self.indicatorView stopAnimating];
    self.indicatorView.hidden = YES;
}

#pragma mark - Network Error View

- (void)setupNetworkErrorView {
    [self.view addSubview:self.networkErrorView];
    [self.networkErrorView addSubview:self.networkErrorIconLabel];
    [self.networkErrorView addSubview:self.networkErrorTitleLabel];
    [self.networkErrorView addSubview:self.networkErrorActionLabel];
    
    [self.networkErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_top_equalTo(self.topViewAttribute);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    [self.networkErrorIconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make_centerX_equalTo(self.networkErrorView);
        make_bottom_equalTo(self.view.mas_centerY);
    }];
    
    [self.networkErrorTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make_top_equalTo(self.networkErrorIconLabel.mas_bottom).offset(12.0);
        make_centerX_equalTo(self.networkErrorIconLabel);
    }];
    
    [self.networkErrorActionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make_top_equalTo(self.networkErrorTitleLabel.mas_bottom).offset(12.0);
        make_centerX_equalTo(self.networkErrorIconLabel);
    }];
}

- (void)showNetworkErrorView {
    [self.view bringSubviewToFront:self.networkErrorView];
    self.networkErrorView.hidden = NO;
}

- (void)hideNetworkErrorView {
    self.networkErrorView.hidden = YES;
}

- (void)reloadData {
    
}

#pragma mark - Custom Top Bar

- (BOOL)shouldUseCustomTopBar {
    return YES;
}

- (BOOL)automaticallyShowBackButton {
    return NO;
}

#pragma mark - Getters

- (DGActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallBeat tintColor:kRGB(0.0, 116.0, 123.0)];
        _indicatorView.hidden = YES;
    }
    return _indicatorView;
}

- (UIView *)networkErrorView {
    if (!_networkErrorView) {
        _networkErrorView = [[UIView alloc] init];
        _networkErrorView.backgroundColor = [UIColor whiteColor];
        _networkErrorView.hidden = YES;
        weakify(self);
        [_networkErrorView handleTapGestureWithBlock:^{
            strongify(self);
            [self reloadData];
        }];
    }
    return _networkErrorView;
}

- (UILabel *)networkErrorIconLabel {
    if (!_networkErrorIconLabel) {
        _networkErrorIconLabel = [[UILabel alloc] init];
        _networkErrorIconLabel.font = kIconFont(120.0);
        _networkErrorIconLabel.textColor = [UIColor lightGrayColor];
        _networkErrorIconLabel.text = icon_signal;
    }
    return _networkErrorIconLabel;
}

- (UILabel *)networkErrorTitleLabel {
    if (!_networkErrorTitleLabel) {
        _networkErrorTitleLabel = [[UILabel alloc] init];
        _networkErrorTitleLabel.font = kAppFont(15.0);
        _networkErrorTitleLabel.textColor = [UIColor lightGrayColor];
        _networkErrorTitleLabel.text = @"网络不可用，请检查网络";
    }
    return _networkErrorTitleLabel;
}

- (UILabel *)networkErrorActionLabel {
    if (!_networkErrorActionLabel) {
        _networkErrorActionLabel = [[UILabel alloc] init];
        _networkErrorActionLabel.font = kAppFont(14.0);
        _networkErrorActionLabel.textColor = [UIColor zenGreenColor];
        _networkErrorActionLabel.text = @"点击刷新";
    }
    return _networkErrorActionLabel;
}



@end
