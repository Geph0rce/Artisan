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

@interface ZenBaseViewController : RFBaseViewController

- (void)startActivityIndicator;
- (void)stopActivityIndicator;

@end
