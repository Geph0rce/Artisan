//
//  ZenSwitchHeader.h
//  Artisan
//
//  Created by roger on 14-9-28.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZenSwitchTagFirst = 1001,
    ZenSwitchTagSecond = 1002
} ZenSwitchTag;

@protocol ZenSwitchHeaderDelegate <NSObject>

- (void)onZenSwitchHeaderValueChanged:(ZenSwitchTag)tag;

@end

@interface ZenSwitchHeader : UIView
{
    __weak NSObject <ZenSwitchHeaderDelegate> *_delegate;
}

@property (nonatomic, weak) NSObject <ZenSwitchHeaderDelegate> *delegate;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIView *slider;

@end
