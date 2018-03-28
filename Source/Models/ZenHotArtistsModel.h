//
//  ZenHotArtistsModel.h
//  Artisan
//
//  Created by roger on 14-9-11.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenArtistData.h"
#import "ZenBaseModel.h"

#define kZenHotArtistsRequestFinished @"ZenHotArtistsRequestFinished"
#define kZenHotArtistsRequestFailed @"ZenHotArtistsRequestFailed"

@interface ZenHotArtistsModel : ZenBaseModel
{
    NSMutableArray *_list;
}

@property (nonatomic, strong) NSMutableArray *list;

- (void)load;

@end