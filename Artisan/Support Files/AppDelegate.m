//
//  AppDelegate.m
//  Zen
//
//  Created by roger on 13-10-17.
//  Copyright (c) 2013年 Zen. All rights reserved.
//


#import "ZenMacros.h"
#import "ZenConfig.h"
#import "AppDelegate.h"

#import "ZenBoardsController.h"
#import "ZenHotSongsController.h"
#import "ZenTabBarViewController.h"
#import "ZenTopSongsViewController.h"
#import "ZenTopArtistViewController.h"

#define kZenUmengAppKey @"5438c92efd98c54d1f024b81"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
//    UIViewController *controller = [[ZenTopSongsViewController alloc] init];
//    DDMenuController *menuController = [[DDMenuController alloc] initWithRootViewController:controller];
//    ZenBoardsController *leftController = [ZenBoardsController sharedInstance];
//    menuController.leftViewController = leftController;
//    self.menuController = menuController;
    
    ZenTabBarViewController *tabBarViewController = [[ZenTabBarViewController alloc] init];
    [tabBarViewController setViewControllers:@[[ZenTopSongsViewController new], [ZenTopArtistViewController new]]];
    tabBarViewController.selectedIndex = 0;
    self.window.rootViewController = tabBarViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self configCustomTopBarAppearance];
    [self configZenTabBarItemAppearance];
    return YES;
}

- (void)configCustomTopBarAppearance {
    [[RFCustomTopBar appearance] setTitleLabelTextColor:[UIColor blackColor]];
    [[RFCustomTopBar appearance] setTitleLabelTextFont:kAppFont(17.0)];
    [[RFCustomTopBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[RFCustomTopBar appearance] setBottomSeparateLineColor:[UIColor zenLineColor]];
}

- (void)configZenTabBarItemAppearance {
    [[ZenTabBarItem appearance] setColor:[UIColor zenBlackColor] forState:UIControlStateNormal];
    [[ZenTabBarItem appearance] setColor:[UIColor zenRedColor] forState:UIControlStateSelected];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //[[ZenAdManager sharedInstance] refresh];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
