//
//  ZenPlayerView.h
//  Artisan
//
//  Created by roger on 14-9-11.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenSongData.h"

typedef enum {
    ZenPlayerControlTypePrev,
    ZenPlayerControlTypePlay,
    ZenPlayerControlTypeNext,
    ZenPlayerControlTypeMode
} ZenPlayerControlType;


@interface ZenPlayerView : UIView

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *artist;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *playModeBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *prevBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

- (void)load:(ZenSongData *)song;
- (void)setTimeLabelText:(NSString *)text;
- (void)addTarget:(id)target action:(SEL)action;

@end
