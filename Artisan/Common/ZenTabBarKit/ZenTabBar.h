//
//  ZenTabBar.h
//  Artisan
//
//  Created by qianjie on 2018/5/3.
//  Copyright © 2018 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenTabBarItem.h"

@protocol ZenTabBarDelegate;

@interface ZenTabBar : UIView

@property (nullable, nonatomic, weak) NSObject<ZenTabBarDelegate> *delegate;
@property (nullable, nonatomic, weak) ZenTabBarItem *selectedItem;

- (void)setItems:(nonnull NSArray<ZenTabBarItem *> *)items;

@end


@protocol ZenTabBarDelegate<NSObject>

@optional
- (void)tabBar:(nonnull ZenTabBar *)tabBar didSelectItem:(nonnull ZenTabBarItem *)item;

@end
