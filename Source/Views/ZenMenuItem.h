//
//  ZenMenuItem.h
//  Zen
//
//  Created by roger qian on 13-3-29.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZenMenuItemStyleExpandable,
    ZenMenuItemStylePerson,
    ZenMenuItemStyleSettings,
    ZenMenuItemStyleArchived,
    ZenMenuItemStyleHotSongs,
    ZenMenuItemStyleHotArtists,
    ZenMenuItemStyleDownload
}ZenMenuItemStyle;

typedef enum {
    ZenMenuItemStatusNormal,
    ZenMenuItemStatusExpanded
}ZenMenuItemStatus;


@protocol ZenMenuItemDelegate;

@interface ZenMenuItem : UIView
{
@public
    __weak NSObject <ZenMenuItemDelegate> *_delegate;
    ZenMenuItemStatus _status;
    ZenMenuItemStyle _style;
                                     
@private
    UIButton *_leftBtn;
    UIButton *_rightBtn;
    
}

@property (nonatomic, weak) NSObject <ZenMenuItemDelegate> *delegate;
@property (nonatomic, assign) ZenMenuItemStatus status;
@property (nonatomic, assign) ZenMenuItemStyle style;

- (void)setImage:(UIImage *)image;
- (void)setTitle:(NSString *)text;
- (void)setColor:(UIColor *)color highlight:(UIColor *)hl;
- (void)badge:(BOOL)flag;

@end


@protocol ZenMenuItemDelegate <NSObject>

@optional
- (void)menuItemClicked:(ZenMenuItem *)item;

@end