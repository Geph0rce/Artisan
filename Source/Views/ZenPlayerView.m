//
//  ZenPlayerView.m
//  Artisan
//
//  Created by roger on 14-9-11.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "ZenMacros.h"
#import "ZenPlayerView.h"

#define kZenGreenBackgroundColor ZenColorFromRGB(0x1abc9c)

@implementation ZenPlayerView

- (void)awakeFromNib
{
    self.backgroundColor = kZenGreenBackgroundColor;
    _name.font = kZenFont15;
    _artist.font = kZenFont13;
    _timeLabel.font = kZenFont15;
    CALayer *layer = _picture.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = 25.0f;
    
    _prevBtn.tag = ZenPlayerControlTypePrev;
    [_prevBtn setImage:[UIImage imageNamed:@"prev"] forState:UIControlStateNormal];
    [_prevBtn setImage:[UIImage imageNamed:@"prev2"] forState:UIControlStateHighlighted];
    
    _nextBtn.tag = ZenPlayerControlTypeNext;
    [_nextBtn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [_nextBtn setImage:[UIImage imageNamed:@"next2"] forState:UIControlStateHighlighted];
    
    _playBtn.tag = ZenPlayerControlTypePlay;
    
    _playModeBtn.tag = ZenPlayerControlTypeMode;
}

- (void)load:(ZenSongData *)song
{
    _name.text = song.name;
    _artist.text = song.artist;
    [_picture sd_setImageWithURL:[NSURL URLWithString:song.picture] placeholderImage:[UIImage imageNamed:@"cover_default"]];
    if (song.status != ZenSongStatusPlay) {
        [_playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"play2"] forState:UIControlStateHighlighted];
    }
    else {
        [_playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"pause2"] forState:UIControlStateHighlighted];
    }
}

- (void)setTimeLabelText:(NSString *)text
{
    _timeLabel.text = text;
}

- (void)addTarget:(id)target action:(SEL)action
{
    [_prevBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [_playBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [_playModeBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
