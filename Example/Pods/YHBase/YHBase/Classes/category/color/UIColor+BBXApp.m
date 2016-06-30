//
//  UIColor+BBXApp.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/25.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "UIColor+BBXApp.h"
#import "AppConfigNote.h"


@implementation UIColor (BBXApp)


+(UIColor *)bbxThemeColor
{
//    return [self colorWithHexString:@"00aaee"];//[self colorWithHexString:@"169bdb"];
    
    return [self colorWithHexString:[AppConfigNote shareManager].noteAPPThemeColor];
}

+ (UIColor *)bbxThemeDownColor
{
    return [self colorWithHexString:@"0d87c2"];
}

+(UIColor *)bbxBackgroundColor
{
    return [self colorWithHexString:@"f5f5f5"];
}

/** 深背景色 f0f0f0*/
+ (UIColor *)bbxBackgroundDarkColor
{
    return [self colorWithHexString:@"f0f0f0"];
}


+(UIColor *)bbxBorderAndSepartionLineColor
{
    return [self colorWithHexString:@"dadada"];
}

+(UIColor *)bbxTextNoteColor
{
    return [self colorWithHexString:@"b1b3b6"];
}

+(UIColor *)bbxTextBodyColor
{
    return [self colorWithHexString:@"94959a"];
}

+(UIColor *)bbxTextHeadTitleColor
{
    return [self colorWithHexString:@"313438"];
}

+(UIColor *)bbxTextHeadSubTitleColor
{
    return [self colorWithHexString:@"6a6a71"];
}

+ (UIColor *)bbxBlackColor
{
    return [self colorWithHexString:@"1a1a1a"];
}


+ (UIColor *)bbxLightBlackColor
{
    return [self colorWithHexString:@"898989"];
}

+ (UIColor *)bbxBlueColor
{
    return [self colorWithHexString:@"00aaff"];
}


+(UIColor *)bbxTextLinkNorColor
{
    return [self colorWithHexString:@"169bdb"];
}

+(UIColor *)bbxTextLinkSelectColor
{
    return [self colorWithHexString:@"0d87c2"];
}

+(UIColor *)bbxStarColor
{
    return [self colorWithHexString:@"ffb84d"];
}

+ (UIColor *)bbxYeallowColor
{
    return RGB(255, 238, 50);
}

/** 随机颜色*/
+ (UIColor *)bbxRandomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );               //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
//    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
//    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
//    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
//    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

#pragma mark - 

- (UIImage *)drawImageWithColor
{
    CGSize imageSize = CGSizeMake(10, 10);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [self set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return pressedColorImg;
}


+ (UIColor *)colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}



@end
