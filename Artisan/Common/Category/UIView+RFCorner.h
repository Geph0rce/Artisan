//
//  UIView+RFCorner.h
//  demo
//
//  Created by qianjie on 2017/12/25.
//  Copyright © 2017年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (RFCorner)

- (void)addCorner:(UIRectCorner)corner radius:(CGFloat)radius;
- (void)addCorner:(UIRectCorner)corner rect:(CGRect)rect radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
