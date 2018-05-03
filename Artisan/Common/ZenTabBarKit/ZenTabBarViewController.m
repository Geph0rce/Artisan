//
//  ZenTabBarViewController.m
//  Artisan
//
//  Created by qianjie on 2018/5/3.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenTabBarViewController.h"

@interface ZenTabBarViewController () <ZenTabBarDelegate>

@property (nonatomic, strong) NSMutableArray <ZenBaseViewController *> *controllers;
@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation ZenTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.zenTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.zenTabBar.top = self.view.height - self.zenTabBar.height;
    self.currentViewController.view.width = self.view.width;
    self.currentViewController.view.height = self.view.height - self.zenTabBar.height;
}

#pragma mark - Public API

- (void)setViewControllers:(nonnull NSArray <ZenBaseViewController *> *)viewControllers {
    for (ZenBaseViewController *controller in self.controllers) {
        [controller.view removeFromSuperview];
    }
    [self.controllers removeAllObjects];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (ZenBaseViewController *controller in viewControllers) {
        if (controller.zenTabBarItem) {
            [items addObject:controller.zenTabBarItem];
        }
        [self.controllers addObject:controller  ];
    }
    [self.zenTabBar setItems:items];
}

#pragma mark - ZenTabBarDelegate

- (void)tabBar:(ZenTabBar *)tabBar didSelectItem:(ZenTabBarItem *)item {
    [self.currentViewController viewWillDisappear:NO];
    [self.currentViewController.view removeFromSuperview];
    [self.currentViewController viewDidDisappear:NO];
    
    self.currentViewController = item.controller;
    [self.currentViewController viewWillAppear:NO];
    [self.view addSubview:self.currentViewController.view];
    self.currentViewController.view.width = self.view.width;
    self.currentViewController.view.height = self.view.height - self.zenTabBar.height;
    [self.currentViewController viewDidDisappear:NO];
}

#pragma mark - Getters

- (NSMutableArray *)controllers {
    if (!_controllers) {
        _controllers = [[NSMutableArray alloc] init];
    }
    return _controllers;
}

- (ZenTabBar *)zenTabBar {
    if (!_zenTabBar) {
        _zenTabBar = [[ZenTabBar alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 48.0)];
        _zenTabBar.backgroundColor = [UIColor whiteColor];
        _zenTabBar.delegate = self;
    }
    return _zenTabBar;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (selectedIndex < self.controllers.count) {
        _selectedIndex = selectedIndex;
        self.zenTabBar.selectedItem = self.controllers[_selectedIndex].zenTabBarItem;
    }
}

@end
