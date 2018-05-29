//
//  ZenTopSongRow.m
//  Artisan
//
//  Created by Roger on 25/04/2018.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenTopSongRow.h"

@interface ZenTopSongRowCell : RFTableViewCell

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *artistLabel;
@property (nonatomic, strong) UILabel *lengthLabel;
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation ZenTopSongRowCell

- (void)cellDidCreate {
    [super cellDidCreate];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.height = SCREEN_HEIGHT;
    self.contentView.height = SCREEN_HEIGHT;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.artistLabel];
    [self.contentView addSubview:self.lengthLabel];
    [self.contentView addSubview:self.bottomLineView];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_top_equalTo(16.0);
        make_left_equalTo(16.0);
        make_width_equalTo(60.0);
        make_height_equalTo(60.0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make_top_equalTo(self.coverImageView).offset(2.0);
        make_left_equalTo(self.coverImageView.mas_right).offset(16.0);
        make_right_lessThanOrEqualTo(-16.0);
    }];
    
    [self.artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make_bottom_equalTo(self.coverImageView).offset(-2.0);
        make_left_equalTo(self.titleLabel);
        make_right_lessThanOrEqualTo(-16.0);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_top_greaterThanOrEqualTo(self.coverImageView.mas_bottom).offset(16.0);
        make_left_equalTo(16.0);
        make_right_equalTo(self.contentView);
        make_bottom_equalTo(self.contentView);
        make_height_equalTo(ONE_PIXEL);
    }];
}

#pragma mark - Getters

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.layer.cornerRadius = 30.0;
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

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor zenLineColor];
    }
    return _bottomLineView;
}

@end


@implementation ZenTopSongRow

- (void)updateCell:(ZenTopSongRowCell *)cell indexPath:(NSIndexPath *)indexPath {
    [super updateCell:cell indexPath:indexPath];
    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.model.picture] placeholderImage:[UIImage imageNamed:@"cover"]];
    cell.titleLabel.text = self.model.name;
    cell.artistLabel.attributedText = [self artistAttributedString];
}

- (NSAttributedString *)artistAttributedString {
    if (self.model.artist.length > 0) {
        NSAttributedString *micro = icon_micro.typeface.font(kIconFont(12.0)).compose;
        return RFAttributedString(micro, @" ", self.model.artist);
    }
    return [[NSAttributedString alloc] init];
}

- (BOOL)autoAdjustCellHeight {
    return  YES;
}


@end
