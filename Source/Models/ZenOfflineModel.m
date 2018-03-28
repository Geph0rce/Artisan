//
//  ZenOfflineModel.m
//  Artisan
//
//  Created by roger on 14-9-24.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "Singleton.h"
#import "ZenCategory.h"
#import "ZenConfig.h"
#import "ZenConnection.h"
#import "ZenOfflineModel.h"

#define kZenOfflineList @"ZenOffLineList"

@interface ZenOfflineModel () <ZenConnectionDelegate>
{
    ZenConnection *_connection;
    NSString *_path;
    ZenConfig *_config;
}

@property (nonatomic, strong) ZenConnection *connection;
@property (nonatomic, strong) NSString *path;

@end

@implementation ZenOfflineModel

SINGLETON_FOR_CLASS(ZenOfflineModel)


+ (NSURL *)urlForSong:(ZenSongData *)song
{
    NSString *path = [ZenOfflineModel sharedInstance].path;
    NSString *url = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", song.songHash]];
    return [NSURL fileURLWithPath:url];
}

+ (BOOL)songExists:(ZenSongData *)song
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self pathForSong:song]];
}

+ (void)removeSong:(ZenSongData *)song
{
    [[NSFileManager defaultManager] removeItemAtPath:[ZenOfflineModel pathForSong:song] error:NULL];
}

+ (NSString *)pathForSong:(ZenSongData *)song
{
    NSString *path = [ZenOfflineModel sharedInstance].path;
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", song.songHash]];
    return path;
}

- (id)init
{
    self = [super init];
    if (self) {
        _offline = [[NSMutableArray alloc] init];
        _download = [[NSMutableArray alloc] init];
        _artists = [[NSMutableArray alloc] init];
        _songs = [[NSMutableArray alloc] init];
        [self initPath];
        [self loadOfflineList];
        
        _config = [ZenConfig sharedInstance];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopOffline) name:kZenConfigStopOfflineNotification object:_config];
    }
    return self;
}

- (BOOL)contains:(ZenSongData *)song
{
    for (ZenSongData *item in _download) {
        if ([item.songHash isEqualToString:song.songHash]) {
            return YES;
        }
    }
    return NO;
}

- (void)addToDownloadQueue:(NSMutableArray *)songs
{
    if (songs && [songs isKindOfClass:[NSArray class]]) {
        
        for (ZenSongData *song in songs) {
            if (![self contains:song]) {
                [_download addObject:song];
            }
        }
    }
}

- (void)initPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    self.path = [paths[0] stringByAppendingPathComponent:@"offline"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:_path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:_path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
}

- (BOOL)artistExists:(ZenOfflineArtistData *)artist
{
    if (artist) {
        for (ZenOfflineArtistData *item in _artists) {
            if ([item.name isEqualToString:artist.name]) {
                item.count++;
                return YES;
            }
        }
    }
    
    return NO;
}

