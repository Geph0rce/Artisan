//
//  ZenAlbumCell.h
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZenAlbumCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIView *border;

- (void)load:(NSString *)name;

@end
