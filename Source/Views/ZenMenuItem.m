//
//  ZenMenuItem.m
//  Zen
//
//  Created by roger qian on 13-3-29.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "ZenCategory.h"
#import "ZenMenuItem.h"

#define kZenMenuMarginX 16.0f
#define kZenMenuLeftBtnWidth 44.0f
#define kZenMenuLeftBtnHeight 44.0f
#define kZenMenuPaddingLeft 1.0f

#define kZenMenuRightBtnWidth 185.0f
#define kZenMenuRightBtnHeight 44.0f


@interface ZenMenuItem ()
{
    UIImageView *_logo;
    UIImageView *_badge;
    UILabel *_title;
}

@end

@implementation ZenMenuItem


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat offsetY = (CGRectGetHeight(frame) - kZenMenuLeftBtnHeight);
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn addTarget:self action:@selector(menuItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn = leftBtn;
        _leftBtn.frame = CGRectMake(0.0f, offsetY, kZenMenuLeftBtnWidth, kZenMenuLeftBtnHeight);
        
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_right_arrow"]];
        logo.center = CGPointMake(CGRectGetWidth(_leftBtn.frame)/2.0f, CGRectGetHeight(_leftBtn.frame)/2.0f);
        logo.userInteractionEnabled = NO;
        _logo = logo;
        [_leftBtn addSubview:logo];
        
        [self addSubview:leftBtn];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn addTarget:self action:@selector(menuItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn = rightBtn;
        _rightBtn.frame = CGRectMake(kZenMenuLeftBtnWidth + kZenMenuPaddingLeft, offsetY, kZenMenuRightBtnWidth, kZenMenuRightBtnHeight);
        UILabel *title = [[UILabel alloc] init];
        title.userInteractionEnabled = NO;
        _title = title;
        [title setFont:kZenFont19];
        CGSize size = CGSizeMake(kZenMenuRightBtnWidth, 19.0f);
        title.textColor = [UIColor whiteColor];
        
        title.backgroundColor = [UIColor clearColor];
        [title setFrame:CGRectMake(kZenMenuMarginX, 0.0f, size.width, size.height)];
        CGPoint center = title.center;
        center.y = kZenMenuLeftBtnHeight/2.0f;
        [_rightBtn addSubview:title];
        title.center = center;
        
        UIImageView *badge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"badge"]];
        _badge = badge;
        [_rightBtn addSubview:badge];
        [_badge centerInVertical];
        
        CGRect badgeFrame = _badge.frame;
        badgeFrame.origin.x = CGRectGetWidth(_rightBtn.frame) - badgeFrame.size.width - 10.0f;
        _badge.frame = badgeFrame;
        _badge.hidden = YES;
        
        [self addSubview:_rightBtn];
        
        _status = ZenMenuItemStatusNormal;
        _style = ZenMenuItemStyleExpandable;
    }
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    _logo.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    _logo.center = CGPointMake(CGRectGetWidth(_leftBtn.frame)/2.0f, CGRectGetHeight(_leftBtn.frame)/2.0f);
    _logo.image = image;
}

- (void)setTitle:(NSString *)text
{
    _title.text = text;
}

- (void)setStyle:(ZenMenuItemStyle)style
{
    _style = style;
    if (style == ZenMenuItemStyleExpandable) {
        [self setImage:[UIImage imageNamed:@"menu_right_arrow"]];
    }
    else if(style == ZenMenuItemStyleSettings) {
        [self setImage:[UIImage imageNamed:@"menu_settings"]];
    }
    else if (style == ZenMenuItemStylePerson) {
        [self setImage:[UIImage imageNamed:@"menu_notifications"]];
    }
    else if (style == ZenMenuItemStyleArchived) {
        [self setImage:[UIImage imageNamed:@"menu_saved"]];
    }
    else if (style == ZenMenuItemStyleHotSongs) {
        [self setImage:[UIImage imageNamed:@"hot_songs"]];
    }
    else if (style == ZenMenuItemStyleHotArtists) {
        [self setImage:[UIImage imageNamed:@"hot_artists"]];
    }
    else if (style == ZenMenuItemStyleDownload) {
        [self setImage:[UIImage imageNamed:@"download"]];
    }
}

- (void)setColor:(UIColor *)color highlight:(UIColor *)hl
{
    [_leftBtn setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
    [_leftBtn setBackgroundImage:[UIImage imageWithColor:hl] forState:UIControlStateHighlighted];
    
    [_rightBtn setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
    [_rightBtn setBackgroundImage:[UIImage imageWithColor:hl] forState:UIControlStateHighlighted];
}

- (void)setStatus:(ZenMenuItemStatus)status
{
    _status = status;
    if (status == ZenMenuItemStatusExpanded) {
        CGAffineTransform transform =  CGAffineTransformRotate(_leftBtn.transform, M_PI/2.0f);
        _logo.transform = transform;
    }
    else {
        _logo.transform = CGAffineTransformIdentity;
    }
}

- (void)badge:(BOOL)flag
{
    _badge.hidden = !flag;
}

- (void)menuItemClicked:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(menuItemClicked:)]) {
        [_delegate menuItemClicked:self];
    }

    if (_style == ZenMenuItemStyleExpandable) {
        
        if (_status == ZenMenuItemStatusNormal) {
            [UIView animateWithDuration:0.2
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 CGAffineTransform transform =  CGAffineTransformRotate(_leftBtn.transform, M_PI/2.0f);
                                 _logo.transform = transform;
                             }
                             completion:^(BOOL finished) {
                                 if (finished) {
                                     _status = ZenMenuItemStatusExpanded;
                                 }
                             }];
        }
        else {
            [UIView animateWithDuration:0.2
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 _logo.transform = CGAffineTransformIdentity;
                             }
                             completion:^(BOOL finished) {
                                 if (finished) {
                                     
                                     _status = ZenMenuItemStatusNormal;
                                 }
                             }];
        }
        
    }
    
}

@end
