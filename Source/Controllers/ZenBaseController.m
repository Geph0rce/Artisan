//
//  ZenBaseController.m
//  Zen
//
//  Created by roger on 13-4-7.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import "UIColor+MLPFlatColors.h"
#import "AppDelegate.h"
#import "ZenStack.h"
#import "ZenMacros.h"
#import "ZenBaseController.h"


#define kScaleFactor 0.02f
#define kAlphaFactor 0.1f
#define kZenEpisnon 0.5f
#define kZenOffsetX 30.0f

@interface ZenBaseController ()

@property (nonatomic, copy) ZenBlock dismissBlock;
@property (nonatomic, copy) ZenBlock willCoverBlock;


@end

@implementation ZenBaseController

@synthesize parentController = _parentController;
@synthesize childController = _childController;

@synthesize hasMask = _hasMask;
@synthesize shouldBlockGesture = _shouldBlockGesture;
@synthesize dismissBlock = _dismissBlock;
@synthesize willCoverBlock = _willCoverBlock;
@synthesize coveredBlock = _coveredBlock;
@synthesize childDismissBlock = _childDismissBlock;

- (void)dealloc
{
    NSLog(@"ZenBaseController dealloc!");
}

- (id)init
{
    if (self = [super init]) {
        _shouldBlockGesture = NO;
        _canShowLeft = NO;
        _canShowRight = NO;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor blackColor];
    
    UIView *container = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:container];
    _container = container;
    _container.backgroundColor = kZenBackgroundColor;
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    UIView *mask = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mask];
    mask.alpha = 0.1f;
    mask.hidden = YES;
    _mask = mask;
    _mask.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)pushController:(ZenBaseController *)controller
{
    [[ZenStack sharedInstance] push:controller];
    controller.parentController = self;
    self.childController = controller;
    [self.view addSubview:controller.view];
}

#pragma mark -
#pragma mark - KVO Stuff

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        UIView *contentView = (UIView *)object;
        CGFloat originX = contentView.frame.origin.x;
        CGFloat originY = contentView.frame.origin.y;
        
        CGFloat factor = 0;
        if (originX < kZenEpisnon) {
            factor =  1 - originY/CGRectGetHeight(contentView.frame);
        }
        else if(originY < kZenEpisnon){
            factor =  1 - originX/CGRectGetWidth(contentView.frame);
        }
       
        CGFloat scale = 1.0f - (kScaleFactor * factor);
        CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
        _container.transform = transform;
        _mask.alpha = kAlphaFactor + factor;
    }
    else if([keyPath isEqualToString:@"hasMask"]){
        ZenBaseController *vc = (ZenBaseController *)object;
        _mask.hidden = !vc.hasMask;
    }
}

#pragma mark -
#pragma mark - Pan Gesture Stuff

- (void)enablePanRightGestureWithDismissBlock:(ZenBlock)block
{
    if (!_canShowRight) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        pan.delegate = self;
        [self.view addGestureRecognizer:pan];
    }
    _canShowLeft = YES;
    self.dismissBlock = block;
}

