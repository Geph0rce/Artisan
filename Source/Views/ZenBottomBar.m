//
//  ZenBottomBar.m
//  Zen
//
//  Created by roger on 13-4-3.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "ZenBottomBar.h"

#define kZenBottomBtnMarginTop 5.0f
#define kZenBottomBtnMarginLeft 15.0f
#define kZenBottomBtnMarginRight 15.0f


@implementation ZenBottomBar
@synthesize leftItemType, midItemType, rightItemType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(frame), 1.0f)];
        line.backgroundColor = kZenBorderColor;
        [self addSubview:line];
        self.backgroundColor = kZenBackgroundColor;
        
    }
    return self;
}

- (UIButton *)buttonWithType:(ZenBottomBarItemType)type
{
    NSString *imageName = nil;
    if (type == ZenBottomBarItemTypeBack) {
        imageName = @"bottom_icon_back";
    }
    else if(type == ZenBottomBarItemTypeReturn){
        imageName = @"bottom_icon_return";
    }
    else if(type == ZenBottomBarItemTypeComment){
        imageName = @"bottom_icon_comment";
    }
    else if(type == ZenBottomBarItemTypeShare)
    {
        imageName = @"bottom_icon_share";
    }
    else if(type == ZenBottomBarItemTypeWrite){
        imageName = @"bottom_icon_write";
    }
    else if(type == ZenBottomBarItemTypeSave){
        imageName = @"bottom_icon_save";
    }
    else if(type == ZenBottomBarItemTypeRefresh){
        imageName = @"bottom_icon_refresh";
    }

    if (!imageName) {
        NSLog(@"invalid bottom bar item type.");
        return nil;
    }
    
    UIImage *icon = [UIImage imageNamed:imageName];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, 0.0f, icon.size.width, icon.size.height);
    [btn setImage:icon forState:UIControlStateNormal];
    return btn;
}


#pragma mark -
#pragma mark - Setters

- (void)setLeftItemType:(ZenBottomBarItemType)type
{
    UIButton *btn = [self buttonWithType:type];
    if (btn) {
        CGRect frame = btn.frame;
        frame.origin.x = kZenBottomBtnMarginLeft;
        frame.origin.y = kZenBottomBtnMarginTop;
        btn.frame = frame;
        [self addSubview:btn];
        _leftBtn = btn;
    }
}
- (void)setMidItemType:(ZenBottomBarItemType)type
{
    UIButton *btn = [self buttonWithType:type];
    if (btn) {
        CGRect frame = btn.frame;
        frame.origin.x = CGRectGetWidth(self.frame)/2.0 - CGRectGetWidth(frame)/2.0f;
        frame.origin.y = kZenBottomBtnMarginTop;
        btn.frame = frame;
        [self addSubview:btn];
        _midBtn = btn;
    }
}

- (void)setRightItemType:(ZenBottomBarItemType)type
{
    UIButton *btn = [self buttonWithType:type];
    if (btn) {
        CGRect frame = btn.frame;
        frame.origin.x = CGRectGetWidth(self.frame) - CGRectGetWidth(frame) -kZenBottomBtnMarginRight;
        frame.origin.y = kZenBottomBtnMarginTop;
        btn.frame = frame;
        [self addSubview:btn];
        _rightBtn = btn;
    }
}



#pragma mark -
#pragma mark - Targets and Actions

- (void)addLeftTarget:(id)target action:(SEL)action
{
    if (_leftBtn) {
        [_leftBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addMidTarget:(id)target action:(SEL)action
{
    if (_midBtn) {
        [_midBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addRightTarget:(id)target action:(SEL)action
{
    if (_rightBtn) {
        [_rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
