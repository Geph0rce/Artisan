//
//  DoubanArtist.m
//  Artisan
//
//  Created by roger on 13-8-2.
//  Copyright (c) 2013年 Artisan. All rights reserved.
//

#include <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

#import "Singleton.h"
#import "DoubanArtist.h"

#define kDoubanArtistBaseURL @"http://music.douban.com/api/artist"
#define kDoubanArtistApp @"&app_name=music_artist"
#define kDoubanArtistVersion @"&version=50"
#define ARC4RANDOM_MAX      0x100000000
#define kDoubanSha1Pattern @"Get busy living, or get busy dying. %lf"


@interface DoubanArtist ()

- (NSString *)callback;
- (NSString *)timestamp;
@end

@implementation DoubanArtist

SINGLETON_FOR_CLASS(DoubanArtist);


#pragma mark -
#pragma mark DoubanArtist URL Stuff

- (NSString *)songs
{
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:kDoubanArtistBaseURL];
    [url appendString:@"/chart?type=song"];
    [url appendString:[self callback]];
    [url appendString:kDoubanArtistApp];
    [url appendString:kDoubanArtistVersion];
    [url appendString:[self timestamp]];
    return  url;
}

- (NSString *)artists
{
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:kDoubanArtistBaseURL];
    [url appendString:@"/chart?type=artist"];
    [url appendString:[self callback]];
    [url appendString:kDoubanArtistApp];
    [url appendString:kDoubanArtistVersion];
    [url appendString:[self timestamp]];
    return  url;
}

- (NSString *)genre:(NSString *)gid page:(int)page
{
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:kDoubanArtistBaseURL];
    [url appendFormat:@"/genre?gid=%@&type=artist&sortby=hot&page=%d", gid, page];
    [url appendString:[self callback]];
    [url appendString:kDoubanArtistApp];
    [url appendString:kDoubanArtistVersion];
    [url appendString:[self timestamp]];
    return  url;
}

- (NSString *)playlist:(NSString *)aid
{
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:kDoubanArtistBaseURL];
    [url appendFormat:@"/artist_playlist?id=%@", aid];
    [url appendString:[self callback]];
    [url appendString:kDoubanArtistApp];
    [url appendString:kDoubanArtistVersion];
    [url appendString:[self timestamp]];
    return  url;
}

- (NSString *)songs:(NSString *)pid
{
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:kDoubanArtistBaseURL];
    [url appendFormat:@"/songs?id=%@", pid];
    [url appendString:[self callback]];
    [url appendString:kDoubanArtistApp];
    [url appendString:kDoubanArtistVersion];
    [url appendString:[self timestamp]];
    return  url;
}

- (void)test
{
    NSLog(@"chart/song: %@", [self songs]);
    NSLog(@"chart/artist: %@", [self artists]);
    
}

#pragma mark -
#pragma mark utils

- (NSString *)sha1:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < 8; i++)
    {
        [output appendFormat:@"%02d", (digest[i]%100)];
    }
    
    return output;
}

- (NSString *)callback
{
    double val = ((double)arc4random() / ARC4RANDOM_MAX);
    NSString *input = [NSString stringWithFormat:kDoubanSha1Pattern, val];
    NSString *random = [self sha1:input];
    return [NSString stringWithFormat:@"&cb=%@.setp(0.%@)", @"%24", random];
}

- (NSString *)timestamp
{
    NSDate *date = [NSDate date];
    NSString *timestamp = [NSString stringWithFormat:@"&_=%lld", (long long)([date timeIntervalSince1970] * 1000)];
    return timestamp;
}

@end
