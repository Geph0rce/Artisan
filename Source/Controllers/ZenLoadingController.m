//
//  ZenLoadingController.m
//  Artisan
//
//  Created by roger on 14-9-9.
//  Copyright (c) 2014年 Zen. All rights reserved.
//

#import "ZenLoadingController.h"

@interface ZenLoadingController () <EGOLoadMoreTableFooterDelegate, EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_headerView;
    EGOLoadMoreTableFooterView *_footerView;
    BOOL _reloading;
    BOOL _loadingMore;
}

@end

@implementation ZenLoadingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad CGRect: %@", NSStringFromCGRect(_container.bounds));
    UITableView *table = [[UITableView alloc] initWithFrame:_container.bounds];
    _table = table;
    _table.delegate = self;
    _table.dataSource = self;
    _table.scrollsToTop = YES;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_table setAllowsSelection:YES];
    [_container addSubview:table];
    
    EGORefreshTableHeaderView *header = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, - CGRectGetHeight(_table.frame), CGRectGetWidth(_table.frame), CGRectGetHeight(_table.frame))];
    header.delegate = self;
    _headerView = header;
    [_table addSubview:header];
    
    if (_enableLoadMore) {
        EGOLoadMoreTableFooterView *footer = [[EGOLoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_table.frame), 200.0f) andScrollView:_table];
        _footerView = footer;
        _footerView.delegate = self;
        _footerView.hidden = YES;
        [_table addSubview:_footerView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)load
{
    [_headerView pullTheTrigle:_table];
}

- (void)done
{
    if (_reloading) {
        [self doneReloadingData];
    }
    if (_loadingMore) {
        [self doneLoadingMoreData];
    }
}

#pragma mark
#pragma mark - To be overide

- (void)modelReload
{}

- (void)modelLoadMore
{}

#pragma mark
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_headerView egoRefreshScrollViewDidScroll:scrollView];
    [_footerView egoLoadMoreScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_headerView egoRefreshScrollViewDidEndDragging:scrollView];
    [_footerView egoLoadMoreScrollViewDidEndDragging:scrollView];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadData
{
	if (!_loadingMore) {
        _reloading = YES;
        [self modelReload];
    }
}

- (void)doneReloadingData
{
    
    _reloading = NO;
	[_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:_table];
}

- (void)loadMoreData
{
    if (!_reloading && _enableLoadMore) {
        _loadingMore = YES;
        [self modelLoadMore];
    }
}

- (void)doneLoadingMoreData
{
    _loadingMore = NO;
    [_footerView egoLoadMoreScrollViewDataSourceDidFinishedLoading:_table];
}


#pragma mark -
#pragma egoRefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadData];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

#pragma mark -
#pragma EGOLoadMoreTableFooterDelegate Methods

- (BOOL)egoLoadMoreTableFooterDidTriggerLoadMore:(EGOLoadMoreTableFooterView *)view
{
    [self loadMoreData];
    return YES;
}

- (BOOL)egoLoadMoreTableFooterDataSourceIsLoading:(EGOLoadMoreTableFooterView *)view
{
    return _loadingMore;
}

#pragma mark
#pragma mark - UITableViewDataSource and UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"warning: ZenLoadingViewController table:cellForRowAtIndexPath called.");
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 5 && _enableLoadMore) {
        CGRect frame = _footerView.frame;
        frame.origin.y = _table.contentSize.height - 1.0f;
        _footerView.frame = frame;
        _footerView.hidden = NO;
    }
}


@end
