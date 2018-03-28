//
//  ZenPlayerCell.h
//  Artisan
//
//  Created by roger on 14-9-11.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenSongData.h"

@interface ZenPlayerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIImageView *status;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *artist;
@property (weak, nonatomic) IBOutlet UIView *border;

- (void)load:(ZenSongData *)song;

@end
