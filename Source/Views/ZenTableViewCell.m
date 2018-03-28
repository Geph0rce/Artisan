//
//  ZenTableViewCell.m
//  Zen
//
//  Created by roger on 13-10-18.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import "ZenTableViewCell.h"

#define kZenTableViewCellMarginRight 10.0f

@implementation ZenTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.width -= kZenTableViewCellMarginRight;
    [super setFrame:frame];
}

@end
