//
//  NSObject+RFFilter.m
//  Artisan
//
//  Created by qianjie on 2018/4/25.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "NSObject+RFFilter.h"

@implementation NSObject (RFFilter)

- (NSString *)json
{
    if ([self isKindOfClass:[NSData class]]) {
        NSData *data = (NSData *)self;
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (str) {
            NSRange r = [str rangeOfString:@"\\{.+\\}" options:NSRegularExpressionSearch];
            if (r.location != NSNotFound) {
                NSString *result = [str substringWithRange:r];
                return result;
            }
        }
    }
    return nil;
}

@end
