//
//  ZenCategory.m
//  Zen
//
//  Created by roger on 13-8-2.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "ZenCategory.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)

#pragma mark-
#pragma mark NSString Categroy

@implementation NSString (ZenHelper)

- (NSString *)urlDecode
{
    if (self == nil || [self isEqualToString:@""]) {
        NSLog(@"urlDecode:msg is nil.");
        return nil;        
    }
    NSString *result = nil;
    result = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

- (NSString *)urlEncode
{
    if (self == nil || [self isEqualToString:@""]) {
        NSLog(@"urlEncode:msg is nil.");
        return nil;        
    }
    NSString *result = nil;
    result = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

- (NSString *)urlEncode:(NSStringEncoding)encoding
{
    if (self == nil || [self isEqualToString:@""]) {
        NSLog(@"urlEncode:msg is nil.");
        return nil;
    }
    NSString *result = nil;
    result = [self stringByAddingPercentEscapesUsingEncoding:encoding];
    return result;
}

- (NSString *)md5
{
    const char *str = [self UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *hash = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return hash;
}

- (NSString *)idfa
{
    const char *str = [self UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *hash = [NSString stringWithFormat:@"%02X%02X%02X%02X-%02X%02X-%02X%02X-%02X%02X-%02X%02X%02X%02X%02X%02X",
                      r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return hash;
}

- (NSString *)stringByStrippingHTML
{
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

- (NSString *)safeFormat
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *number = [formatter numberFromString:self];
    NSString *numStr = [formatter stringFromNumber:number];
    return numStr;
}

- (NSString *)stringByEncodeCharacterEntities
{
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i = 0; i < self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if(ch < 255){
            [str appendFormat:@"%c", ch];
        }
        else {
            [str appendFormat:@"%@%d%@",@"%26%23", ch, @"%3B"];
        }
    }
    return str;
}

/**
 *	Get JSON from JS callback
 *
 *	@return	JSON String
 */
- (NSString *)filter
{
    NSRange r = [self rangeOfString:@"\\{.+\\}" options:NSRegularExpressionSearch];
    if (r.location != NSNotFound) {
        NSString *result = [self substringWithRange:r];
        return  result;
    }
    return nil;
}

- (BOOL)contains:(NSString *)str
{
    if (str && ![str isEqualToString:@""]) {
        NSRange range = [self rangeOfString:str];
        if (range.location != NSNotFound) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)begin:(NSString *)begin end:(NSString *)end
{
    if (begin) {
        NSRange range = [self rangeOfString:begin];
        if (range.location != NSNotFound) {
            NSUInteger from = range.location + range.length;
            NSString *subStr = [self substringFromIndex:from];
            if (end && ![end isEqualToString:@""]) {
                range = [subStr rangeOfString:end];
                if (range.location != NSNotFound) {
                    NSUInteger to = range.location;
                    return [subStr substringToIndex:to];
                }
            }
            return subStr;
        }
    }
    
    return nil;
}

- (CGSize)sizeWithZenFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize newSize = CGSizeZero;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        NSDictionary *attrs = @{NSFontAttributeName:font};
        return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    }
    else {
        return [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }
    return newSize;
}

- (NSString *)sha1:(BOOL)isHex
{
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        if (isHex) {
            [output appendFormat:@"%02x", digest[i]];
        }
        else {
            [output appendFormat:@"%02d", digest[i]%100];
        }
    }
    
    return output;
}


- (NSData *)stringToHexData
{
    NSString *str = self;
    if (str.length > 0) {
        
        if (str.length % 2 != 0) { // align
            str = [NSString stringWithFormat:@"0%@", str];
        }
        
        NSMutableData *data = [[NSMutableData alloc] init];
        for (int i = 0; i < str.length/2; i++) {
            
            NSRange range = NSMakeRange(i * 2, 2);
            NSString *sub = [str substringWithRange:range];
            unsigned int tmp = 0;
            [[NSScanner scannerWithString:sub] scanHexInt:&tmp];
            [data appendBytes:&tmp length:1];
        }
        
        return data;
        
    }
    
    return nil;
}

@end


#pragma mark - 
#pragma mark NSArray Categroy

@implementation NSArray (ZenHelper)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (self.count > index) {
        return [self objectAtIndex:index];
    }
    
    return nil;
}

@end


#pragma mark -
#pragma mark - NSDictionary Categroy

@implementation NSDictionary (ZenHelper)

- (BOOL)has:(NSString *)key
{
    __block BOOL result = NO;
    [self enumerateKeysAndObjectsUsingBlock:^(id tmpKey, id obj, BOOL *stop) {
        if ([tmpKey isKindOfClass:[NSString class]] && [key isEqualToString:tmpKey]) {
            *stop = YES;
            result = YES;
        }
    }];
    return result;
}

- (NSString *)stringForKey:(NSString *)key
{
    NSObject *object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        return (NSString *)object;
    }
    else if ([object isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%lld", [(NSNumber *)object longLongValue]];
    }
    return @"";
}

- (long long)longLongForKey:(NSString *)key
{
    NSObject *object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object longLongValue];
    }
    else if([object isKindOfClass:[NSString class]]){
        return [(NSString *)object longLongValue];
    }
    else
    {
        NSLog(@"object can not represent as int.");
        return -1;
    }
}

