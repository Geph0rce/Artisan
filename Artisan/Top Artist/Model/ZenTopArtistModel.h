//
//  ZenTopArtistModel.h
//  Artisan
//
//  Created by Roger on 26/04/2018.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "RFBaseModel.h"


/*
 {
 "picture": "https://img1.doubanio.com/view/site/median/public/c083d9c5d4a2ba7.jpg",
 "style": "流派: 民谣 Folk",
 "added": "no",
 "name": "张过年",
 "rank": 13,
 "member": "成员: ",
 "follower": 8263,
 "type": "artist",
 "id": "100868"
 }
*/

@interface ZenTopArtistModel : RFBaseModel

@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *style;
@property (nonatomic, copy) NSString *added;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *rank;
@property (nonatomic, copy) NSString *follower;

@end


@interface ZenTopArtistReponse : RFBaseModel

@property (nonatomic, strong) NSArray <ZenTopArtistModel *> *artists;

@end
