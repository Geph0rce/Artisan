//
//  RFBaseModel.m
//  Artisan
//
//  Created by Roger on 25/04/2018.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "RFBaseModel.h"

@implementation RFBaseModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{ @"id_" : @"id" };
}


@end
