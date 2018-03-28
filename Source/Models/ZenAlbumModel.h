//
//  ZenAlbumModel.h
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenAlbumData.h"
#import "ZenArtistData.h"
#import "ZenBaseModel.h"

#define kZenAlbumRequestFinished @"ZenAlbumRequestFinished"
#define kZenAlbumRequestFailed @"ZenAlbumRequestFailed"

@interface ZenAlbumModel : ZenBaseModel
{
    ZenArtistData *_artist;
    NSMutableArray *_list;
}

@property (nonatomic, strong) ZenArtistData *artist;
@property (nonatomic, strong) NSMutableArray *list;

- (void)refresh:(NSString *)aid;

@end
