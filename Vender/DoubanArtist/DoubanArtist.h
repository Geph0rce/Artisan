//
//  DoubanArtist.h
//  Artisan
//
//  Created by roger on 13-8-2.
//  Copyright (c) 2013年 Artisan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoubanArtist : NSObject

- (void)test;

+ (DoubanArtist *)sharedInstance;

- (NSString *)artists;
- (NSString *)songs;
- (NSString *)genre:(NSString *)gid page:(int)page;
- (NSString *)playlist:(NSString *)aid;
- (NSString *)songs:(NSString *)pid;

@end
