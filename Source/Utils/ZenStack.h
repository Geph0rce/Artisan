//
//  ZenStack.h
//  Zen
//
//  Created by roger on 13-8-5.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZenStack : NSObject

+ (ZenStack *)sharedInstance;

- (void)push:(UIViewController *)controller;
- (void)pop:(UIViewController *)controller;

@end
