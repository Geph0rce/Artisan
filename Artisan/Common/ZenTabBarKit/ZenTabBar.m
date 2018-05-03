//
//  ZenTabBar.m
//  Artisan
//
//  Created by qianjie on 2018/5/3.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenTabBar.h"

@interface ZenTabBar ()

@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) NSMutableArray <ZenTabBarItem *> *tabBarItems;

@end

@implementation ZenTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topLineView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.topLineView.width = self.width;
    self.topLineView.height = ONE_PIXEL;
    if (self.tabBarItems.count > 0) {
        CGFloat width = roundf(self.width/self.tabBarItems.count);
        CGFloat offsetX = 0.0;
        for (ZenTabBarItem *tabBarItem in self.tabBarItems) {
            tabBarItem.top = self.topLineView.bottom;
            tabBarItem.left = offsetX;
            tabBarItem.width = width;
            tabBarItem.height = self.height;
            offsetX = tabBarItem.right;
        }
    }
}



#pragma mark - Actions

- (void)didSelectTabBarItem:(ZenTabBarItem *)item {
    self.selectedItem = item;
}

#pragma mark - Public API

- (void)setItems:(NSArray<ZenTabBarItem *> *)items {
    for (ZenTabBarItem *tabBarItem in self.tabBarItems) {
        [tabBarItem removeFromSuperview];
    }
    [self.tabBarItems removeAllObjects];
    
    for (ZenTabBarItem *tabBarItem in items) {
        [tabBarItem addTarget:self action:@selector(didSelectTabBarItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tabBarItem];
        [self.tabBarItems addObject:tabBarItem];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Getters and Setters

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor zenLineColor];
    }
    return _topLineView;
}

- (NSMutableArray<ZenTabBarItem *> *)tabBarItems {
    if (!_tabBarItems) {
        _tabBarItems = [[NSMutableArray alloc] init];
    }
    return _tabBarItems;
}

- (void)setSelectedItem:(ZenTabBarItem *)selectedItem {
    _selectedItem.selected = NO;
    _selectedItem = selectedItem;
    _selectedItem.selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
        [self.delegate tabBar:self didSelectItem:_selectedItem];
    }
}

@end
