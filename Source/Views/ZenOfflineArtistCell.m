//
//  ZenOfflineArtistCell.m
//  Artisan
//
//  Created by roger on 14-9-29.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenOfflineArtistCell.h"
#import "UIImageView+WebCache.h"
#import "ZenMacros.h"
@implementation ZenOfflineArtistCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = kZenHighlightDaytime;
    self.selectedBackgroundView = view;
    _border.backgroundColor = kZenBorderColor;
    _info.font = kZenFont15;
    _info.textColor = [UIColor blackColor];

    CALayer *layer = _picture.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:25.0f];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)load:(ZenOfflineArtistData *)artist
{
    [_picture sd_setImageWithURL:[NSURL URLWithString:artist.picture] placeholderImage:[UIImage imageNamed:@"cover_default"]];
    _info.text = [NSString stringWithFormat:@"%@ (%lu)", artist.name, (unsigned long)artist.count];
}

@end
