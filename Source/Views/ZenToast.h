//
//  ZenToast.h
//  Artisan
//
//  Created by roger on 14-9-28.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZenToastTypeSuccess,
    ZenToastTypeWarning,
    ZenToastTypeError
} ZenToastType;

@interface ZenToast : UIWindow

+ (ZenToast *)sharedInstance;
- (void)postMessage:(NSString *)msg type:(ZenToastType)type dismissAfterDelay:(int)delay;

@end
