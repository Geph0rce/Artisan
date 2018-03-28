//
//  GCDHelper.h
//  Zen
//
//  Created by roger on 13-8-2.
//  Copyright (c) 2013年 Zen. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef void (^ZenGCDBlock)(void);

@interface GCDHelper : NSObject
+ (void)dispatchBlock:(ZenGCDBlock)block complete:(ZenGCDBlock)completion;
@end
