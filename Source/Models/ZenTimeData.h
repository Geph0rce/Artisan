//
//  ZenTimeData.h
//  Artisan
//
//  Created by roger on 14-10-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZenTimeData : NSObject
{
    NSString *_desc;
    NSUInteger _time;
    BOOL _selected;
}

@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) NSUInteger time;
@property (nonatomic, assign) BOOL selected;

@end
