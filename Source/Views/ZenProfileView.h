//
//  ZenProfileView.h
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenArtistData.h"
#import <UIKit/UIKit.h>

@interface ZenProfileView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *style;
@property (weak, nonatomic) IBOutlet UILabel *follower;
@property (weak, nonatomic) IBOutlet UIView *border;

- (void)load:(ZenArtistData *)artist;

@end
