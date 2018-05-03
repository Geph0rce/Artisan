//
//  ZenBaseViewController.h
//  Artisan
//
//  Created by qianjie on 2018/4/20.
//  Copyright © 2018 Zen. All rights reserved.
//

#import <RFCommonUI/RFCommonUI.h>
#import "UIViewController+CRFNetworking.h"
#import "NSObject+RFFilter.h"
#import "DoubanArtist.h"
#import "ZenTableHeaderRow.h"
#import "ZenTabBar.h"

@interface ZenBaseViewController : RFBaseViewController
{
    ZenTabBarItem *_zenTabBarItem;
}
@property (nonatomic, strong) ZenTabBarItem *zenTabBarItem;

- (void)startActivityIndicator;
- (void)stopActivityIndicator;

- (void)showNetworkErrorView;
- (void)hideNetworkErrorView;

- (void)reloadData;

@end
