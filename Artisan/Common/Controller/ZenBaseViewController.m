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

@end

@implementation ZenBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.indicatorView];
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

@end
