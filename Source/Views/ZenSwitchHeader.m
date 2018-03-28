//
//  ZenSwitchHeader.m
//  Artisan
//
//  Created by roger on 14-9-28.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "ZenCategory.h"
#import "ZenSwitchHeader.h"

#define kZenSwitchHeaderBackgroundColor ZenColorFromRGBA(0xffffff)
#define kZenSwitchHeaderNormalColor [UIColor blackColor]
#define kZenSwitchHeaderHighlightColor ZenColorFromRGB(0x1abc9c)
#define kZenSwitchSliderFrameLeft CGRectMake(0.0f, 44.0f, 160.0f, 2.0f)
#define kZenSwitchSliderFrameRight CGRectMake(160.0f, 44.0f, 160.0f, 2.0f)

@interface ZenSwitchHeader ()
{
    ZenSwitchTag _tag;
}
@end

@implementation ZenSwitchHeader

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
    _firstBtn.titleLabel.font = kZenFont15;
    _firstBtn.backgroundColor = [UIColor clearColor];
    [_firstBtn setTitleColor:kZenSwitchHeaderHighlightColor forState:UIControlStateNormal];
    [_firstBtn setTitleColor:kZenSwitchHeaderHighlightColor forState:UIControlStateHighlighted];
    _firstBtn.tag = ZenSwitchTagFirst;
    [_firstBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _secondBtn.titleLabel.font = kZenFont15;
    _secondBtn.backgroundColor = [UIColor clearColor];
    [_secondBtn setTitleColor:kZenSwitchHeaderNormalColor forState:UIControlStateNormal];
    [_secondBtn setTitleColor:kZenSwitchHeaderHighlightColor forState:UIControlStateHighlighted];
    _secondBtn.tag = ZenSwitchTagSecond;
    [_secondBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _slider.backgroundColor = kZenSwitchHeaderHighlightColor;
    _tag = ZenSwitchTagFirst;
}

- (void)onClick:(UIView *)view
{
    ZenSwitchTag tag = (ZenSwitchTag)view.tag;
    
    if (_tag != tag) {
        CGRect frameAfterAnimation = CGRectZero;
        if (_tag == ZenSwitchTagFirst) {
            frameAfterAnimation = kZenSwitchSliderFrameRight;
            [_firstBtn setTitleColor:kZenSwitchHeaderNormalColor forState:UIControlStateNormal];
            [_secondBtn setTitleColor:kZenSwitchHeaderHighlightColor forState:UIControlStateNormal];
            
        }
        else {
            frameAfterAnimation = kZenSwitchSliderFrameLeft;
            [_firstBtn setTitleColor:kZenSwitchHeaderHighlightColor forState:UIControlStateNormal];
            [_secondBtn setTitleColor:kZenSwitchHeaderNormalColor forState:UIControlStateNormal];
        }
        [UIView animateWithDuration:0.2
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _slider.frame = frameAfterAnimation;
                         }
                         completion:^(BOOL finished) {
                             if (_delegate && [_delegate respondsToSelector:@selector(onZenSwitchHeaderValueChanged:)]) {
                                 [_delegate onZenSwitchHeaderValueChanged:tag];
                             }
                         }];
        _tag = tag;
    }
    
}

@end
