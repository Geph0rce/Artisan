//
//  NSString+RFNetworking.h
//  RFNetworking
//
//  Created by roger on 2017/11/28.
//  Copyright © 2017年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (RFNetworking)

- (NSString *)rf_md5;

@end
