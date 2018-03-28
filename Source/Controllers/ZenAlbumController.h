//
//  ZenAlbumController.h
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenLoadingController.h"

@interface ZenAlbumController : ZenLoadingController
{
    NSString *_aid;
}

@property (nonatomic, strong) NSString *aid;

@end