- (void)enablePanLeftGestureWithWillCoverBlock:(ZenBlock)willCoverBlock coveredBlock:(ZenBlock)coveredBlock andDismissBlock:(ZenBlock)dismissBlock
{
    if (!_canShowLeft) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        pan.delegate = self;
        [self.view addGestureRecognizer:pan];
    }

    _canShowRight = YES;
    self.willCoverBlock = willCoverBlock;
    self.coveredBlock = coveredBlock;
    self.childDismissBlock = dismissBlock;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return (!_shouldBlockGesture);
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        _panOriginX = self.view.frame.origin.x;
        _panVelocity = CGPointMake(0.0f, 0.0f);
        
        if([gesture velocityInView:self.view.superview].x > 0) {
            _panDirection = ZenPanDirectionRight;
        }
        else {
            _panDirection = ZenPanDirectionLeft;
            if (_canShowRight && _willCoverBlock) {
                _willCoverBlock();
            }
        }
        
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        
        CGPoint velocity = [gesture velocityInView:self.view.superview];
        if((velocity.x*_panVelocity.x + velocity.y*_panVelocity.y) < 0) {
            _panDirection = (_panDirection == ZenPanDirectionRight) ? ZenPanDirectionLeft : ZenPanDirectionRight;
        }
        
        _panVelocity = velocity;
        CGPoint translation = [gesture translationInView:self.view.superview];
        CGRect frame = self.view.frame;
        frame.origin.x = _panOriginX + translation.x;

        if(frame.origin.x > 0 && _canShowLeft)
        {
            if (_state == ZenPanStateNone && _panDirection == ZenPanDirectionRight) {
                _state = ZenPanStateShowingLeft;
            }
            if (_state == ZenPanStateShowingLeft) {
                self.view.frame = frame;
                _panEndX = frame.origin.x;
            }
        }
        else if(_canShowRight)
        {
            if (_state == ZenPanStateNone && _panDirection == ZenPanDirectionLeft) {
                _state = ZenPanStateShowingRight;
            }
            if (_state == ZenPanStateShowingRight) {
                if (_childController) {
                    CGRect childFrame = _childController.view.frame;
                    childFrame.origin.x = 320.0f + translation.x;
                    if (childFrame.origin.x < 0) {
                        childFrame.origin.x = 0.0f;
                    }
                    _childController.view.frame = childFrame;
                }
            }

        }
    }
    else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        ZenPanCompletion  completion =  ZenPanCompletionNone;
        
        if(_canShowLeft && _state == ZenPanStateShowingLeft && (_panEndX < kZenOffsetX || _panDirection == ZenPanDirectionLeft))
        {
            completion = ZenPanCompletionRoot;
        }
        else if (_canShowLeft && _state == ZenPanStateShowingLeft && _panDirection == ZenPanDirectionRight) {
            completion = ZenPanCompletionLeft;
        }
       
        else if(_canShowRight && _state == ZenPanStateShowingRight && _panDirection == ZenPanDirectionLeft)
        {
            completion = ZenPanCompletionRight;
        }
        else if(_canShowRight && _state == ZenPanStateShowingRight && _panDirection == ZenPanDirectionRight)
        {
            completion = ZenPanCompletionNone;
        }
    
        
        if (completion == ZenPanCompletionLeft) {
            [self viewWillDisappear:YES];
            __block CGRect frame = self.view.frame;
            [UIView animateWithDuration:0.3f
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 frame.origin.x = CGRectGetWidth(self.view.frame);
                                 self.view.frame = frame;
                             }
                             completion:^(BOOL finished) {
                                 if (_dismissBlock) {
                                     _dismissBlock();
                                 }
                                 self.hasMask = NO;
                                 self.parentController.childController = nil;
                                 [self.view removeFromSuperview];
                                 [self viewDidDisappear:YES];
                                 [self.parentController  viewDidAppear:YES];
                                 [self removeObserver:self.parentController forKeyPath:@"hasMask"];
                                 [self.view removeObserver:self.parentController forKeyPath:@"frame"];
                                 self.parentController = nil;
                                 [[ZenStack sharedInstance] pop:self];
                                 
                             }];

        }
        else if(completion == ZenPanCompletionRoot){
            if (self.view.frame.origin.x > 0) {
                __block CGRect frame = self.view.frame;
                [UIView animateWithDuration:0.3f
                                      delay:0.0f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     frame.origin.x = 0.0f;
                                     self.view.frame = frame;
                                 }
                                 completion:^(BOOL finished) {
                                     _state = ZenPanStateNone;
                                 }];
            }
        }

        else if(completion == ZenPanCompletionRight){
            if (_childController) {
                __block CGRect frame = _childController.view.frame;
                [UIView animateWithDuration:0.3f
                                      delay:0.0f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     frame.origin.x = 0.0f;
                                     _childController.view.frame = frame;
                                 }
                                 completion:^(BOOL finished) {
                                     if (_coveredBlock) {
                                         _coveredBlock();
                                     }
                                     _state = ZenPanStateNone;
                                 }];

            }
        }
        else if(_canShowRight && completion == ZenPanCompletionNone){
            if (_childController) {
                __block CGRect frame = _childController.view.frame;
                [UIView animateWithDuration:0.3f
                                      delay:0.0f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     frame.origin.x = CGRectGetWidth(self.view.frame);
                                     _childController.view.frame = frame;
                                 }
                                 completion:^(BOOL finished) {
                                     if (_childDismissBlock) {
                                         _childDismissBlock();
                                     }
                                     _childController.hasMask = NO;
                                     [_childController.view removeFromSuperview];
                                     [_childController viewDidDisappear:YES];
                                     [[ZenStack sharedInstance] pop:_childController];
                                     _childController = nil;
                                     _state = ZenPanStateNone;
                                 }];
                
            }
        }

        
    }
}