- (void)loadOfflineList
{
    @try {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSArray *list = [ud objectForKey:kZenOfflineList];
        if (list) {
            for (NSDictionary *item in list) {
                ZenSongData *song = [[ZenSongData alloc] init];
                song.artist = item[@"artist"];
                song.name = item[@"name"];
                song.picture = item[@"picture"];
                song.songHash = item[@"hash"];
                [_offline addObject:song];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"ZenOfflineModel loadOfflineList exception: %@", [exception description]);
    }
    
}

- (NSDictionary *)dictionaryForSong:(ZenSongData *)song
{
    NSString *artist = song.artist == nil ? @"null" : song.artist;
    NSString *name = song.name == nil ? @"null" : song.name;
    NSString *picture = song.picture == nil ? @"null" : song.picture;
    NSString *hash = song.songHash == nil ? @"null" : song.songHash;
    
    return @{ @"artist" : artist, @"name" : name, @"picture" : picture, @"hash" : hash};
}

- (void)save:(ZenSongData *)song data:(NSData *)data
{
    @try {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        [fileManager createFileAtPath:[ZenOfflineModel pathForSong:song] contents:data attributes:nil];
        song.progress = 0;
        song.status = ZenSongStatusNone;
        [_offline addObject:song];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSMutableArray *list = [NSMutableArray array];
        for (ZenSongData *song in _offline) {
            [list addObject:[self dictionaryForSong:song]];
        }
        [ud setObject:list forKey:kZenOfflineList];
        [ud synchronize];
    }
    @catch (NSException *exception) {
        NSLog(@"ZenOfflineModel save exception: %@", [exception description]);
    }
}

- (BOOL)exists:(ZenSongData *)song
{
    @try {
        // check if song exists at offline queue
        for (ZenSongData *item in _offline) {
            if ([item.songHash isEqualToString:song.songHash]) {
                return YES;
            }
        }
        // check if song exists at download queue
        for (ZenSongData *item in _download) {
            if ([item.songHash isEqualToString:song.songHash]) {
                return YES;
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"ZenOfflineModel extists exception: %@", [exception description]);
    }
    // otherwise song does not exist
    return NO;
}

/**
 *  check if item exists at local store, and remove it
 */
- (void)clear
{
    for (int i = 0; i < _download.count; i++) {
        ZenSongData *song = _download[i];
        if ([ZenOfflineModel songExists:song]) {
            [_download removeObjectAtIndex:i];
        }
    }
}

- (void)fetch
{
    if (_download.count > 0 && [_config allowOffline]) {
        ZenSongData *song = _download[0];
        song.status = ZenSongStatusDownloading;
        ZenConnection *conn = [ZenConnection connectionWithURL:[NSURL URLWithString:song.src]];
        conn.delegate = self;
        self.connection = conn;
        [conn startAsynchronous];
    }
    
    [self send:kZenOfflineStateChange];
}

- (void)offline:(NSArray *)songs
{
    @try {
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:songs];
        for (int i = 0; i < array.count; i++) {
            ZenSongData *song = array[i];
            if ([self exists:song]) {
                [array removeObjectAtIndex:i];
            }
        }
        if (array.count > 0) {
            [_download addObjectsFromArray:array];
            [self clear];
            [self fetch];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"ZenOfflineModel offline exception: %@", [exception description]);
    }
}

- (void)removeOfflineObjectAtIndex:(NSUInteger)index
{
    @try {
        ZenSongData *song = _offline[index];
        if ([ZenOfflineModel songExists:song]) {
            [ZenOfflineModel removeSong:song];
        }
        [_offline removeObjectAtIndex:index];
        NSMutableArray *list = [NSMutableArray array];
        for (ZenSongData *song in _offline) {
            [list addObject:[self dictionaryForSong:song]];
        }
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:list forKey:kZenOfflineList];
        [ud synchronize];
    }
    @catch (NSException *exception) {
        NSLog(@"ZenOfflineModel removeOfflineObjectAtIndex exception: %@", [exception description]);
    }
}

- (void)removeDownloadingObjectAtIndex:(NSUInteger)index
{
    @try {
        [_download removeObjectAtIndex:index];
        if (index == 0 && _connection) {
            [_connection cancel];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"ZenOfflineModel removeDownloadingObjectAtIndex exception: %@", [exception description]);
    }
}

- (void)loadSongsWithArtist:(NSString *)artist
{
    [_songs removeAllObjects];
    for (ZenSongData *song in _offline) {
        if ([song.artist isEqualToString:artist]) {
            [_songs addObject:song];
        }
    }
    [self send:kZenOfflineLoadSongsFinished];
}

- (void)loadArtists
{
    [_artists removeAllObjects];
    for (ZenSongData *song in _offline) {
        ZenOfflineArtistData *artist = [[ZenOfflineArtistData alloc] init];
        artist.name = song.artist;
        artist.picture = song.picture;
        artist.count = 1;
        if (![self artistExists:artist]) {
            [_artists addObject:artist];
        }
    }
}



#pragma mark
#pragma mark ZenConnectionDelegate

- (void)requestDidFinished:(ZenConnection *)conn
{
    NSData *data = conn.responseData;
    if (data && _download.count > 0) {
        ZenSongData *song = _download[0];
        [self save:song data:data];
        [_download removeObjectAtIndex:0];
        [self send:kZenOfflineStateChange];
        [self fetch];
    }
}

- (void)requestDidFailed:(ZenConnection *)conn
{
    //NSLog(@"download failed");
    [self fetch];
}

- (void)progressOfConnection:(ZenConnection *)connection
{
    NSUInteger progress = connection.progress;
    NSLog(@"progress: %lu", (unsigned long)progress);
    if (_download.count > 0) {
        ZenSongData *song = _download[0];
        song.progress = progress;
        [self send:kZenOfflineStateChange];
    }
}

- (void)stopOffline
{
    if (_connection) {
        [_connection cancel];
        self.connection = nil;
    }
}

- (void)pause
{
    if (_connection) {
        [_connection cancel];
        self.connection = nil;
    }
    if (_download.count > 0) {
        ZenSongData *song = _download[0];
        song.status = ZenSongStatusNone;
        song.progress = 0;
    }
    [self send:kZenOfflineStateChange];
}

- (void)start
{
    [self fetch];
}

@end
