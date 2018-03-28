//
//  ZenArtistCell.h
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenArtistData.h"

@interface ZenArtistCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *followers;
@property (weak, nonatomic) IBOutlet UIView *border;

- (void)load:(ZenArtistData *)artist;

@end
