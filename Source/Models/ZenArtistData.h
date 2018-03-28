//
//  ZenArtistData.h
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZenArtistData : NSObject
{
    NSString *_picture;
    NSString *_name;
    NSString *_follower;
    NSString *_style;
    NSString *_aid;
}

@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *follower;
@property (nonatomic, strong) NSString *style;
@property (nonatomic, strong) NSString *aid;

@end
