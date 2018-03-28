//
//  ZenStatusBarOverlay.h
//  Zen
//
//  Created by roger on 13-5-16.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    ZenStatusBarOverlayTypeInfo,
    ZenStatusBarOverlayTypeSuccess,
    ZenStatusBarOverlayTypeWarning,
    ZenStatusBarOverlayTypeError
} ZenStatusBarOverlayType;

@interface ZenStatusBarOverlay : UIWindow

+ (ZenStatusBarOverlay *)sharedInstance;
- (void)postMessage:(NSString *)msg type:(ZenStatusBarOverlayType)type  dismissAfterDelay:(int)delay;
@end
