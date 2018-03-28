//
//  ZenNavigationBar.m
//  Zen
//
//  Created by roger on 13-8-5.
//  Copyright (c) 2013年 Zen. All rights reserved.
//
#import "UIColor+MLPFlatColors.h"
#import "ZenMacros.h"
#import "ZenCategory.h"
#import "ZenNavigationBar.h"

#define kZenNavigationBarTitleColor [UIColor whiteColor]
#define kDefaultBarColor ZenColorFromRGB(0x1abc9c)
#define kHighlightBarColor ZenColorFromRGB(0x16a085)
#define kZenNavigationBarH 44.0f

#define kZenButtonRealBlue ZenColorFromRGB(0x3498db)
#define kZenButtonRealBlueHL ZenColorFromRGB(0x2980b9)
#define kZenButtonRed ZenColorFromRGB(0xe74c3c)
#define kZenButtonRedHL ZenColorFromRGB(0xc0392b)

@interface ZenNavigationBar ()
{
    CGFloat _paddingY;
    UIButton *_leftBtn;
    UIButton *_rightBtn;
    UIImageView *_badge;
    UILabel *_title;
    UILabel *_confirmLabel;
}

@end

@implementation ZenNavigationBar

- (id)init
{
    _paddingY = 0;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        _paddingY = 20.0f;
    }
    if (kZenDeviceiPad) {
        self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 768.0f, kZenNavigationBarH + _paddingY)];
    }
    else {
        self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, kZenNavigationBarH + _paddingY)];
    }
    _height = kZenNavigationBarH + _paddingY;
    
    if (self) {
        [self setBackgroundColor:kDefaultBarColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = kZenNavigationBarTitleColor;
        CGSize size = CGSizeMake(220.0f, 40.0f);
        label.font = kZenFont16;
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        label.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, ((CGRectGetHeight(self.frame) - _paddingY)/2.0f) + _paddingY);
        _title = label;
        [self addSubview:label];
    }

    return self;
}

- (void)addLeftButtonWithTarget:(id)target action:(SEL)action
{
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10.0f, _paddingY + 8.0f, 60.0f, 28.0f);
    [cancelBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundImage:[UIImage imageWithColor:kZenButtonRed] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[UIImage imageWithColor:kZenButtonRedHL] forState:UIControlStateHighlighted];
    UILabel *cancelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 60.0f, 28.0f)];
    cancelLabel.text = @"取消";
    cancelLabel.font = kZenFont13;
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    cancelLabel.backgroundColor = [UIColor clearColor];
    cancelLabel.textColor = [UIColor whiteColor];
    [cancelBtn addSubview:cancelLabel];
    
    [self addSubview:cancelBtn];
}

- (void)addRightButtonWithTarget:(id)target action:(SEL)action
{
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.frame = CGRectMake(CGRectGetWidth(self.frame) - 70.0f, _paddingY + 8.0f, 60.0f, 28.0f);
    [confirmBtn setBackgroundImage:[UIImage imageWithColor:kDefaultBarColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[UIImage imageWithColor:kHighlightBarColor] forState:UIControlStateHighlighted];
    UILabel *confirmLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 60.0f, 28.0f)];
    _confirmLabel = confirmLabel;
    confirmLabel.text = @"确定";
    confirmLabel.font = kZenFont13;
    confirmLabel.textAlignment = NSTextAlignmentCenter;
    confirmLabel.backgroundColor = [UIColor clearColor];
    confirmLabel.textColor = [UIColor whiteColor];
    [confirmBtn addSubview:confirmLabel];
    _rightBtn = confirmBtn;
    [self addSubview:confirmBtn];
}

- (void)setRightButtonTitle:(NSString *)text
{
    _confirmLabel.text = text;
}

- (void)setRightButtonHidden:(BOOL)flag
{
    _rightBtn.hidden = flag;
}

- (void)addLeftItemWithStyle:(ZenNavigationItemStyle)style target:(id)target action:(SEL)action
{
    if (_leftBtn) {
        NSLog(@"leftBtn already exists.");
        return;
    }
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageWithColor:kHighlightBarColor ] forState:UIControlStateHighlighted];
    _leftBtn = leftBtn;
    [leftBtn setFrame:CGRectMake(0.0f, _paddingY, 44.0f, 44.0f)];
    [self addSubview:_leftBtn];
    [_leftBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *badge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"badge1"]];
    CGRect frame = badge.frame;
    frame.origin.x = 2.0f;
    frame.origin.y = 4.0f;
    badge.frame = frame;
    badge.hidden = YES;
    _badge = badge;
    [_leftBtn addSubview:badge];
    
    switch (style) {
        case ZenNavigationItemStyleMenu:
             [_leftBtn setImage:[UIImage imageNamed:@"menu"] forState:
              UIControlStateNormal];
            break;
        case ZenNavigationItemStyleBack:
             [_leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            break;
        case ZenNavigationItemStyleCancel:
             [_leftBtn setImage:[UIImage imageNamed:@"nav-icon-cancel"] forState:UIControlStateNormal];
        default:
            break;
    }
}

- (void)addRightItemWithStyle:(ZenNavigationItemStyle)style target:(id)target action:(SEL)action
{
    if (_rightBtn) {
        NSLog(@"rightBtn already exists.");
        return;
    }
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(CGRectGetWidth(self.frame) - 44.0f, _paddingY, 44.0f, 44.0f)];
    [rightBtn setBackgroundImage:[UIImage imageWithColor:kHighlightBarColor ] forState:UIControlStateHighlighted];
    _rightBtn = rightBtn;
    [self addSubview:_rightBtn];
    [_rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    switch (style) {
        case ZenNavigationItemStyleShare:
            [_rightBtn setImage:[UIImage imageNamed:@"nav-icon-share"] forState:UIControlStateNormal];
            break;
        case ZenNavigationItemStyleMore:
            [_rightBtn setImage:[UIImage imageNamed:@"nav-icon-more"] forState:UIControlStateNormal];
            break;
        case ZenNavigationItemStyleAddUser:
            [_rightBtn setImage:[UIImage imageNamed:@"nav-icon-adduser"] forState:UIControlStateNormal];
            break;
        case ZenNavigationItemStyleWrite:
            [_rightBtn setImage:[UIImage imageNamed:@"nav-icon-write"] forState:UIControlStateNormal];
            break;
        case ZenNavigationItemStyleOk:
             [_rightBtn setImage:[UIImage imageNamed:@"nav-icon-ok"] forState:UIControlStateNormal];
            break;
        case ZenNavigationItemStyleOffline:
            [_rightBtn setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
        default:
            break;
    }
 
}

- (void)setRightItemEnabled:(BOOL)enable
{
    if (_rightBtn) {
        [_rightBtn setEnabled:enable];
    }
}

- (void)refresh
{
    self.backgroundColor = kZenBackgroundColor;
    [_leftBtn setBackgroundImage:[UIImage imageWithColor:kHighlightBarColor ] forState:UIControlStateHighlighted];
    [_rightBtn setBackgroundImage:[UIImage imageWithColor:kHighlightBarColor ] forState:UIControlStateHighlighted];
    _title.textColor = [UIColor whiteColor];
}

- (void)setTitle:(NSString *)title
{
    _title.text = title;
}

- (void)badge:(BOOL)flag
{
    _badge.hidden = !flag;
}

@end
