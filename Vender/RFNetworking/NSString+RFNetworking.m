//
//  NSString+RFNetworking.m
//  demo
//
//  Created by qianjie on 2017/11/28.
//  Copyright © 2017年 Zen. All rights reserved.
//

#import "NSString+RFNetworking.h"

@implementation NSString (RFNetworking)

- (NSString *)rf_md5 {
    NSMutableString *output = [[NSMutableString alloc] init];
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


@end
