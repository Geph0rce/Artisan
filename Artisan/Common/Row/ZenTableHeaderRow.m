//
//  ZenTableHeaderRow.m
//  Artisan
//
//  Created by qianjie on 2018/4/28.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenTableHeaderRow.h"

@interface ZenTableHeaderRowCell : RFTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) UIEdgeInsets padding;

@end

@implementation ZenTableHeaderRowCell

- (void)cellDidCreate {
    [super cellDidCreate];
    [self.contentView addSubview:self.titleLabel];
}

- (void)updateConstraints {
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make_top_equalTo(self.padding.top);
        make_left_equalTo(self.padding.left);
        make_bottom_lessThanOrEqualTo(-self.padding.bottom);
        make_right_lessThanOrEqualTo(-self.padding.right);
    }];
    [super updateConstraints];
}

#pragma mark - Getters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

@end

@implementation ZenTableHeaderRow

- (void)updateCell:(ZenTableHeaderRowCell *)cell indexPath:(NSIndexPath *)indexPath {
    [super updateCell:cell indexPath:indexPath];
    cell.titleLabel.font = self.font;
    cell.titleLabel.textColor = self.textColor;
    cell.titleLabel.text = self.title;
    cell.padding = self.padding;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
}

- (BOOL)autoAdjustCellHeight {
    return YES;
}

#pragma mark - Getters

- (UIFont *)font {
    return _font ?: kAppBoldFont(26.0);
}

- (UIColor *)textColor {
    return _textColor ?: [UIColor zenBlackColor];
}

- (UIEdgeInsets)padding {
    return UIEdgeInsetsEqualToEdgeInsets(_padding, UIEdgeInsetsZero) ? UIEdgeInsetsMake(20.0, 16.0, 18.0, 16.0) : _padding;
}

@end
