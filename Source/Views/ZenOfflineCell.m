//
//  ZenOfflineCell.m
//  Artisan
//
//  Created by roger on 14-9-28.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "ZenMacros.h"
#import "ZenOfflineCell.h"

#define kZenColorLightBlue ZenColorFromRGB(0x21aabd)
#define kZenProgressViewWidth 290.0f

@implementation ZenOfflineCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = kZenHighlightDaytime;
    self.selectedBackgroundView = view;
    _border.backgroundColor = kZenBorderColor;
    _title.font = kZenFont15;
    _artist.font = kZenFont13;
    _progress.backgroundColor = kZenColorLightBlue;
    _progress.hidden = YES;
    _progressBackgroud.hidden = YES;
    CALayer *layer = _picture.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:25.0f];
}


- (CGFloat)widthForProgress:(NSUInteger)progress
{
    CGFloat width = kZenProgressViewWidth;
    CGFloat ratio = (1.0f * progress)/100.0f;
    return width * ratio;
}

- (void)load:(ZenSongData *)song
{
    _title.text = song.name;
    _artist.text = song.artist;
    [_picture setImageWithURL:[NSURL URLWithString:song.picture] placeholderImage:[UIImage imageNamed:@"cover_default"]];

    // config progress bar
    if (song.progress > 0) {
        _progress.hidden = NO;
        _progressBackgroud.hidden = NO;
        CGRect frame = _progress.frame;
        frame.size.width = [self widthForProgress:song.progress];
        _progress.frame = frame;
    }
    else {
        _progress.hidden = YES;
        _progressBackgroud.hidden = YES;
    }
}

@end
