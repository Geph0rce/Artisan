//
//  ZenArtistHeaderView.h
//  Artisan
//
//  Created by Roger on 2018/5/24.
//  Copyright © 2018 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenTopArtistModel.h"

@interface ZenArtistHeaderView : UIView

- (void)reloadData:(ZenTopArtistModel *)model;

@end
