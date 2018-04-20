//
//  RFScreen.h
//  demo
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFScreen : NSObject

@property (nonatomic, readonly, assign) CGFloat screenWidth;
@property (nonatomic, readonly, assign) CGFloat screenHeight;
@property (nonatomic, readonly, assign) CGFloat screenScale;
@property (nonatomic, readonly, assign) CGFloat statusBarHeight;
@property (nonatomic, readonly, assign) CGFloat navigationBarHeight;
@property (nonatomic, readonly, assign) CGFloat navigationBarBottom;

@end
