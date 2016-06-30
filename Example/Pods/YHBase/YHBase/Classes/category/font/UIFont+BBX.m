//
//  UIFont+BBX.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/4.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "UIFont+BBX.h"
#import "MacroAppInfo.h"


@implementation UIFont (BBX)

+ (UIFont *)defaultButtonFont
{
    return [UIFont systemFontOfSize:[self fontSize:14]];
}

+(UIFont *)bbxSystemFont:(float)size
{
    return [UIFont systemFontOfSize:[self fontSize:size]];
}

+ (CGFloat)fontSize:(CGFloat)oldFont
{
    if([MacroAppInfo isiPhone6P])
    {
        return oldFont;
    }
    return oldFont;
}

@end
