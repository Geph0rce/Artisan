//
//  ZenBaseController.h
//  Zen
//
//  Created by roger on 13-4-7.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import "AppDelegate.h"
#import "DDMenuController.h"
#import "ZenToast.h"

typedef void (^ZenBlock)(void);

typedef enum{
    ZenAnimationOptionHorizontal = 0,
    ZenAnimationOptionVertical
}ZenAnimationOption;

typedef enum{
    ZenPanDirectionNone,
    ZenPanDirectionLeft,
    ZenPanDirectionRight
} ZenPanDirection;

typedef enum{
    ZenPanCompletionNone,
    ZenPanCompletionRoot,
    ZenPanCompletionLeft,
    ZenPanCompletionRight
} ZenPanCompletion;

typedef enum {
    ZenPanStateNone,
    ZenPanStateShowingLeft,
    ZenPanStateShowingRight
} ZenPanState;

@interface ZenBaseController : UIViewController <UIGestureRecognizerDelegate>
{
    UIView *_container;
    UIView *_mask;
    ZenPanDirection _panDirection;
    CGPoint _panVelocity;
    CGFloat _panOriginX;
    CGFloat _panEndX;
    ZenPanState _state;
    BOOL _shouldBlockGesture;
    __weak ZenBaseController *_parentController;
    __weak ZenBaseController *_childController;
    BOOL _canShowLeft;
    BOOL _canShowRight;
}


@property (nonatomic, copy) ZenBlock coveredBlock;
@property (nonatomic, copy) ZenBlock childDismissBlock;
@property (nonatomic, assign) BOOL hasMask;
@property (nonatomic, assign) BOOL shouldBlockGesture;
@property (nonatomic, weak) ZenBaseController *parentController;
@property (nonatomic, weak) ZenBaseController *childController;

- (void)pushController:(ZenBaseController *)controller;

- (void)enablePanLeftGestureWithWillCoverBlock:(ZenBlock)willCoverBlock coveredBlock:(ZenBlock)coveredBlock andDismissBlock:(ZenBlock)dismissBlock;
- (void)enablePanRightGestureWithDismissBlock:(ZenBlock)block;

- (void)presentViewController:(ZenBaseController *)controller option:(ZenAnimationOption)option completion:(ZenBlock)block;
- (void)dismissViewControllerWithOption:(ZenAnimationOption)option completion:(ZenBlock)block;

- (void)blockDDMenuControllerGesture:(BOOL)block;

- (void)success:(NSString *)msg;
- (void)failed:(NSString *)msg;
- (void)alert:(NSString *)msg;

@end
