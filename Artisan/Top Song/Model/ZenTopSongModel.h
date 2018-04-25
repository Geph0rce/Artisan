//
//  ZenTopSongModel.h
//  Artisan
//
//  Created by qianjie on 2018/4/25.
//  Copyright © 2018 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFBaseModel.h"

/*
 "count": 1116,
 "picture": "https://img3.doubanio.com/view/site/median/public/94631dc11ad58c1.jpg",
 "name": "the fish",
 "artist": "周姿妍",
 "rank": 1,
 "id": "724721",
 "length": "2:46",
 "artist_id": "117575",
 "src": "http://mr3.doubanio.com/cccebfb0f6448edd1670b14ef9cfaccb/0/fm/song/p2748147_128k.mp3",
 "widget_id": "193719445"
 */

@interface ZenTopSongModel : RFBaseModel

@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *rank;
@property (nonatomic, copy) NSString *length;
@property (nonatomic, copy) NSString *artist_id;
@property (nonatomic, copy) NSString *src;
@property (nonatomic, copy) NSString *widget_id;


@end

@interface ZenTopSongResponse : RFBaseModel

@property (nonatomic, strong) NSArray <ZenTopSongModel *> *songs;

@end
