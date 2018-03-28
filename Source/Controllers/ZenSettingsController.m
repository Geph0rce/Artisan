//
//  ZenSettingsController.m
//  Artisan
//
//  Created by roger on 14-10-9.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "ZenConfig.h"
#import "ZenNavigationBar.h"
#import "ZenSettingsController.h"
#import "ZenOpenTimerController.h"
#import "ZenHtmlController.h"

#define kZenTimeLabelGrayColor ZenColorFromRGB(0xdfdfdf)
#define kZenTimeLabelColor ZenColorFromRGB(0x1abc9c)

@interface ZenSettingsController ()
{
    ZenConfig *_config;
}
@end

@implementation ZenSettingsController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _config = [ZenConfig sharedInstance];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(refreshTime) name:kZenConfigRefreshTimeNotification object:_config];
    [defaultCenter addObserver:self selector:@selector(refreshTime) name:kZenConfigStopPlayNotification object:_config];
    
    ZenNavigationBar *bar = [[ZenNavigationBar alloc] init];
    [bar setTitle:@"设置"];
    [bar addLeftItemWithStyle:ZenNavigationItemStyleMenu target:self action:@selector(menu:)];
    [_container addSubview:bar];
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ZenSettingsView" owner:self options:NULL];
    if (array && array.count > 0) {
        UIView *settingsView = array[0];
        [_container addSubview:settingsView];
        CGRect frame = settingsView.frame;
        frame.origin.y = bar.height;
        settingsView.frame = frame;
        
        _cellularPlayLabel.font = kZenFont15;
        [_cellularPlaySwitch setOn:_config.cellularPlay];
        
        _cellularOfflineLabel.font = kZenFont15;
        [_cellularOfflineSwitch setOn:_config.cellularOffline];
        
        _timerTitleLabel.font = kZenFont15;
        [self refreshTime];
    }
}

- (void)refreshTime
{
    if (_config.time == 0) {
        _timeLabel.textColor = [UIColor darkGrayColor];
        _timeLabel.text = @"未开启";
    }
    else {
        NSUInteger min = _config.time / 60;
        int sec = _config.time % 60;
        NSString *text = [NSString stringWithFormat:@"%02lu:%02d", (unsigned long)min, sec];
        _timeLabel.textColor = kZenTimeLabelColor;
        _timeLabel.text = text;
    }
}

- (void)menu:(id)sender
{
    DDMenuController *menuController = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    [menuController showLeftController:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cellularPlayOnValueChange:(id)sender
{
    UISwitch *zenSwitch = (UISwitch *)sender;
    _config.cellularPlay = zenSwitch.isOn;
}

- (IBAction)cellularOfflineOnValueChange:(id)sender
{
    UISwitch *zenSwitch = (UISwitch *)sender;
    _config.cellularOffline = zenSwitch.isOn;
}

- (IBAction)openTimer:(id)sender
{
    ZenOpenTimerController *controller = [[ZenOpenTimerController alloc] init];
    controller.view.frame = _container.bounds;
    [self presentViewController:controller option:ZenAnimationOptionHorizontal completion:NULL];
}

- (IBAction)statementClicked:(id)sender
{
    NSString *pagePath = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
    NSString *page = [NSString stringWithContentsOfFile:pagePath encoding:NSUTF8StringEncoding error:nil];
    __block ZenHtmlController *controller = [[ZenHtmlController alloc] init];
    controller.view.frame = _container.frame;
    [self presentViewController:controller option:ZenAnimationOptionHorizontal completion:^{
        [controller loadContent:page];
        [controller enablePanRightGestureWithDismissBlock:NULL];
    }];

}

- (IBAction)rankClicked:(id)sender
{
    NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", kZenAppID];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", kZenAppID];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
