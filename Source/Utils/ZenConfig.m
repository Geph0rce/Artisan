//
//  ZenConfig.m
//  Zen
//
//  Created by roger qian on 13-3-13.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import "Singleton.h"
#import "ZenConfig.h"
#import "Reachability.h"

#define kZenCellularPlayMode @"ZenCellularPlayMode"
#define kZenCellularOfflineMode @"ZenCellularOfflineMode"

@interface ZenConfig ()
{
    NSTimer *_timer;
    Reachability *_reachability;
}

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) Reachability *reachability;

- (void)loadConfig;

@end

@implementation ZenConfig

SINGLETON_FOR_CLASS(ZenConfig);

#pragma mark - 
#pragma mark - Zen Config Stuff

- (id)init
{
    self = [super init];
    if (self) {
        [self loadConfig];
        _time = 0;
        self.reachability = [Reachability reachabilityForInternetConnection];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged) name:kReachabilityChangedNotification object:_reachability];
        [_reachability startNotifier];
    }
    
    return self;
}

- (void)cancelTimer
{
    if (_timer) {
        [_timer invalidate];
        self.timer = nil;
    }
    _time = 0;
    _index = 0;
}

- (BOOL)allowPlay
{
    NetworkStatus status = [_reachability currentReachabilityStatus];
    if (status == ReachableViaWWAN && !_cellularPlay) {
        return NO;
    }
    return YES;
}

- (BOOL)allowOffline
{
    NetworkStatus status = [_reachability currentReachabilityStatus];
    if (status == ReachableViaWWAN && !_cellularOffline) {
        return NO;
    }
    return YES;
}

- (void)openTimer:(NSUInteger)time
{
    // cancel timer
    [self cancelTimer];
    
    // save time
    _time = time;
    
    if (time == 0) {
        // stop player
        [[NSNotificationCenter defaultCenter] postNotificationName:kZenConfigRefreshTimeNotification object:self];
        return;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)setCellularPlay:(BOOL)cellularPlay
{
    _cellularPlay = cellularPlay;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:cellularPlay forKey:kZenCellularPlayMode];
    [ud synchronize];
}

- (void)setCellularOffline:(BOOL)cellularOffline
{
    _cellularOffline = cellularOffline;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:cellularOffline forKey:kZenCellularOfflineMode];
    [ud synchronize];
}

- (void)loadConfig
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _cellularPlay = [ud boolForKey:kZenCellularPlayMode];
    _cellularOffline = [ud boolForKey:kZenCellularOfflineMode];
}

- (void)timerFired:(NSTimer *)timer
{
    if (_time > 0) {
        _time--;
        [[NSNotificationCenter defaultCenter] postNotificationName:kZenConfigRefreshTimeNotification object:self];
    }
    else {
        // close timer
        [self cancelTimer];
        _index = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:kZenConfigStopPlayNotification object:self];
    }
}

- (void)networkStatusChanged
{
    NetworkStatus status = [_reachability currentReachabilityStatus];
    if (status == ReachableViaWWAN) {
        if (!_cellularOffline) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kZenConfigStopOfflineNotification object:self];
        }
        if (!_cellularPlay) {
            [self cancelTimer];
            [[NSNotificationCenter defaultCenter] postNotificationName:kZenConfigStopPlayNotification object:self];
        }
    }
    else if (status == ReachableViaWiFi) {
        
    }
}

@end
