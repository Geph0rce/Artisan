//
//  ZenAlbumData.h
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZenAlbumData : NSObject
{
    NSString *_aid;
    NSString *_name;
}

@property (nonatomic, strong) NSString *aid;
@property (nonatomic, strong) NSString *name;

@end
