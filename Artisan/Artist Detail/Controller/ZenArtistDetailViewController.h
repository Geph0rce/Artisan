//
//  ZenArtistDetailViewController.h
//  Artisan
//
//  Created by qianjie on 2018/5/18.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenBaseViewController.h"
#import "ZenTopArtistModel.h"

@interface ZenArtistDetailViewController : ZenBaseViewController

@property (nonatomic, strong) ZenTopArtistModel *model;

@property (nonatomic, strong) NSArray *data;

@end
