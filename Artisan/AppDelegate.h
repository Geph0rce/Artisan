//
//  AppDelegate.h
//  Zen
//
//  Created by roger on 13-10-17.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"

@class ZenThreadsController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    DDMenuController *_menuController;
    ZenThreadsController *_threads;
}

@property (nonatomic, strong) DDMenuController *menuController;
@property (nonatomic, strong) ZenThreadsController *threads;
@property (strong, nonatomic) UIWindow *window;

@end
