//
//  RFNetworkManager.h
//  demo
//
//  Created by qianjie on 2017/11/28.
//  Copyright © 2017年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFNetworkingMacros.h"

NS_ASSUME_NONNULL_BEGIN
/**
 网络请求完成后，处理返回数据的Block

 @param errorType RFNetworkCompleteType
 @param response - JSON
 */
typedef void (^RFNetworkCompleteBlock) (__kindof NSObject *_Nullable response, NSInteger statusCode, NSError * _Nullable error);
typedef void (^RFNetworkProgressBlock) (NSProgress * _Nonnull uploadProgress);
@interface RFNetworkManager : NSObject

/**
 GET

 @param url
 @param params query @{ @"dummy" : @"data" } -> ?dummy=data append to url
 @param complete handle response
 */
- (void)get:(nonnull NSString *)url params:(nullable NSDictionary *)params complete:(nullable RFNetworkCompleteBlock)complete;


/**
 POST

 @param url
 @param params http body JSON
 @param complete handle response
 */
- (void)post:(NSString *)url params:(nullable NSDictionary *)params complete:(nullable RFNetworkCompleteBlock)complete;


/**
 POST with progress

 @param url
 @param params
 @param progress
 @param complete handle response
 */
- (void)post:(NSString *)url params:(NSDictionary *)params progress:(RFNetworkProgressBlock)progress complete:(RFNetworkCompleteBlock)complete;

/**
 Upload image with jpeg format

 @param url, upload url
 @param data, image data of jpeg
 @param progress, a block to handle upload progress
 @param complete, a block to handle response
 */
- (void)upload:(NSString *)url imageData:(NSData *)data progress:(nullable RFNetworkProgressBlock)progress complete:(nullable RFNetworkCompleteBlock)complete;

/**
 取消请求

 @param url 
 */
- (void)cancel:(NSString *)url;


/**
 取消所有请求
 */
- (void)abort;

@end
NS_ASSUME_NONNULL_END
