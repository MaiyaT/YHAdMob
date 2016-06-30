//
//  UIColor+BBXApp.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/25.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


@interface UIColor (BBXApp)


/** 主题的颜色 按钮颜色*/
+ (UIColor *)bbxThemeColor;

/** 按下去的颜色*/
+ (UIColor *)bbxThemeDownColor;






/** 分割线 描边的颜色*/
+ (UIColor *)bbxBorderAndSepartionLineColor;

/** 背景的颜色 f5f5f5*/
+ (UIColor *)bbxBackgroundColor;

/** 深背景色 f0f0f0*/
+ (UIColor *)bbxBackgroundDarkColor;

/** 注释说明 b1b3b6*/
+ (UIColor *)bbxTextNoteColor;

/** 正文 94959a*/
+ (UIColor *)bbxTextBodyColor;

/** 标题颜色 313438*/
+ (UIColor *)bbxTextHeadTitleColor;

/** 副标题颜色  6a6a71*/
+ (UIColor *)bbxTextHeadSubTitleColor;

/** 可点击 链接文字 按钮文字 169bdb*/
+ (UIColor *)bbxTextLinkNorColor;

/** 可点击文字之后的颜色 0d87c2*/
+ (UIColor *)bbxTextLinkSelectColor;

/** 星星的颜色*/
+(UIColor *)bbxStarColor;

/** 16进制颜色转换*/
+ (UIColor *)colorWithHexString: (NSString *)color;

/** 随机颜色*/
+ (UIColor *)bbxRandomColor;

/** 颜色绘制成10*10的image*/
- (UIImage *)drawImageWithColor;

+ (UIColor *)bbxYeallowColor;

+ (UIColor *)bbxBlackColor;

+ (UIColor *)bbxLightBlackColor;

+ (UIColor *)bbxBlueColor;


@end
