//
//  NSDateFormatter+BBX.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/26.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "NSDateFormatter+BBX.h"

@implementation NSDateFormatter (BBX)

+ (id)dateFormatter
{
    return [[self alloc] init];
}

+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)defaultDateFormatter
{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (id)defaultDateFormatterWithoutSecond
{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm"];
}

+ (id)defaultDateFormatterOnlyDay
{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd"];
}

@end
