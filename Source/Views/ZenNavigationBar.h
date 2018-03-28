//
//  ZenNavigationBar.h
//  Zen
//
//  Created by roger on 13-8-5.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ZenNavigationItemStyleNone = 0,
    ZenNavigationItemStyleMenu,
    ZenNavigationItemStyleBack,
    ZenNavigationItemStyleAddUser,
    ZenNavigationItemStyleMore,
    ZenNavigationItemStyleShare,
    ZenNavigationItemStyleWrite,
    ZenNavigationItemStyleCancel,
    ZenNavigationItemStyleOk,
    ZenNavigationItemStyleOffline
}ZenNavigationItemStyle;

@interface ZenNavigationBar : UIView
{
    CGFloat _height;
}

@property (nonatomic, assign) CGFloat height;

- (void) setTitle:(NSString *)title;

- (void)addLeftButtonWithTarget:(id)target action:(SEL)action;
- (void)addRightButtonWithTarget:(id)target action:(SEL)action;
- (void)setRightButtonTitle:(NSString *)text;
- (void)setRightButtonHidden:(BOOL)flag;

- (void)addLeftItemWithStyle:(ZenNavigationItemStyle)style target:(id)target action:(SEL)action;
- (void)addRightItemWithStyle:(ZenNavigationItemStyle)style target:(id)target action:(SEL)action;
- (void)setRightItemEnabled:(BOOL)enable;

- (void)badge:(BOOL)flag;

- (void)refresh;

@end
