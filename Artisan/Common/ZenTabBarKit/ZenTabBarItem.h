//
//  ZenTabBarItem.h
//  Artisan
//
//  Created by qianjie on 2018/5/3.
//  Copyright © 2018 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZenTabBarItemStyle) {
    ZenTabBarItemStyleImage = 0,
    ZenTabBarItemStyleIconfont = 1
};

@interface ZenTabBarItem : UIControl

@property (nonatomic, assign) ZenTabBarItemStyle tabBarItemStyle;
@property (nullable, nonatomic, weak) UIViewController *controller;

/**
 set color of item for different states

 @param color UIColor object
 @param state UIControlStateNormal or UIControlStateSelected
 */
- (void)setColor:(nonnull UIColor *)color forState:(UIControlState)state UI_APPEARANCE_SELECTOR;


/**
 set title of the item for different states

 @param title NSString object
 @param state UIControlStateNormal or UIControlStateSelected
 */
- (void)setTitle:(nonnull NSString *)title forState:(UIControlState)state;


/**
 set title of the item for different states
 
 @param icon NSString object
 @param state UIControlStateNormal or UIControlStateSelected
 */
- (void)setIcon:(nonnull NSString *)icon forState:(UIControlState)state;

/**
 set title of the item for different states

 @param image UIImage object
 @param state UIControlStateNormal or UIControlStateSelected
 */
- (void)setImage:(nonnull UIImage *)image forState:(UIControlState)state;

@end
