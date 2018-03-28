//
//  EGOLoadMoreTableFooterView.m
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//  Modified by Roger on 12/18/2012 
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "ZenMacros.h"
#import "ZenConfig.h"
#import "EGOLoadMoreTableFooterView.h"

#define TEXT_COLOR	 [UIColor blackColor]
#define kLabelFontSmall [UIFont fontWithName:@"FZLTHK--GBK1-0" size:12.0f]
#define kLabelFontMid   [UIFont fontWithName:@"FZLTHK--GBK1-0" size:13.0f]
#define BACK_COLOR ZenColorFromRGB(0xd9d9d9)

#define FLIP_ANIMATION_DURATION 0.18f


@interface EGOLoadMoreTableFooterView ()
{
    NSString *_pullingText;
    NSString *_normalText;
    NSString *_loadingText;
    CALayer *_arrowImage;
}

@property (nonatomic, strong) NSString *pullingText;
@property (nonatomic, strong) NSString *normalText;
@property (nonatomic, strong) NSString *loadingText;

- (void)setState:(EGOPullLoadMoreState)aState;

@end

@implementation EGOLoadMoreTableFooterView

@synthesize delegate=_delegate;


- (id)initWithFrame:(CGRect)frame andScrollView:(UIScrollView *)scrollView{
    if (self = [super initWithFrame:frame]) {
		
        self.normalText = @"上拉加载更多...";
        self.pullingText = @"松开加载更多...";
        self.loadingText = @"加载中...";
        
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = BACK_COLOR;

		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = kLabelFontMid;
		label.textColor = TEXT_COLOR;
		//label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
				
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(25.0f, 20, 22.0f, 22.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:@"arrow_up"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage = layer;
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.frame = CGRectMake(25.0f, 20.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
				
                
        scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
		[self setState:EGOOPullLoadMoreNormal];
		
    }
	
    return self;	
}

- (void)refreshColor
{
    _statusLabel.textColor = TEXT_COLOR;
    self.backgroundColor = BACK_COLOR;
}

#pragma mark -
#pragma mark Setters

- (void)setTitle:(NSString *)title forState:(EGOPullLoadMoreState)state
{
    switch (state) {
        case EGOOPullLoadMorePulling:
            self.pullingText = title;
        case EGOOPullLoadMoreNormal:
            self.normalText = title;
            break;
        case EGOOPullLoadMoreLoading:
            self.loadingText = title;
        default:
            break;
    }
}

- (void)setState:(EGOPullLoadMoreState)aState{
	
	switch (aState) {
		case EGOOPullLoadMorePulling:			
			_statusLabel.text = _pullingText;
            [CATransaction begin];
            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [CATransaction commit];
            
			break;
		case EGOOPullLoadMoreNormal:			
			_statusLabel.text = _normalText;
			[_activityView stopAnimating];            
			[CATransaction begin];
            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _arrowImage.transform = CATransform3DIdentity;
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = NO;
            [CATransaction commit];
            
			break;
		case EGOOPullLoadMoreLoading:			
			_statusLabel.text = _loadingText;
			[_activityView startAnimating];
            
            [CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = YES;
			[CATransaction commit];
			break;
		default:
			break;
	}	
	_state = aState;
}



#pragma mark -
#pragma mark ScrollView Methods
- (void)egoLoadMoreScrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_state == EGOOPullLoadMoreLoading) {
        
		scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 60.0f, 0.0f);
		
	} else if (scrollView.isDragging) {
		
        BOOL _loading = NO;
        if ([_delegate respondsToSelector:@selector(egoLoadMoreTableFooterDataSourceIsLoading:)]) {
            _loading = [_delegate egoLoadMoreTableFooterDataSourceIsLoading:self];
        }
		
        CGFloat offsetY = (scrollView.frame.size.height - (scrollView.contentSize.height - scrollView.contentOffset.y));
        if (_state == EGOOPullLoadMorePulling && offsetY < 45.0f && offsetY > 0.0f && !_loading) {
            [self setState:EGOOPullLoadMoreNormal];
        } else if (_state == EGOOPullLoadMoreNormal && offsetY > 45.0f && !_loading) {
            [self setState:EGOOPullLoadMorePulling];
        }
		
        if (scrollView.contentInset.bottom != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
		
    }

}


- (void)egoLoadMoreScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
	BOOL _loading = NO;
    
    if (((scrollView.frame.size.height > scrollView.contentSize.height  && scrollView.contentOffset.y > 45.0f) || (scrollView.frame.size.height < scrollView.contentSize.height && (scrollView.frame.size.height - (scrollView.contentSize.height - scrollView.contentOffset.y)) > 45.0f))) {
		if ([_delegate respondsToSelector:@selector(egoLoadMoreTableFooterDataSourceIsLoading:)]) {
            _loading = [_delegate egoLoadMoreTableFooterDataSourceIsLoading:self];
        }
        if (!_loading) {
            BOOL trigger = NO;
            if ([_delegate respondsToSelector:@selector(egoLoadMoreTableFooterDidTriggerLoadMore:)]) {
                trigger = [_delegate egoLoadMoreTableFooterDidTriggerLoadMore:self];
            }
            if (trigger) {
                [self setState:EGOOPullLoadMoreLoading];
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.2];
                scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 60.0f, 0.0f);
                [UIView commitAnimations];
            }
        }
    }
}


- (void)egoLoadMoreScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {	
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[self setState:EGOOPullLoadMoreNormal];
}



@end
