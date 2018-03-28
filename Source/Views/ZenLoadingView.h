//
//  ZenLoadingView.h
//  Zen
//
//  Created by roger on 13-8-19.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZenLoadingViewTypeUnderStatusBar,
    ZenLoadingViewTypeUnderNavigationBar
}ZenLoadingViewType;

@interface ZenLoadingView : UIView
{
    ZenLoadingViewType _type;
}

@property (nonatomic, assign) ZenLoadingViewType type;

- (void)setTitle:(NSString *)title;

- (void)show;

- (void)hide;

@end
