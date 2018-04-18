//
//  RFNetworkingMacros.h
//  demo
//
//  Created by roger on 2017/11/28.
//  Copyright © 2017年 Zen. All rights reserved.
//

#ifndef RFNetworkingMacros_h
#define RFNetworkingMacros_h

// singleton
#define RFSingleton(className) \
+ (instancetype)sharedInstance { \
    static className *instance = nil; \
    static dispatch_once_t pred; \
    dispatch_once(&pred, ^{ \
        instance = [[className alloc] init]; \
    }); \
    return instance; \
}

// guard

#define NilSafe(string) (string ?: @"")


#endif
