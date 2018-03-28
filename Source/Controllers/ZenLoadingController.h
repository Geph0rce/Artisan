//
//  ZenLoadingController.h
//  Artisan
//
//  Created by roger on 14-9-9.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "EGORefreshTableHeaderView.h"
#import "EGOLoadMoreTableFooterView.h"
#import "ZenBaseController.h"

@interface ZenLoadingController : ZenBaseController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_table;
    BOOL _enableLoadMore;
    CGFloat _barHeight;
}

- (void)load;
- (void)done;

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view;
- (BOOL)egoLoadMoreTableFooterDidTriggerLoadMore:(EGOLoadMoreTableFooterView *)view;


// to overide
- (void)modelReload;

- (void)modelLoadMore;

@end
