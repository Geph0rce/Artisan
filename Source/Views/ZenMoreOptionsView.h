//
//  ZenMoreOptionsView.h
//  ZenPro
//
//  Created by roger on 13-12-26.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZenMoreOptionsItemTypeRefresh = 1001,
    ZenMoreOptionsItemTypeReply,
    ZenMoreOptionsItemTypeArchive,
    ZenMoreOptionsItemTypeRecommend,
    ZenMoreOptionsItemTypeShare,
    ZenMoreOptionsItemTypeHide
}ZenMoreOptionsItemType;

@protocol ZenMoreOptionsViewDelegate <NSObject>

@optional

- (void)didSelectedOption:(ZenMoreOptionsItemType)type;

@end

@interface ZenMoreOptionsView : UIView
{
    __weak NSObject<ZenMoreOptionsViewDelegate> *_delegate;
}

@property (nonatomic, weak) NSObject<ZenMoreOptionsViewDelegate> *delegate;

- (void)show;

- (void)hide;

@end
