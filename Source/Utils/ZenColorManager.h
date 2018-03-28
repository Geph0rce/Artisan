//
//  ZenColorManager.h
//  Zen
//
//  Created by roger on 13-12-25.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZenColorManager : NSObject
{
    NSArray *_normal;
    NSArray *_highlight;
}

@property (nonatomic, strong) NSArray *normal;
@property (nonatomic, strong) NSArray *highlight;

+ (ZenColorManager *)sharedInstance;

- (UIColor *)colorForFid:(NSString *)fid;
- (UIColor *)colorForName:(NSString *)name;

- (void)generatePlistForFids;

@end
