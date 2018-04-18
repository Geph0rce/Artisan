//
//  UIViewController+CRFNetworking.h
//  demo
//
//  Created by qianjie on 2017/12/18.
//  Copyright © 2017年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFNetworkManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CRFNetworking)

@property (nonnull, nonatomic, readonly, strong) RFNetworkManager *crf_networkManager;

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
- (void)post:(nonnull NSString *)url params:(nullable NSDictionary *)params complete:(nullable RFNetworkCompleteBlock)complete;

/**
 Upload image with jpeg format
 
 @param url, upload url
 @param image, jpeg image data
 @param progress, a block to handle upload progress
 @param complete, a block to handle response
 */
- (void)upload:(NSString *)url imageData:(NSData *)image progress:(nullable RFNetworkProgressBlock)progress complete:(nullable RFNetworkCompleteBlock)complete;


/**
 取消请求
 
 @param url
 */

- (void)cancel:(nonnull NSString *)url;

@end
NS_ASSUME_NONNULL_END
