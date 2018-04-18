//
//  RFNetworkManager.m
//  demo
//
//  Created by qianjie on 2017/11/28.
//  Copyright © 2017年 Zen. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "NSString+RFNetworking.h"
#import "RFNetworkTask.h"
#import "RFNetworkManager.h"

static NSString *const kRFNetworkManagerErrorDomain = @"com.artisan.networkmanager";

@interface RFNetworkManager ()

@property (nonatomic, strong) NSMutableArray<RFNetworkTask *> *tasks;

@end

@implementation RFNetworkManager

#pragma mark get and post

- (void)get:(NSString *)url params:(NSDictionary *)params complete:(RFNetworkCompleteBlock)complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    AFJSONRequestSerializer *requestSerializer = [[AFJSONRequestSerializer alloc] init];
    requestSerializer.timeoutInterval = 30;
    [requestSerializer setValue:@"iOS" forHTTPHeaderField:@"User-Agent"];
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    NSURLSessionDataTask *task = [manager GET:url parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger statusCode = [(NSHTTPURLResponse *)(task.response)  statusCode];
        [self removeTask:task];
        guard (complete) else {
            NSLog(@"get (%@) success without handler", url);
            return;
        }
        complete(responseObject, statusCode, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)(task.response)  statusCode];
        [self removeTask:task];
        guard (complete) else {
            NSLog(@"get (%@) failure without complete handler", url);
            return;
        }
        complete(nil, statusCode, error);
    }];
    
    [self addTask:task url:url];
}

- (void)post:(NSString *)url params:(NSDictionary *)params complete:(RFNetworkCompleteBlock)complete {
    [self post:url params:params progress:nil complete:complete];
}

- (void)post:(NSString *)url params:(NSDictionary *)params progress:(RFNetworkProgressBlock)progress complete:(RFNetworkCompleteBlock)complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    manager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"os"];
    manager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    
    NSURLSessionDataTask *task = [manager POST:url parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger statusCode = [(NSHTTPURLResponse *)(task.response)  statusCode];
        [self removeTask:task];
        guard (complete) else {
            NSLog(@"post (%@) success without handler", url);
            return;
        }
        complete(responseObject, statusCode, nil);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)(task.response)  statusCode];
        [self removeTask:task];
        guard (complete) else {
            NSLog(@"post (%@) failure without complete handler", url);
            return;
        }
        complete(nil, statusCode, error);

    }];
    
    [self addTask:task url:url];
}

- (void)upload:(NSString *)url imageData:(NSData *)data progress:(nullable RFNetworkProgressBlock)progress complete:(nullable RFNetworkCompleteBlock)complete {
    
    guard (data && url) else {
        NSLog(@"upload: invalid imageData or url");
        if (complete) {
            NSError *error =  [NSError errorWithDomain:kRFNetworkManagerErrorDomain code:1001 userInfo:@{ @"message" : @"upload: invalid imageData or url" }];
            complete(nil, 0, error);
        }
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *task = [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", @([[NSDate date] timeIntervalSince1970])];
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger statusCode = [(NSHTTPURLResponse *)(task.response)  statusCode];
        [self removeTask:task];
        guard (complete) else {
            NSLog(@"upload (%@) success without handler", url);
            return;
        }
        complete(responseObject, statusCode, nil);

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSInteger statusCode = [(NSHTTPURLResponse *)(task.response)  statusCode];
        [self removeTask:task];
        guard (complete) else {
            NSLog(@"upload (%@) failure without handler", url);
            return;
        }
        complete(nil, statusCode, error);

    }];
    [self addTask:task url:url];
}

- (void)cancel:(NSString *)url {
    RFNetworkTask *networkTask = [self findTaskByURL:url];
    guard (networkTask) else {
        NSLog(@"cancel: can not find task with url: (%@)", url);
        return;
    }
    
    [networkTask.task cancel];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tasks removeObject:networkTask];
    });

}

- (void)abort {
    for (RFNetworkTask *networkTask in self.tasks) {
        [networkTask.task cancel];
    }
}


#pragma mark - task manager

- (void)addTask:(NSURLSessionDataTask *)task url:(NSString *)url {
    NSString *digest = [url rf_md5];
    RFNetworkTask *networkTask = [[RFNetworkTask alloc] init];
    networkTask.digest = digest;
    networkTask.task = task;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tasks addObject:networkTask];
    });
}

- (void)removeTask:(NSURLSessionDataTask *)task {
    RFNetworkTask *taskToRemove = nil;
    for (RFNetworkTask *networkTask in self.tasks) {
        if (networkTask.task.taskIdentifier == task.taskIdentifier) {
            taskToRemove = networkTask;
        }
    }

    guard (taskToRemove) else {
        NSLog(@"removeTask: nothing to remove");
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tasks removeObject:taskToRemove];
    });
}

- (RFNetworkTask *)findTaskByURL:(NSString *)url {
    NSString *digest = [url rf_md5];
    for (RFNetworkTask *networkTask in self.tasks) {
        if ([networkTask.digest isEqualToString:digest]) {
            return networkTask;
        }
    }
    
    return nil;
}


#pragma mark - getters

- (NSMutableArray<RFNetworkTask *> *)tasks {
    if (!_tasks) {
        _tasks = [[NSMutableArray alloc] init];
    }
    return _tasks;
}

@end
