//
//  ZenOpenTimerController.m
//  Artisan
//
//  Created by roger on 14-10-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "ZenConfig.h"
#import "ZenTimeData.h"
#import "ZenTimeCell.h"
#import "ZenNavigationBar.h"
#import "ZenOpenTimerController.h"

#define kZenTimeCellId @"ZenTimeCellId"

@interface ZenOpenTimerController () <UITableViewDataSource, UITableViewDelegate>
{
    ZenConfig *_config;
    UITableView *_table;
    NSMutableArray *_timers;
}
@end

@implementation ZenOpenTimerController

- (id)init
{
    self = [super init];
    if (self) {
         _config = [ZenConfig sharedInstance];
        _timers = [[NSMutableArray alloc] init];
        [self loadTimeItems];
    }
    return self;
}

- (void)loadTimeItems
{
    @try {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Artisan-timer" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        for (int i = 0; i < array.count; i++) {
            NSDictionary *item = array[i];
            ZenTimeData *data = [[ZenTimeData alloc] init];
            data.desc = item[@"desc"];
            data.time = [item[@"time"] integerValue];
            data.selected = (_config.index == i);
            [_timers addObject:data];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"ZenOpenTimerController loadTimeItems exception: %@", [exception description]);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    ZenNavigationBar *bar = [[ZenNavigationBar alloc] init];
    [bar addLeftItemWithStyle:ZenNavigationItemStyleBack target:self action:@selector(back:)];
    [bar setTitle:@"定时关闭"];
    [_container addSubview:bar];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, bar.height, CGRectGetWidth(_container.frame), CGRectGetHeight(_container.frame) - bar.height)];
    _table = table;
    _table.delegate = self;
    _table.dataSource = self;
    _table.scrollsToTop = YES;
    _table.separatorColor = kZenBorderColor;
    [_table setAllowsSelection:YES];
    [_container addSubview:table];
    
    [_table registerNib:[UINib nibWithNibName:@"ZenTimeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kZenTimeCellId];
    [self enablePanRightGestureWithDismissBlock:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(id)sender
{
    [self dismissViewControllerWithOption:ZenAnimationOptionHorizontal completion:NULL];
}

- (void)selected:(NSUInteger)index
{
    _config.index = index;
    if (index < _timers.count) {
        for (int i = 0; i < _timers.count; i++) {
            ZenTimeData *data = _timers[i];
            if (index == i) {
                data.selected = YES;
            }
            else {
                data.selected = NO;
            }
        }
    }
}

#pragma mark
#pragma mark UITableViewDelegate and UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _timers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZenTimeData *data = _timers[indexPath.row];
    ZenTimeCell *cell = [_table dequeueReusableCellWithIdentifier:kZenTimeCellId];
    [cell load:data];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZenTimeData *data = _timers[indexPath.row];
    [self selected:indexPath.row];
    [_table reloadData];
    [_config openTimer:data.time];
}

@end
