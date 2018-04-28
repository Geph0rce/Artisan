//
//  ZenTableHeaderRow.h
//  Artisan
//
//  Created by qianjie on 2018/4/28.
//  Copyright © 2018 Zen. All rights reserved.
//

#import <RFCommonUI/RFCommonUI.h>

@interface ZenTableHeaderRow : RFTableRow

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) UIEdgeInsets padding;

@end
