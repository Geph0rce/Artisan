//
//  ZenPlayerCell.m
//  Artisan
//
//  Created by roger on 14-9-11.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenMacros.h"
#import "UIImageView+WebCache.h"
#import "ZenPlayerCell.h"

@implementation ZenPlayerCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    _border.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"list_split_line"]];
    _name.font = kZenFont15;
    _artist.font = kZenFont13;
    CALayer *layer = _picture.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = 25.0f;
}

- (void)load:(ZenSongData *)song
{
    [_picture setImageWithURL:[NSURL URLWithString:song.picture] placeholderImage:[UIImage imageNamed:@"cover_default"]];
    _name.text = song.name;
    _artist.text = song.artist;
    if (song.status == ZenSongStatusNone) {
        _status.hidden = YES;
    }
    else if (song.status == ZenSongStatusPlay) {
        _status.hidden = NO;
        [_status setImage:[UIImage imageNamed:@"status_play"]];
    }
    else if (song.status == ZenSongStatusPause) {
        _status.hidden = NO;
        [_status setImage:[UIImage imageNamed:@"status_pause"]];
    }
}

@end
