//
//  ZenArtistHeaderRow.m
//  Artisan
//
//  Created by qianjie on 2018/5/18.
//  Copyright © 2018 Zen. All rights reserved.
//

#import "ZenArtistHeaderRow.h"

@interface ZenArtistHeaderRowCell : RFTableViewCell

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIVisualEffectView *blurView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *styleLabel;
@property (nonatomic, strong) UILabel *fansLabel;
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation ZenArtistHeaderRowCell

- (void)cellDidCreate {
    [super cellDidCreate];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.backgroundImageView];
    [self.contentView addSubview:self.blurView];
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.styleLabel];
    [self.contentView addSubview:self.fansLabel];
    [self.contentView addSubview:self.bottomLineView];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_edges_equalTo(self.contentView);
    }];
    
    [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_edges_equalTo(self.contentView);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_top_equalTo(RFStatusBarHeight + RFNavigationBarHeight + 21.0);
        make_left_equalTo(16.0);
        make_width_equalTo(60.0);
        make_height_equalTo(60.0);
    }];
    
    [self.styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make_centerY_equalTo(self.avatarImageView);
        make_left_equalTo(self.avatarImageView.mas_right).offset(16.0);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make_left_equalTo(self.styleLabel);
        make_bottom_equalTo(self.styleLabel.mas_top).offset(-8.0);
    }];
    
    [self.fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make_left_equalTo(self.styleLabel);
        make_top_equalTo(self.styleLabel.mas_bottom).offset(8.0);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make_left_equalTo(self.avatarImageView);
        make_height_equalTo(ONE_PIXEL);
        make.bottom.right.mas_equalTo(self.contentView);
    }];
}

#pragma mark - Getters

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImageView.layer.masksToBounds = YES;
    }
    return _backgroundImageView;
}

- (UIVisualEffectView *)blurView {
    if (!_blurView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
        _blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    }
    return _blurView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 30.0;
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kAppFont(16.0);
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel *)styleLabel {
    if (!_styleLabel) {
        _styleLabel = [[UILabel alloc] init];
        _styleLabel.font = kAppFont(13.0);
        _styleLabel.textColor = [UIColor whiteColor];
    }
    return _styleLabel;
}

- (UILabel *)fansLabel {
    if (!_fansLabel) {
        _fansLabel = [[UILabel alloc] init];
        _fansLabel.font = kAppFont(13.0);
        _fansLabel.textColor = [UIColor whiteColor];
    }
    return _fansLabel;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor zenLineColor];
    }
    return _bottomLineView;
}

@end

@implementation ZenArtistHeaderRow

- (void)updateCell:(ZenArtistHeaderRowCell *)cell indexPath:(NSIndexPath *)indexPath {
    [super updateCell:cell indexPath:indexPath];
    [cell.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:self.model.picture] placeholderImage:[UIImage imageNamed:@"cover"]];
    [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.model.picture] placeholderImage:[UIImage imageNamed:@"cover"]];
    cell.nameLabel.text = self.model.name;
    cell.styleLabel.attributedText = [self styleAttributedString];
    cell.fansLabel.attributedText = [self fansAttributedString];
}

- (NSAttributedString *)styleAttributedString {
    NSArray *components = [self.model.style componentsSeparatedByString:@":"];
    if (components.count == 2) {
        NSString *style = components[1];
        if (style.length > 1) {
            NSAttributedString *flag = icon_drop.typeface.font(kIconFont(12.0)).offset(-1.0).compose;
            NSAttributedString *attributedStyle = style.typeface.font(kAppFont(13.0)).compose;
            return RFAttributedString(flag, attributedStyle);
        }
    }
    return [[NSAttributedString alloc] init];
}


- (NSAttributedString *)fansAttributedString {
    if (self.model.follower.length > 0) {
        NSAttributedString *flag = icon_like.typeface.font(kIconFont(12.0)).offset(-1.0).compose;
        NSAttributedString *space = [[NSAttributedString alloc] initWithString:@" "];
        NSAttributedString *fans = self.model.follower.typeface.font(kAppFont(13.0)).compose;
        return RFAttributedString(flag, space, fans);
    }
    return [[NSAttributedString alloc] init];
}

- (CGFloat)cellHeight {
    return 102.0 + RFStatusBarHeight + RFNavigationBarHeight;
}

@end
