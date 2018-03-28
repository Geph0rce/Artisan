//
//  ZenTimeCell.m
//  Artisan
//
//  Created by roger on 14-10-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "ZenTimeCell.h"

@implementation ZenTimeCell

- (void)awakeFromNib
{
    _timeLabel.font = kZenFont15;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)load:(ZenTimeData *)data
{
    _timeLabel.text = data.desc;
    _selector.hidden = !data.selected;
}

@end
