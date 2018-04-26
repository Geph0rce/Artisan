//
//  ZenTopArtistRow.m
//  Artisan
//
//  Created by Roger on 26/04/2018.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenTopArtistRow.h"

@interface ZenTopArtistRowCell : RFTableViewCell

@end

@implementation ZenTopArtistRowCell

- (void)cellDidCreate {
    [super cellDidCreate];
}

@end

@implementation ZenTopArtistRow

- (void)updateCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    [super updateCell:cell indexPath:indexPath];
}

- (BOOL)autoAdjustCellHeight {
    return YES;
}

@end
