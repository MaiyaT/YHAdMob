//
//  BBXRegex.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/11.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "BBXRegex.h"

@implementation BBXRegex

/**
 *  正则
 */
+ (BOOL)regexString:(NSString*)stringToSearch withRegex:(NSString*)regexString
{
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    return [regex evaluateWithObject:stringToSearch];
}

/**
 *  正则替换字符串
 */
+(NSString*)replaceRegexPatternStr:(NSString*)regexPattern withReplacedStr:(NSMutableString*)str withPlaceStr:(NSString*)pstr
{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern options:0 error:nil];
    [regex replaceMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:pstr];
    return str;
}


@end
