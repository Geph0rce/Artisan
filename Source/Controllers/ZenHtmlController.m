//
//  ZenHtmlController.m
//  Zen
//
//  Created by roger on 13-6-3.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "ZenConfig.h"
#import "ZenHtmlController.h"
#import "ZenBottomBar.h"

@interface ZenHtmlController ()
{
    UIWebView *_content;
}

@end

@implementation ZenHtmlController

#pragma mark -

- (void)backClicked
{
    [self dismissViewControllerWithOption:ZenAnimationOptionHorizontal
                               completion:NULL];
}


#pragma mark - 
#pragma mark - ViewController LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZenBottomBar *bar = [[ZenBottomBar alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(_container.frame) - 40.0f, CGRectGetWidth(_container.frame), 40.0f)];
    bar.leftItemType = ZenBottomBarItemTypeBack;
    [bar addLeftTarget:self action:@selector(backClicked)];
    [_container addSubview:bar];
    
    UIWebView *content = [[UIWebView alloc] init];
    _content = content;
    [_content setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_container.frame), CGRectGetHeight(self.view.frame) - 40.0f)];
    _content.scalesPageToFit = YES;
    _content.dataDetectorTypes = UIDataDetectorTypeNone;
    [_container addSubview:_content];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        UIView *statusBarMask = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_container.frame), 20.0f)];
        statusBarMask.backgroundColor = kZenBackgroundColor;
        statusBarMask.alpha = 0.8;
        [_container addSubview:statusBarMask];
    }
}

- (void)loadContent:(NSString *)content
{
    [_content loadHTMLString:content baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath] isDirectory:YES]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
