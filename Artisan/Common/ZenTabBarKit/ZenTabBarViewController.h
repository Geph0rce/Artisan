//
//  ZenTabBarViewController.h
//  Artisan
//
//  Created by qianjie on 2018/5/3.
//  Copyright © 2018 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenBaseViewController.h"

@interface ZenTabBarViewController : UIViewController

@property (nonnull, nonatomic, strong) ZenTabBar *zenTabBar;
@property (nonatomic, assign) NSUInteger selectedIndex;

- (void)setViewControllers:(nonnull NSArray <ZenBaseViewController *> *)viewControllers;


@end
