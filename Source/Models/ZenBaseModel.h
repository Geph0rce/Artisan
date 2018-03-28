//
//  ZenBaseModel.h
//  Artisan
//
//  Created by roger on 14-9-9.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZenCategory.h"
#import "DoubanArtist.h"

@interface ZenBaseModel : NSObject

- (void)send:(NSString *)notification;
- (void)send:(NSString *)notification info:(NSDictionary *)info;

@end
