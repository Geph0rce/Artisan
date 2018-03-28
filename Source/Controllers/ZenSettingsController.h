//
//  ZenSettingsController.h
//  Artisan
//
//  Created by roger on 14-10-9.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenBaseController.h"

@interface ZenSettingsController : ZenBaseController

// outlets
@property (weak, nonatomic) IBOutlet UISwitch *cellularPlaySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *cellularOfflineSwitch;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellularPlayLabel;

@property (weak, nonatomic) IBOutlet UILabel *cellularOfflineLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statementLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;

// actions
- (IBAction)cellularPlayOnValueChange:(id)sender;
- (IBAction)cellularOfflineOnValueChange:(id)sender;
- (IBAction)openTimer:(id)sender;
- (IBAction)statementClicked:(id)sender;
- (IBAction)rankClicked:(id)sender;

@end
