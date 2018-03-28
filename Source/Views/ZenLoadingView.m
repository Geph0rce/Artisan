//
//  ZenLoadingView.m
//  Zen
//
//  Created by roger on 13-8-19.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "ZenConfig.h"
#import "ZenLoadingView.h"

#define kZenLoadingViewColor (kZenNightMode? ZenColorFromRGBA(0x181818):ZenColorFromRGBA(0xd9d9d9))
#define kZenStatusBarHeight 20.0f

#define kZenLoadingViewHeight 30.0f


@interface ZenLoadingView ()
{
    UILabel *_title;
    UIActivityIndicatorView *_indicator;
    CGFloat _before;
    CGFloat _after;
}
@end


@implementation ZenLoadingView

- (id)init
{
    CGFloat width = 320.0f;
    if (kZenDeviceiPad) {
        width = 768.0f;
    }
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, width, kZenLoadingViewHeight)];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = kZenLoadingViewColor;
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(kZenNightMode? UIActivityIndicatorViewStyleWhite : UIActivityIndicatorViewStyleGray)];
        [indicator setFrame:CGRectMake(20.0f, 5.0f, 20.0f, 20.0f)];
        [self addSubview:indicator];
        _indicator = indicator;
        
        UILabel *label = [[UILabel alloc] init];
        _title = label;
        label.backgroundColor = [UIColor clearColor];
        label.font = kZenFont13;
        label.frame = CGRectMake(0.0f, 0.0f, 240.0f, 14.0f);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"正在加载...";
        label.textColor = kZenMainFontColor;
        label.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, CGRectGetHeight(self.frame)/2.0f);
        [self addSubview:label];
        
        self.type = ZenLoadingViewTypeUnderStatusBar;
    }
    return self;

}


- (void)setTitle:(NSString *)title
{
    _title.text = title;
}

- (void)setType:(ZenLoadingViewType)type
{
    _type = type;
    
    BOOL flag = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0");
    
    if (_type == ZenLoadingViewTypeUnderStatusBar) {
        if (flag) {
            _before = -10.0f;
            _after = 20.0f;
        }
        else {
            _before = -30.0f;
            _after = 0.0f;
        }
    }
    
    else if (_type == ZenLoadingViewTypeUnderNavigationBar) {
        if (flag) {
            _before = 34.0f;
            _after = 64.0f;
        }
        else {
            _before = 14.0f;
            _after = 44.0f;
        }
    }
    
    CGRect frame = self.frame;
    frame.origin.y = _before;
    self.frame = frame;
}

#pragma mark -
#pragma mark Show and Hide animation

- (void)show
{
    self.hidden = NO;
    CGRect frame = self.frame;
    frame.origin.y = _after;
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.frame = frame;
                         [_indicator startAnimating];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
}


- (void)hide
{
    CGRect frame = self.frame;
    frame.origin.y = _before;
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [_indicator stopAnimating];
                         self.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         self.hidden = YES;
                     }];
    
}


@end
