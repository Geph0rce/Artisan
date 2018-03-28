//
//  ZenProfileView.m
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "ZenMacros.h"
#import "ZenProfileView.h"

@implementation ZenProfileView

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
    _border.backgroundColor = kZenBorderColor;
    _name.font = kZenFont15;
    _follower.font = kZenFont13;
    _style.font = kZenFont13;
    
    CALayer *layer = _picture.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:25.0f];
}

- (void)load:(ZenArtistData *)artist
{
    [_picture setImageWithURL:[NSURL URLWithString:artist.picture] placeholderImage:[UIImage imageNamed:@"cover_default"]];
    _name.text = artist.name;
    _follower.text = [NSString stringWithFormat:@"%@人关注", artist.follower];
    _style.text = artist.style;
}

@end
