//
//  ZenConfig.h
//  Zen
//
//  Created by roger qian on 13-3-13.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kZenConfigRefreshTimeNotification @"ZenConfigRefreshTimeNotification"
#define kZenConfigStopPlayNotification @"ZenConfigStopPlayNotification"
#define kZenConfigStopOfflineNotification @"ZenConfigStopOfflineNotification"

@interface ZenConfig : NSObject
{
    BOOL _cellularOffline;
    BOOL _cellularPlay;
    NSUInteger _time;
    NSUInteger _index;
}

@property (nonatomic, assign) BOOL cellularOffline;
@property (nonatomic, assign) BOOL cellularPlay;
@property (nonatomic, assign) NSUInteger time;
@property (nonatomic, assign) NSUInteger index;

+ (ZenConfig *)sharedInstance;

/**
 *  open a new timer to counter down
 *
 *  @param time: 0 - close; otherwise open a new counter timer;
 */
- (void)openTimer:(NSUInteger)time;

- (BOOL)allowPlay;
- (BOOL)allowOffline;

@end
