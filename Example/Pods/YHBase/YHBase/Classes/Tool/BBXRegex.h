//
//  BBXRegex.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/11.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define REGEX_QQ @"^[0-9]{5,13}"
#define REGEX_NUM_CHAR_4_23     @"[0-9a-zA-Z]{4,23}"   //4-23位字母和数字
#define REGEX_NUM_CHAR          @"[0-9a-zA-Z]"   //字母和数字
#define REGEX_NUM_CHAR_4_6      @"[0-9a-zA-Z]{4,6}"   //字母和数字
#define REGEX_USER_NAME_LIMIT @"^.{3,10}$"      //3-10任意字符
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"   //3-10个数字字母
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)"

//现在只有13、15和18开头的11位手机号码。以1开头，第2位数字为3或5或8，后面接9位数字
//#define REGEX_PHONE     @"^[1][34578][0-9]{9}$"
#define REGEX_PHONE     @"^[1][0-9]{10}$"

@interface BBXRegex : NSObject

//正则替换字符串
+(NSString*)replaceRegexPatternStr:(NSString*)regexPattern withReplacedStr:(NSMutableString*)str withPlaceStr:(NSString*)pstr;

/**
 *  正则匹配
 */
+ (BOOL)regexString:(NSString*)stringToSearch withRegex:(NSString*)regexString;

@end
