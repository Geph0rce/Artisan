//
//  ZenBottomBar.h
//  Zen
//
//  Created by roger on 13-4-3.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ZenBottomBarItemTypeReturn,
    ZenBottomBarItemTypeBack,
    ZenBottomBarItemTypeShare,
    ZenBottomBarItemTypeComment,
    ZenBottomBarItemTypeWrite,
    ZenBottomBarItemTypeSave,
    ZenBottomBarItemTypeRefresh
} ZenBottomBarItemType;

@interface ZenBottomBar : UIView
{
    @private
    UIButton *_leftBtn;
    UIButton *_midBtn;
    UIButton *_rightBtn;
}

@property (nonatomic, assign) ZenBottomBarItemType leftItemType;
@property (nonatomic, assign) ZenBottomBarItemType midItemType;
@property (nonatomic, assign) ZenBottomBarItemType rightItemType;

- (void)addLeftTarget:(id)target action:(SEL)action;
- (void)addMidTarget:(id)target action:(SEL)action;
- (void)addRightTarget:(id)target action:(SEL)action;

@end
