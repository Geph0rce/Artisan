//
//  ZenAlbumCell.m
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "ZenAlbumCell.h"

@implementation ZenAlbumCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = kZenHighlightDaytime;
    self.selectedBackgroundView = view;
    _border.backgroundColor = kZenBorderColor;
    _name.font = kZenFont15;
}

- (void)load:(NSString *)name
{
    _name.text = name;
}

@end
