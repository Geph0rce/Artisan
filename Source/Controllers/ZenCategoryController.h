//
//  ZenCategoryController.h
//  Artisan
//
//  Created by roger on 14-9-10.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenLoadingController.h"

@interface ZenCategoryController : ZenLoadingController
{
    NSString *_name;
    NSString *_gid;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gid;

@end
