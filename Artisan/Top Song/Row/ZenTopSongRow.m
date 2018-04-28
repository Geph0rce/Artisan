//
//  ZenTopSongRow.m
//  Artisan
//
//  Created by Roger on 25/04/2018.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenTopSongRow.h"

@interface ZenTopSongRowCell : RFTableViewCell

@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *artistLabel;
@property (nonatomic, strong) UILabel *lengthLabel;

@end

@implementation ZenTopSongRowCell

- (void)cellDidCreate {
    [super cellDidCreate];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.height = SCREEN_HEIGHT;
    self.contentView.height = SCREEN_HEIGHT;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.cardView];
    [self.cardView addSubview:self.coverImageView];
    [self.cardView addSubview:self.titleLabel];
    [self.cardView addSubview:self.artistLabel];
    [self.cardView addSubview:self.lengthLabel];
    
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_edges_equalTo(self.contentView).insets(UIEdgeInsetsMake(10.0, 12.0, 10.0, 12.0));
    }];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_top_equalTo(15.0);
        make_left_equalTo(15.0);
        make_width_equalTo(50.0);
        make_height_equalTo(50.0);
        make_bottom_lessThanOrEqualTo(-15.0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make_top_equalTo(self.coverImageView).offset(2.0);
        make_left_equalTo(self.coverImageView.mas_right).offset(12.0);
        make_right_lessThanOrEqualTo(-15.0);
    }];
    
    [self.artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make_bottom_equalTo(self.coverImageView).offset(-2.0);
        make_left_equalTo(self.titleLabel);
        make_right_lessThanOrEqualTo(-15.0);
    }];
}

#pragma mark - Getters

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.layer.cornerRadius = 25.0;
        _coverImageView.layer.masksToBounds = YES;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kAppFont(16.0);
        _titleLabel.textColor = [UIColor zenBlackColor];
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)artistLabel {
    if (!_artistLabel) {
        _artistLabel = [[UILabel alloc] init];
        _artistLabel.font = kAppFont(13.0);
        _artistLabel.textColor = [UIColor zenGrayColor];
    }
    return _artistLabel;
}

- (UILabel *)lengthLabel {
    if (!_lengthLabel) {
        _lengthLabel = [[UILabel alloc] init];
        _lengthLabel.font = kAppFont(13.0);
        _lengthLabel.textColor = [UIColor zenGrayColor];
    }
    return _lengthLabel;
}

- (UIView *)cardView {
    if (!_cardView) {
        _cardView = [[UIView alloc] init];
        _cardView.backgroundColor = [UIColor zenBackgroundColor];
        _cardView.layer.cornerRadius = 4.0;
        _cardView.layer.shadowColor = [UIColor zenGrayColor].CGColor;
        _cardView.layer.shadowOpacity = 0.3;
        _cardView.layer.shadowRadius = 4.0;
        _cardView.layer.shadowOffset = CGSizeMake(0.0, 4.0);
    }
    return _cardView;
}

@end


@implementation ZenTopSongRow

- (void)updateCell:(ZenTopSongRowCell *)cell indexPath:(NSIndexPath *)indexPath {
    [super updateCell:cell indexPath:indexPath];
    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.model.picture] placeholderImage:[UIImage imageNamed:@"cover"]];
    cell.titleLabel.text = self.model.name;
    cell.artistLabel.text = self.model.artist;
}

- (BOOL)autoAdjustCellHeight {
    return  YES;
}


@end
