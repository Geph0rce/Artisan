//
//  ZenMoreOptionsView.m
//  ZenPro
//
//  Created by roger on 13-12-26.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "ZenConfig.h"
#import "ZenCategory.h"
#import "ZenMoreOptionsView.h"

#define kZenOptionHeight (kZenDeviceiPad? 100.0f : 80.0f)
#define kZenOptionItemHeight (kZenDeviceiPad? 70.0f : 55.0f)
#define kZenOptionMargin (kZenDeviceiPad? 10.0f : 4.0f)

#define kZenButtonRealBlue ZenColorFromRGB(0x3498db)
#define kZenButtonRealBlueHL ZenColorFromRGB(0x2980b9)
#define kZenButtonRed ZenColorFromRGB(0xe74c3c)
#define kZenButtonRedHL ZenColorFromRGB(0xc0392b)
#define kZenButtonPurple ZenColorFromRGB(0x654b6b)
#define kZenButtonPurpleHL ZenColorFromRGB(0x443248)
#define kZenButtonNavy ZenColorFromRGB(0x34495e)
#define kZenButtonNavyHL ZenColorFromRGB(0x2c3e50)

@interface ZenMoreOptionsView ()
{
    UIView *_mask;
    UIView *_container;
}

@end

@implementation ZenMoreOptionsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        UIView *mask = [[UIView alloc] initWithFrame:self.bounds];
        [mask addGestureRecognizer:tap];
        _mask = mask;
        mask.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f];
        [self addSubview:mask];
        
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(frame), CGRectGetWidth(frame), kZenOptionHeight)];
        container.backgroundColor = kZenBackgroundColor;
        _container = container;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_container.frame), 1.0f)];
        line.backgroundColor = kZenBorderColor;
        [container addSubview:line];
        
        CGFloat offsetX = kZenOptionMargin;
        CGFloat width = (CGRectGetWidth(_container.frame) - 5 * kZenOptionMargin)/4.0f;
        CGFloat marginTop = (CGRectGetHeight(_container.frame) - kZenOptionItemHeight)/2.0f;
        CGPoint center  = CGPointMake(width/2.0f, kZenOptionItemHeight/2.0f);
        
        UIImageView *refreshLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more_refresh"]];
        refreshLogo.center = center;
        UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        refreshBtn.frame = CGRectMake(offsetX, marginTop, width, kZenOptionItemHeight);
        [refreshBtn setBackgroundImage:[UIImage imageWithColor:kZenButtonRed] forState:UIControlStateNormal];
        [refreshBtn setBackgroundImage:[UIImage imageWithColor:kZenButtonRedHL] forState:UIControlStateHighlighted];
        [refreshBtn addTarget:self action:@selector(optionItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [refreshBtn addSubview:refreshLogo];
        refreshBtn.tag = ZenMoreOptionsItemTypeRefresh;
        [_container addSubview:refreshBtn];
        
        offsetX += width + kZenOptionMargin;
        UIImageView *replyLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more_reply"]];
        replyLogo.center = center;
        UIButton *replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        replyBtn.frame = CGRectMake(offsetX, marginTop, width, kZenOptionItemHeight);
        [replyBtn setBackgroundImage:[UIImage imageWithColor:kZenButtonPurple] forState:UIControlStateNormal];
        [replyBtn setBackgroundImage:[UIImage imageWithColor:kZenButtonPurpleHL] forState:UIControlStateHighlighted];
        [replyBtn addTarget:self action:@selector(optionItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [replyBtn addSubview:replyLogo];
        replyBtn.tag = ZenMoreOptionsItemTypeReply;
        [_container addSubview:replyBtn];
        
         offsetX += width + kZenOptionMargin;
        UIImageView *archiveLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more_archive"]];
        archiveLogo.center = center;
        UIButton *archiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        archiveBtn.frame = CGRectMake(offsetX, marginTop, width, kZenOptionItemHeight);
        [archiveBtn setBackgroundImage:[UIImage imageWithColor:kZenButtonNavy] forState:UIControlStateNormal];
        [archiveBtn setBackgroundImage:[UIImage imageWithColor:kZenButtonNavyHL] forState:UIControlStateHighlighted];
        [archiveBtn addTarget:self action:@selector(optionItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [archiveBtn addSubview:archiveLogo];
        archiveBtn.tag = ZenMoreOptionsItemTypeArchive;
        [_container addSubview:archiveBtn];

        
        offsetX += width + kZenOptionMargin;
        UIImageView *shareLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more_share"]];
        shareLogo.center = center;
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(offsetX, marginTop, width, kZenOptionItemHeight);
        [shareBtn setBackgroundImage:[UIImage imageWithColor:kZenButtonRealBlue] forState:UIControlStateNormal];
        [shareBtn setBackgroundImage:[UIImage imageWithColor:kZenButtonRealBlueHL] forState:UIControlStateHighlighted];
        [shareBtn addTarget:self action:@selector(optionItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [shareBtn addSubview:shareLogo];
        shareBtn.tag = ZenMoreOptionsItemTypeShare;
        [_container addSubview:shareBtn];
        
        [self addSubview:container];
        
    }
    return self;
}

- (void)show
{
    _mask.alpha = 0.0f;
    __block CGRect frame = _container.frame;
    frame.origin.y = CGRectGetHeight(self.frame);
    _container.frame = frame;
    self.hidden = NO;
    [UIView animateWithDuration:0.18f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         frame.origin.y = CGRectGetHeight(self.frame) - kZenOptionHeight;
                         _mask.alpha = 0.8f;
                         _container.frame = frame;
                     }
                      completion:NULL
     ];
}

- (void)hide
{
    __block CGRect frame = _container.frame;
    frame.origin.y = CGRectGetHeight(self.frame);
    
    [UIView animateWithDuration:0.18f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _mask.alpha = 0.0f;
                         _container.frame = frame;
                         
                     }
                     completion:^(BOOL finished) {
                         self.hidden = YES;
                     }
     ];
}

#pragma mark -

- (void)optionItemClicked:(id)sender
{
    UIView *item = (UIView *)sender;
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedOption:)]) {
        [_delegate didSelectedOption:(ZenMoreOptionsItemType)item.tag];
    }
}

- (void)tap:(UITapGestureRecognizer *)recognizer
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedOption:)]) {
        [_delegate didSelectedOption:ZenMoreOptionsItemTypeHide];
    }
}

@end
