//
//  EGOLoadMoreTableFooterView.h
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

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	EGOOPullLoadMorePulling = 0,
	EGOOPullLoadMoreNormal,
	EGOOPullLoadMoreLoading,	
} EGOPullLoadMoreState;

@protocol EGOLoadMoreTableFooterDelegate;
@interface EGOLoadMoreTableFooterView : UIView {
	
	__weak id _delegate;
	EGOPullLoadMoreState _state;

	UILabel *_statusLabel;
	UIActivityIndicatorView *_activityView;
}

@property(nonatomic, weak) id <EGOLoadMoreTableFooterDelegate> delegate;


- (id)initWithFrame:(CGRect)frame andScrollView:(UIScrollView *)scrollView;

- (void)setTitle:(NSString *)title forState:(EGOPullLoadMoreState)state;
- (void)refreshColor;

- (void)egoLoadMoreScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoLoadMoreScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)egoLoadMoreScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
@protocol EGOLoadMoreTableFooterDelegate
- (BOOL)egoLoadMoreTableFooterDidTriggerLoadMore:(EGOLoadMoreTableFooterView*)view;
- (BOOL)egoLoadMoreTableFooterDataSourceIsLoading:(EGOLoadMoreTableFooterView*)view;
@optional
- (NSDate*)egoLoadMoreTableFooterDataSourceLastUpdated:(EGOLoadMoreTableFooterView*)view;
@end
