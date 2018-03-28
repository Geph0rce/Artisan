//
//  ZenStatusBarOverlay.m
//  Zen
//
//  Created by roger on 13-5-16.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import "UIColor+MLPFlatColors.h"
#import "ZenMacros.h"
#import "Singleton.h"
#import "ZenStatusBarOverlay.h"

#define kZenAnimationMargin (kZenDeviceiPad? 40.0f : 20.0f)
#define kZenAnimationWidth (kZenDeviceiPad? 768.0f : 320.0f)
#define kZenBeforeAnimationFrameForiOS6 CGRectMake(0.0f, 0.0f, kZenAnimationWidth, 20.0f)
#define kZenBeforeAnimationFrameForiOS7 CGRectMake(0.0f, -40.0f, kZenAnimationWidth, 40.0f)
#define kZenAfterAnimationFrameForiOS6 CGRectMake(0.0f, 20.0f, kZenAnimationWidth, 20.0f)
#define kZenAfterAnimationFrameForiOS7 CGRectMake(0.0f, 0.0f, kZenAnimationWidth, 40.0f)
#define kZenLabelFrameForiOS6 CGRectMake(kZenAnimationMargin, 0.0f, 300.0f, 20.0f)
#define kZenLabelFrameForiOS7 CGRectMake(kZenAnimationMargin, 20.0f, 300.0f, 20.0f)
#define kZenStatusEaseOutAnimationDuration 0.4f
#define kZenStatusEaseInAnimationDuration 0.3f

@interface ZenStatusBarOverlay ()
{
    UILabel *_label;
}
@end

@implementation ZenStatusBarOverlay

SINGLETON_FOR_CLASS(ZenStatusBarOverlay);

- (id)init
{
    CGRect frame = CGRectZero;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        frame = kZenBeforeAnimationFrameForiOS7;
    }
    else {
        frame = kZenBeforeAnimationFrameForiOS6;
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelNormal;
        self.backgroundColor = [UIColor flatBlueColor];
        self.frame = frame;
        CGRect labelFrame = CGRectZero;
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            labelFrame = kZenLabelFrameForiOS7;
        }
        else {
            labelFrame = kZenLabelFrameForiOS6;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
        label.backgroundColor = [UIColor clearColor];
        label.font = kZenFont15;
        label.textColor = [UIColor flatWhiteColor];
        _label = label;
        [self addSubview:label];
    }
    return self;
}

- (void)pickColorForType:(ZenStatusBarOverlayType)type
{
    _label.textColor = [UIColor flatWhiteColor];
    if (type == ZenStatusBarOverlayTypeInfo) {
        self.backgroundColor = [UIColor flatGreenColor];
    }
    else if (type == ZenStatusBarOverlayTypeSuccess) {
        self.backgroundColor = [UIColor flatBlueColor];
    }
    
    else if(type == ZenStatusBarOverlayTypeError){
        self.backgroundColor = [UIColor flatRedColor];
    }
    else if(type == ZenStatusBarOverlayTypeWarning)
    {
        self.backgroundColor = [UIColor flatYellowColor];
        _label.textColor = [UIColor flatBlackColor];
    }
    else {
        self.backgroundColor = [UIColor flatBlueColor];
    }
}

- (void)postMessage:(NSString *)msg type:(ZenStatusBarOverlayType)type dismissAfterDelay:(int)delay
{
    if (!self.hidden) {
        NSLog(@"posting msg, try latter.");
        return;
    }
    CGRect frameBeforeAnimation = CGRectZero;
    CGRect frameAfterAnimation = CGRectZero;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        frameBeforeAnimation = kZenBeforeAnimationFrameForiOS7;
        frameAfterAnimation = kZenAfterAnimationFrameForiOS7;
    }
    else {
        frameBeforeAnimation = kZenBeforeAnimationFrameForiOS6;
        frameAfterAnimation = kZenAfterAnimationFrameForiOS6;
    }
    
    [self pickColorForType:type];
    
    self.frame = frameBeforeAnimation;
    self.hidden = NO;
    _label.text = msg;
    
    [UIView animateWithDuration:kZenStatusEaseOutAnimationDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.frame = frameAfterAnimation;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:kZenStatusEaseInAnimationDuration
                                               delay:delay
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              self.frame = frameBeforeAnimation;
                                          }
                                          completion:^(BOOL finished) {
                                              self.hidden = YES;
                                          }];
                     }];
}

@end
