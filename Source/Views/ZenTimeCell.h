//
//  ZenTimeCell.h
//  Artisan
//
//  Created by roger on 14-10-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenTimeData.h"

@interface ZenTimeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selector;

- (void)load:(ZenTimeData *)data;

@end
