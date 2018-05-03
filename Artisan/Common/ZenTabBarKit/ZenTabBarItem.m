//
//  ZenTabBarItem.m
//  Artisan
//
//  Created by qianjie on 2018/5/3.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenTabBarItem.h"
#import "UIView+RFLayout.h"

static NSString *const kZenTabBarItemTitleKey = @"ZenTabBarItemTitleKey";
static NSString *const kZenTabBarItemIconKey = @"ZenTabBarItemIconKey";
static NSString *const kZenTabBarItemColorKey = @"ZenTabBarItemColorKey";
static NSString *const kZenTabBarItemImageKey = @"ZenTabBarItemImageKey";

static CGFloat const kZenTabBarItemImageWidth = 24.0;
static CGFloat const kZenTabBarItemImageHeight = 22.0;

@interface ZenTabBarItem ()

@property (nonatomic, strong) UILabel *iconLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSMutableDictionary *customizeDictionary;
@property (nonatomic, assign) UIControlState currentState;

@end

@implementation ZenTabBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.iconLabel];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.tabBarItemStyle == ZenTabBarItemStyleImage) {
        self.titleLabel.bottom = self.height - 4.0;
        self.titleLabel.centerX = self.width / 2.0;
        self.imageView.width = kZenTabBarItemImageWidth;
        self.imageView.height = kZenTabBarItemImageHeight;
        self.imageView.top = (self.titleLabel.top - self.imageView.height) / 2.0;
        self.imageView.left = (self.width - self.imageView.width) / 2.0;
    } else {
        self.titleLabel.bottom = self.height - 4.0;
        self.titleLabel.centerX = self.width / 2.0;
        self.iconLabel.top = (self.titleLabel.top - self.iconLabel.height) / 2.0;
        self.iconLabel.left = (self.width - self.iconLabel.width) / 2.0;
    }
}

- (void)updateState {
    NSString *title = [self tabBarItemValueForKey:kZenTabBarItemTitleKey];
    NSString *icon = [self tabBarItemValueForKey:kZenTabBarItemIconKey];
    UIImage *image = [self tabBarItemValueForKey:kZenTabBarItemImageKey];
    UIColor *color = [self tabBarItemValueForKey:kZenTabBarItemColorKey];
    
    self.titleLabel.text = title;
    self.titleLabel.textColor = color;
    [self.titleLabel sizeToFit];
    
    self.iconLabel.text = icon;
    self.iconLabel.textColor = color;
    [self.iconLabel sizeToFit];
    
    self.imageView.image = image;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Store Values for Different State

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    if (!title) {
        return;
    }
    [self setTabBarItemValue:title forKey:kZenTabBarItemTitleKey state:state];
}

- (void)setIcon:(NSString *)icon forState:(UIControlState)state {
    if (!icon) {
        return;
    }
    [self setTabBarItemValue:icon forKey:kZenTabBarItemIconKey state:state];
}

- (void)setColor:(UIColor *)color forState:(UIControlState)state {
    if (!color) {
        return;
    }
    [self setTabBarItemValue:color forKey:kZenTabBarItemColorKey state:state];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    if (!image) {
        return;
    }
    [self setTabBarItemValue:image forKey:kZenTabBarItemImageKey state:state];
}

- (id)tabBarItemValueForKey:(NSString *)key {
    NSDictionary *currentStateValues = self.customizeDictionary[@(self.currentState)];
    id value = currentStateValues[key];
    if (!value && self.currentState != UIControlStateNormal) {
        NSDictionary *normalStateValues = self.customizeDictionary[@(UIControlStateNormal)];
        return normalStateValues[key];
    }
    return value;
}

- (void)setTabBarItemValue:(id)value forKey:(NSString *)key state:(UIControlState)state {
    if (!value || !key) {
        return;
    }
    NSMutableDictionary *currentStateValues = [self.customizeDictionary[@(state)] mutableCopy];
    if (!currentStateValues) {
        currentStateValues = [[NSMutableDictionary alloc] init];
    }
    
    currentStateValues[key] = value;
    self.customizeDictionary[@(state)] = currentStateValues;
    [self updateState];
}

#pragma mark - Getters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:11.0];
    }
    return _titleLabel;
}

- (UILabel *)iconLabel {
    if (!_iconLabel) {
        _iconLabel = [[UILabel alloc] init];
        _iconLabel.font = kIconFont(24.0);
        _iconLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _iconLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (NSMutableDictionary *)customizeDictionary {
    if (!_customizeDictionary) {
        _customizeDictionary = [[NSMutableDictionary alloc] init];
    }
    return _customizeDictionary;
}

- (void)setTabBarItemStyle:(ZenTabBarItemStyle)tabBarItemStyle {
    _tabBarItemStyle = tabBarItemStyle;
    if (_tabBarItemStyle == ZenTabBarItemStyleImage) {
        self.imageView.hidden = NO;
        self.iconLabel.hidden = YES;
    } else {
        self.imageView.hidden = YES;
        self.iconLabel.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.currentState = selected ? UIControlStateSelected : UIControlStateNormal;
    [self updateState];
}


@end
