//
//  ZenSongCell.h
//  Artisan
//
//  Created by roger on 14-9-9.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenSongData.h"

@protocol ZenSongCellDelegate <NSObject>

- (void)offlineDidClick:(ZenSongData *)song;

@end

@interface ZenSongCell : UITableViewCell
{
    __weak NSObject <ZenSongCellDelegate> *_delegate;
}

@property (nonatomic, weak) NSObject <ZenSongCellDelegate> *delegate;

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIView *border;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *artist;

- (IBAction)offlineClicked:(id)sender;
- (void)load:(ZenSongData *)song;

@end
