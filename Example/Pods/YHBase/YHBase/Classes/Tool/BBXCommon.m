//
//  Common.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/3.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "BBXCommon.h"

@implementation BBXCommon

+(NSString *)nonEmptyStr:(NSString *)str
{
    if(str && [str isKindOfClass:[NSString class]])
    {
        return str;
    }
    else if ([str isKindOfClass:[NSNumber class]])
    {
        NSNumber * strNum = (NSNumber *)str;
        
        return [strNum stringValue];
    }
    else if ([str isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    
    return @"";
}

+(BOOL)isEmptyStr:(NSString *)str
{
    NSString * str11 = [self nonEmptyStr:str];
    
    return [str11 isEqualToString:@""];
}

+ (NSString *)phoneNumShowWithStr:(NSString *)phoneNum
{
    if(phoneNum.length > 7)
    {
        return [phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    else
    {
        return phoneNum;
    }
}

/**
 *  司机的车牌号信息
 */
+ (NSString *)carNumShowWithStr:(NSString *)carNO
{
    if(carNO.length > 4)
    {
        return [carNO stringByReplacingCharactersInRange:NSMakeRange(1, 3) withString:@"**"];
    }
    else
    {
        return carNO;
    }
}

@end
