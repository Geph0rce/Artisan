//
//  ZenOfflineArtistData.h
//  Artisan
//
//  Created by roger on 14-9-29.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZenOfflineArtistData : NSObject
{
    NSString *_picture;
    NSString *_name;
    NSUInteger _count;
}

@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger count;

@end