- (void)blockDDMenuControllerGesture:(BOOL)block
{
    DDMenuController *menuController = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    menuController.shouldBlockGesture = block;

}

- (void)setParentController:(ZenBaseController *)parentController
{
    if (parentController) {
        _parentController = parentController;
        [self.view addObserver:parentController forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:parentController forKeyPath:@"hasMask" options:NSKeyValueObservingOptionNew context:NULL];
    }
    
}

#pragma mark -
#pragma mark - ViewController Presentation

- (void)presentViewController:(ZenBaseController *)controller option:(ZenAnimationOption)option completion:(ZenBlock)block
{
    if (!controller || _childController) {
        NSLog(@"controller is nil.");
        return;
    }
    self.childController = controller;
    controller.parentController = self;
    [[ZenStack sharedInstance] push:controller];
    
    [controller viewWillAppear:YES];
    
    if (option == ZenAnimationOptionHorizontal) {
        CGRect rect = controller.view.frame;
        rect.origin.x = CGRectGetWidth(self.view.bounds);
        controller.view.frame = rect;
        [self.view addSubview:controller.view];
        controller.hasMask = YES;
        
        __block CGRect frame = controller.view.frame;
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             frame.origin.x = 0.0f;
                             controller.view.frame = frame;
                         }
                         completion:^(BOOL finished) {
                             if (block) {
                                 block();
                             }
                             [self viewDidDisappear:YES];
                         }];
    }
    else if (option == ZenAnimationOptionVertical) {
        CGRect rect = controller.view.frame;
        rect.origin.y = CGRectGetHeight(self.view.bounds);
        controller.view.frame = rect;
        [self.view addSubview:controller.view];
        controller.hasMask = YES;
        
        __block CGRect frame = controller.view.frame;
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             frame.origin.y = 0.0f;
                             controller.view.frame = frame;
                         }
                         completion:^(BOOL finished) {
                             if (block) {
                                 block();
                             }

                         }];
    }

}

- (void)dismissViewControllerWithOption:(ZenAnimationOption)option completion:(ZenBlock)block
{
    __block CGRect frame = self.view.frame;
    [self viewWillDisappear:YES];
    if (option == ZenAnimationOptionHorizontal) {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             frame.origin.x = CGRectGetWidth(self.view.frame);
                             self.view.frame = frame;
                         }
                         completion:^(BOOL finished) {
                             if (block) {
                                block(); 
                             }
                             self.hasMask = NO;
                             self.parentController.childController = nil;
                             
                             [self.view removeFromSuperview];

                             [_parentController viewDidAppear:YES];
                             [self removeObserver:self.parentController forKeyPath:@"hasMask"];
                             [self.view removeObserver:self.parentController forKeyPath:@"frame"];
                             self.parentController = nil;
                             [[ZenStack sharedInstance] pop:self];
                         }];
    }
    else if (option == ZenAnimationOptionVertical) {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             frame.origin.y = CGRectGetHeight(self.view.frame);
                             self.view.frame = frame;
                         }
                         completion:^(BOOL finished) {
                             if (block) {
                                 block();
                             }
                             self.hasMask = NO;
                             self.parentController.childController = nil;
                             [self.view removeFromSuperview];

                             [_parentController viewDidAppear:YES];
                             [self removeObserver:self.parentController forKeyPath:@"hasMask"];
                             [self.view removeObserver:self.parentController forKeyPath:@"frame"];
                             self.parentController = nil;
                             [[ZenStack sharedInstance] pop:self];
                         }];
    }
}


#pragma mark
#pragma mark ZenToast

- (void)success:(NSString *)msg
{
    ZenToast *toast = [ZenToast sharedInstance];
    [toast postMessage:msg type:ZenToastTypeSuccess dismissAfterDelay:1.0f];
}

- (void)warning:(NSString *)msg
{
    ZenToast *toast = [ZenToast sharedInstance];
    [toast postMessage:msg type:ZenToastTypeWarning dismissAfterDelay:1.0f];
}

- (void)failed:(NSString *)msg
{
    ZenToast *toast = [ZenToast sharedInstance];
    [toast postMessage:msg type:ZenToastTypeError dismissAfterDelay:1.0f];
}

- (void)alert:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
