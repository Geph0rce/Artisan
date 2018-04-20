//
//  RFScreen.m
//  demo
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 Zen. All rights reserved.
//

#import "RFNetworkingMacros.h"
#import "RFScreen.h"

@implementation RFScreen

RFSingleton(RFScreen);

#pragma mark util

- (CGFloat)isiPhoneX {
    return (self.screenHeight == 812.0f);
}

#pragma mark Getters

- (CGFloat)screenWidth {
    static CGFloat screenWidth;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    });
    return screenWidth;
}

- (CGFloat)screenHeight {
    static CGFloat screenHeight;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    });
    return screenHeight;
}

- (CGFloat)screenScale {
    static CGFloat screenScale;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        screenScale = [UIScreen mainScreen].scale;
    });
    return screenScale;
}

- (CGFloat)statusBarHeight {
    return ([self isiPhoneX] ? 44.0 : 20.0);
}

- (CGFloat)navigationBarHeight {
    return 44.0;
}

- (CGFloat)navigationBarBottom {
    return self.statusBarHeight + self.navigationBarHeight;
}

@end
