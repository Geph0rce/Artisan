//
//  ZenMacros.h
//  Zen
//
//  Created by roger on 13-8-5.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

// Fonts
#define kZenFont19 [UIFont fontWithName:@"FZLTHK--GBK1-0" size:19.0f]
#define kZenFont18 [UIFont fontWithName:@"FZLTHK--GBK1-0" size:18.0f]
#define kZenFont17 [UIFont fontWithName:@"FZLTHK--GBK1-0" size:17.0f]
#define kZenFont16 [UIFont fontWithName:@"FZLTHK--GBK1-0" size:16.0f]
#define kZenFont15 [UIFont fontWithName:@"FZLTHK--GBK1-0" size:15.0f]
#define kZenFont14 [UIFont fontWithName:@"FZLTHK--GBK1-0" size:14.0f]
#define kZenFont13 [UIFont fontWithName:@"FZLTHK--GBK1-0" size:13.0f]
#define kZenFont10 [UIFont fontWithName:@"FZLTHK--GBK1-0" size:10.0f]


// Color Stuff
#define CGColorConvert(value)  (value/255.0f)
#define ZenColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define ZenColorFromRGBA(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:0.8]

#define kZenNightMode NO

#define kZenBackgroundColorDaytime ZenColorFromRGB(0xfcfcfc)
#define kZenBackgroundColorNight   ZenColorFromRGB(0x1f1f1f)
#define kZenHighlightDaytime ZenColorFromRGB(0xdfdfdf)
#define kZenHighlightNight ZenColorFromRGB(0x1f2023) //ZenColorFromRGB(0x080808)

#define kZenMainFontColorDaytime [UIColor blackColor]
#define kZenMainFontColorNight  ZenColorFromRGB(0x798492)//ZenColorFromRGB(0xa0a0a0)


#define kZenBackgroundColor (kZenNightMode? kZenBackgroundColorNight : kZenBackgroundColorDaytime)
#define kZenMainFontColor (kZenNightMode? kZenMainFontColorNight : kZenMainFontColorDaytime)
//#define kZenMainColor ZenColorFromRGB(0xfcfcfc)
#define kZenHighlightColor (kZenNightMode? kZenHighlightNight : kZenHighlightDaytime)

#define kZenBorderColor [UIColor colorWithPatternImage:[UIImage imageNamed:@"dot_border"]]

#define kZenAppID @"928799039"


//iOS Version
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)
// Other things

#define kZenDeviceiPad (UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom])

#define kZenUserInfo @"ZenUserInfo"
#define kZenDefaultFidKey       @"ZenDefaultFidKey"
#define kZenDefaultBoardNameKey @"ZenDefaultBoardNameKey"
