//
//  ZenCategory.h
//  Zen
//
//  Created by roger on 13-8-2.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZenHelper)

- (NSString *)urlDecode;

- (NSString *)urlEncode;

- (NSString *)urlEncode:(NSStringEncoding)encoding;

- (NSString *)md5;

- (NSString *)idfa;

- (NSString *)stringByStrippingHTML;

- (NSString *)safeFormat;

- (NSString *)stringByEncodeCharacterEntities;

- (NSString *)filter;

- (BOOL)contains:(NSString *)str;

- (NSString *)begin:(NSString *)begin end:(NSString *)end;

- (CGSize)sizeWithZenFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (NSString *)sha1:(BOOL)isHex;

- (NSData *)stringToHexData;

@end


@interface NSArray (ZenHelper)

- (id)safeObjectAtIndex:(NSUInteger)index;

@end


@interface NSDictionary (ZenHelper)

- (BOOL)has:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (int)intForKey:(NSString *)key;
- (long long)longLongForKey:(NSString *)key;

@end


@interface NSMutableString (ZenHelper)

- (void)safeAppendString:(NSString *)string;

@end

@interface NSData (ZenHelper)

- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;

- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;

- (NSString *)dataToPlainText;

- (BOOL)isGif;

- (NSData *)filter;

@end

@interface UIImage (ZenHelper)

+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)cropToSize:(CGSize)newSize;
- (UIImage *)scaleToSize:(CGSize)newSize;

@end

@interface UIView (Layout)

- (void)centerInVertical;

- (void)centerInHorizontal;

- (void)centerInGravity;

@end