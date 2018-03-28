//
//  ZenCategoryModel.h
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenArtistData.h"
#import "ZenBaseModel.h"

#define kZenCategoryRequestFinished @"ZenCategoryRequestFinished"
#define kZenCategoryReuqestFailed @"ZenCategoryRequestFailed"

@interface ZenCategoryModel : ZenBaseModel
{
    NSMutableArray *_list;
}

@property (nonatomic, strong) NSMutableArray *list;

- (void)load:(NSString *)categoryId;
- (void)next:(NSString *)categoryId;

@end
