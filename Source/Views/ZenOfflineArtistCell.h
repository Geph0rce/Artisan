//
//  ZenOfflineArtistCell.h
//  Artisan
//
//  Created by roger on 14-9-29.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenOfflineArtistData.h"

@interface ZenOfflineArtistCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UIView *border;

- (void)load:(ZenOfflineArtistData *)artist;

@end
