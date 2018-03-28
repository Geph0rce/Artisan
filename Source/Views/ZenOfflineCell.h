//
//  ZenOfflineCell.h
//  Artisan
//
//  Created by roger on 14-9-28.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenSongData.h"

@interface ZenOfflineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *artist;
@property (weak, nonatomic) IBOutlet UIView *progress;
@property (weak, nonatomic) IBOutlet UIView *border;
@property (weak, nonatomic) IBOutlet UIView *progressBackgroud;

- (void)load:(ZenSongData *)song;

@end
