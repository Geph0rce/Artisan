//
//  ZenArtistCell.m
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "UIImageView+WebCache.h"
#import "ZenArtistCell.h"

@implementation ZenArtistCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = kZenHighlightDaytime;
    self.selectedBackgroundView = view;
    _border.backgroundColor = kZenBorderColor;
    _name.font = kZenFont15;
    _followers.font = kZenFont13;
    
    CALayer *layer = _picture.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:25.0f];
}

- (void)load:(ZenArtistData *)artist
{
    [_picture setImageWithURL:[NSURL URLWithString:artist.picture] placeholderImage:[UIImage imageNamed:@"cover_default"]];
    _name.text = artist.name;
    _followers.text = [NSString stringWithFormat:@"%@人关注", artist.follower];
}

@end
