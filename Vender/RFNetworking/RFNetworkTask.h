//
//  RFNetworkTask.h
//  demo
//
//  Created by qianjie on 2017/11/28.
//  Copyright © 2017年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFNetworkTask : NSObject

@property (nonatomic, copy) NSString *digest;
@property (nonatomic, strong) NSURLSessionDataTask *task;

@end
