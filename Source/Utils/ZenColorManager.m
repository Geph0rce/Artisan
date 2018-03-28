//
//  ZenColorManager.m
//  Zen
//
//  Created by roger on 13-12-25.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import "Singleton.h"
#import "ZenMacros.h"
#import "ZenColorManager.h"

#define kZenColorGreen ZenColorFromRGB(0x6fca2b)
#define kZenColorGreenHL ZenColorFromRGB(0x4a8726)

#define kZenColorMidGreen  ZenColorFromRGB(0x1abc9c)
#define kZenColorMidGreenHL ZenColorFromRGB(0x16a085)

#define kZenColorLightGreen ZenColorFromRGB(0x2ecc71)
#define kZenColorLightGreenHL ZenColorFromRGB(0x27ae60)

#define kZenColorRealBlue ZenColorFromRGB(0x3498db)
#define kZenColorRealBlueHL ZenColorFromRGB(0x2980b9)

#define kZenColorLightBlue ZenColorFromRGB(0x21aabd)
#define kZenColorLightBlueHL ZenColorFromRGB(0x15707c)

#define kZenColorPurple ZenColorFromRGB(0x654b6b)
#define kZenColorPurpleHL ZenColorFromRGB(0x443248)

#define kZenColorNavy ZenColorFromRGB(0x34495e)
#define kZenColorNavyHL ZenColorFromRGB(0x2c3e50)

#define kZenColorOrange ZenColorFromRGB(0xe67e22)
#define kZenColorOrangeHL ZenColorFromRGB(0xd35400)

#define kZenColorRed ZenColorFromRGB(0xe74c3c)
#define kZenColorRedHL ZenColorFromRGB(0xc0392b)

#define kZenColorGray ZenColorFromRGB(0x95a5a6)
#define kZenColorGrayHL ZenColorFromRGB(0x7f8c8d)

@interface ZenColorManager ()
{
    NSDictionary *_colors;
}

@property (nonatomic, strong) NSDictionary *colors;

@end

@implementation ZenColorManager

SINGLETON_FOR_CLASS(ZenColorManager);

- (id)init
{
    self = [super init];
    if (self) {
        NSArray *normal = @[
            kZenColorGreen,
            kZenColorMidGreen,
            kZenColorLightBlue,
            kZenColorPurple,
            kZenColorNavy,
            kZenColorOrange,
            kZenColorRealBlue,
            kZenColorRed,
            kZenColorLightGreen,
            kZenColorGray
        ];
        
        self.normal = normal;
        
        NSArray *highlight = @[
            kZenColorGreenHL,
            kZenColorMidGreenHL,
            kZenColorLightBlueHL,
            kZenColorPurpleHL,
            kZenColorNavyHL,
            kZenColorOrangeHL,
            kZenColorRealBlueHL,
            kZenColorRedHL,
            kZenColorLightGreenHL,
            kZenColorGrayHL
        ];
        
        self.highlight = highlight;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"colors" ofType:@"plist"];
        NSDictionary *colors = [NSDictionary dictionaryWithContentsOfFile:path];
        self.colors = colors;
    }
    return self;
}

- (int)colorIndexForFid:(NSString *)fid
{
    NSString *index = [_colors objectForKey:fid];
    if (index) {
        return [index intValue];
    }
    
    return 0;
}

- (UIColor *)colorForFid:(NSString *)fid
{
    @try {
        int index = [self colorIndexForFid:fid];
        index = index % _normal.count;
        return [_normal objectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSLog(@"colorForFid Exception: %@", [exception description]);
    }
    return kZenColorRed;

}

- (UIColor *)colorForName:(NSString *)name
{
    @try {
        NSString *fid = _colors[name];
        return [self colorForFid:fid];
    }
    @catch (NSException *exception) {
        NSLog(@"colorForName Exception: %@", [exception description]);
    }
    return kZenColorRed;
    
}

#pragma mark -
#pragma mark Color Util

#define kZenPernalCenterFid @"1001"
#define kZenSettingsFid @"1002"
#define kZenArchivedFid @"1003"
#define kZenMyBoardsFid @"1004"

- (void)generatePlistForFids
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"boards" ofType:@"plist"];
    NSArray *boards = [NSArray arrayWithContentsOfFile:path];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    int index = -1;
    for (NSDictionary *board in boards) {
        NSString *bid = board[@"fid"];
        index++;
        if (index >= _normal.count) {
            index = 0;
        }
        if ([bid isEqualToString:kZenPernalCenterFid] ||
            [bid isEqualToString:kZenSettingsFid] ||
            [bid isEqualToString:kZenArchivedFid] ||
            [bid isEqualToString:kZenMyBoardsFid]) {
            continue;
        }
        NSString *boardFileName = [NSString stringWithFormat:@"board_%@", bid];
        NSString *path = [[NSBundle mainBundle] pathForResource:boardFileName ofType:@"plist"];
        NSArray *childBoards = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *childBoard in childBoards) {
            NSString *fid = childBoard[@"fid"];
            NSString *name = childBoard[@"name"];
            dict[fid] = [NSString stringWithFormat:@"%d", index];
            dict[name] = fid;
        }
    }
    
    path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:@"colors.plist"];
    [dict writeToFile:path atomically:NO];
}

@end
