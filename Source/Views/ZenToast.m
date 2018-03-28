//
//  ZenToast.m
//  Artisan
//
//  Created by roger on 14-9-28.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "Singleton.h"
#import "ZenMacros.h"
#import "ZenCategory.h"
#import "ZenToast.h"

#define kZenToastHeight 40.0f
#define kZenScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kZenScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

#define kZenToastFrameBeforeAnimation CGRectMake(0.0f, kZenScreenHeight, kZenScreenWidth, kZenToastHeight)
#define kZenToastFrameAfterAnimation CGRectMake(0.0f, kZenScreenHeight - kZenToastHeight, kZenScreenWidth, kZenToastHeight)

#define kZenColorRealBlue ZenColorFromRGB(0x3498db)
#define kZenColorOrange ZenColorFromRGB(0xe67e22)
#define kZenColorRed ZenColorFromRGB(0xe74c3c)

@interface ZenToast ()
{
    UILabel *_label;
}

@end

@implementation ZenToast

SINGLETON_FOR_CLASS(ZenToast)

- (id)init
{
    CGRect frame = CGRectMake(0.0f, kZenScreenHeight, kZenScreenWidth, kZenToastHeight);
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelNormal + 1.0f;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, kZenScreenWidth - 40.0f, 18.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = kZenFont15;
        label.textColor = [UIColor whiteColor];
        _label = label;
        [self addSubview:label];
        [label centerInVertical];
    }
    return self;
}

- (UIColor *)colorWithToastType:(ZenToastType)type
{
    if (type == ZenToastTypeSuccess) {
        return kZenColorRealBlue;
    }
    else if (type == ZenToastTypeWarning) {
        return kZenColorOrange;
    }
    else if (type == ZenToastTypeError) {
        return  kZenColorRed;
    }
    return kZenColorRealBlue;
}

- (void)postMessage:(NSString *)msg type:(ZenToastType)type dismissAfterDelay:(int)delay
{
    self.frame = kZenToastFrameBeforeAnimation;
    self.hidden = NO;
    _label.text = msg;
    self.backgroundColor = [self colorWithToastType:type];
    
    [UIView animateWithDuration:0.4f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.frame = kZenToastFrameAfterAnimation;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3f
                                               delay:delay
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              self.frame = kZenToastFrameBeforeAnimation;
                                          }
                                          completion:^(BOOL finished) {
                                              self.hidden = YES;
                                          }];
                     }];
}


@end
