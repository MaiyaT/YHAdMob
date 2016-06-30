//
//  Common.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/3.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define StringInt(i)    [NSString stringWithFormat:@"%d",(int)i]

#define StringString(s1,s2) [NSString stringWithFormat:@"%@%@",s1,s2]

@interface BBXCommon : NSObject

+(NSString *)nonEmptyStr:(NSString *)str;

+(BOOL)isEmptyStr:(NSString *)str;

/**
 *  电话号码裁剪
 */
+ (NSString *)phoneNumShowWithStr:(NSString *)phoneNum;


/**
 *  司机的车牌号信息
 */
+ (NSString *)carNumShowWithStr:(NSString *)carNO;


@end
