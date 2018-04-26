//
//  ZenTopArtistModel.m
//  Artisan
//
//  Created by Roger on 26/04/2018.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenTopArtistModel.h"

@implementation ZenTopArtistModel



@end

@implementation ZenTopArtistReponse

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"artists" : [ZenTopArtistModel class]
             };
}

@end
