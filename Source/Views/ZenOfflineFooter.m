//
//  ZenOfflineFooter.m
//  Artisan
//
//  Created by roger on 14-10-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "ZenCategory.h"
#import "ZenOfflineFooter.h"

#define kZenButtonRealBlue ZenColorFromRGB(0x3498db)
#define kZenButtonRealBlueHL ZenColorFromRGB(0x2980b9)
#define kZenButtonRed ZenColorFromRGB(0xe74c3c)
#define kZenButtonRedHL ZenColorFromRGB(0xc0392b)

@implementation ZenOfflineFooter

- (void)awakeFromNib
{
    _pauseButton.frame = CGRectMake(20.0f, 2.0f, 112.0f, 40.0f);
    [_pauseButton setBackgroundImage:[UIImage imageWithColor:kZenButtonRed] forState:UIControlStateNormal];
    [_pauseButton setBackgroundImage:[UIImage imageWithColor:kZenButtonRedHL] forState:UIControlStateHighlighted];
    
    _startButton.frame = CGRectMake(188.0f, 2.0f, 112.0f, 40.0f);
    [_startButton setBackgroundImage:[UIImage imageWithColor:kZenButtonRealBlue] forState:UIControlStateNormal];
    [_startButton setBackgroundImage:[UIImage imageWithColor:kZenButtonRealBlueHL] forState:UIControlStateHighlighted];
}

@end