- (int)intForKey:(NSString *)key
{
    NSObject *object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object intValue];
    }
    else if([object isKindOfClass:[NSString class]]){
        return [(NSString *)object intValue];
    }
    else
    {
        NSLog(@"object can not represent as int.");
        return -1;
    }
}

@end

#pragma mark -
#pragma mark - NSMutableString Category

@implementation NSMutableString (ZenHelper)

-(void)safeAppendString:(NSString *)string
{
    if (string != nil) {
        [self appendString:string];
        return;
    }  
    
    NSLog(@"safeAppendingString: Are you kidding me? string is nil.");
    
}

@end

@implementation NSData (ZenHelper)

- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv
{
    NSUInteger dataInLen = [self length];
    size_t dataOutAvailable = dataInLen + kCCBlockSizeAES128;
    void *dataOut = malloc(dataOutAvailable);
    size_t dataOutMoved = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          [key length],
                                          [iv UTF8String],
                                          [self bytes],
                                          dataInLen,
                                          dataOut,
                                          dataOutAvailable,
                                          &dataOutMoved);
    
    if (cryptStatus == kCCSuccess) {
        
        NSData *data = [NSData dataWithBytes:dataOut length:dataOutMoved];
        free(dataOut);
        return data;
    }
    
    free(dataOut);
    return nil;
}

- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv
{
    return [self AES128Operation:kCCEncrypt key:key iv:iv];
}

- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv
{
    return [self AES128Operation:kCCDecrypt key:key iv:iv];
}

- (NSString *)dataToPlainText
{
    NSMutableString *str = [[NSMutableString alloc] init];
    const unsigned char* bytes = (const unsigned char*)[self bytes];
    
    for (int i = 0; i < [self length]; i++) {
        [str appendFormat:@"%02x", bytes[i]];
    }
    return str;
}

- (BOOL)isGif
{
    BOOL isGIF = NO;
    
    uint8_t c;
    [self getBytes:&c length:1];
    
    switch (c)
    {
        case 0x47:  // probably a GIF
            isGIF = YES;
            break;
        default:
            break;
    }
    
    return isGIF;
}

- (NSData *)filter
{
    NSString *str = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    if (str) {
        NSRange r = [str rangeOfString:@"\\{.+\\}" options:NSRegularExpressionSearch];
        if (r.location != NSNotFound) {
            NSString *result = [str substringWithRange:r];
            return  [result dataUsingEncoding:NSUTF8StringEncoding];
        }
    }
    return nil;
}

@end

#pragma mark -
#pragma mark - UIImage Category

@implementation UIImage (ZenHelper)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)cropToSize:(CGSize)newSize
{
	const CGSize size = self.size;
    if (size.width < newSize.width || size.height < newSize.height) {
        NSLog(@"don't need to crop.");
        return self;
    }
	CGFloat x, y;
	
    x = (size.width - newSize.width) * 0.5f;
    y = (size.height - newSize.height) * 0.5f;
    
    CGRect cropRect = CGRectMake(x * self.scale, y * self.scale, newSize.width * self.scale, newSize.height * self.scale);
    
	/// Create the cropped image
	CGImageRef croppedImageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect);
	UIImage* cropped = [UIImage imageWithCGImage:croppedImageRef scale:self.scale orientation:self.imageOrientation];
    
	CGImageRelease(croppedImageRef);
    
	return cropped;
}

- (UIImage *)scaleToSize:(CGSize)newSize
{
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

@implementation UIView (Layout)

- (void)centerInVertical
{
    UIView *superView = self.superview;
    if (superView) {
        CGSize size = superView.frame.size;
        CGPoint center = self.center;
        center.y = size.height/2.0f;
        self.center = center;
    }
}

- (void)centerInHorizontal
{
    UIView *superView = self.superview;
    if (superView) {
        CGSize size = superView.frame.size;
        CGPoint center = self.center;
        center.x = size.width/2.0f;
        self.center = center;
    }
}

- (void)centerInGravity
{
    UIView *superView = self.superview;
    if (superView) {
        CGSize size = superView.frame.size;
        CGPoint center = CGPointMake(size.width/2.0f, size.height/2.0f);
        self.center = center;
    }
}

@end