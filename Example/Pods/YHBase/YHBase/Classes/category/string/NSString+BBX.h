//
//  NSString+BBX.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/26.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BBX)



- (BOOL)containStr:(NSString *)str;

- (NSString *)md5;

- (NSString *)urlencode;

//- (BOOL)isEmptyStr;
//
//- (NSString *)nonEmptyStr;

/** 转化成日期*/
- (NSDate *)changeToDate;

- (NSDate *)changeToDateOnlyDay;


- (NSDate *)changeToDateWithHourAndMinutes;


-(NSDate *)changeToDateWithoutSecond;


-(NSUInteger)lengthUnicode;

- (NSString *)subStringUnicodeIndex:(NSInteger)toIndex;

-(NSUInteger)lengthUnicode1;

-(NSUInteger)lengthUTF8;




- (NSString *)encryptWithKeyWord:(NSString *)keyword andKeyOther:(NSString *)keyword2;
- (NSString *)decryptWithKeyWord:(NSString *)keyword andKeyOther:(NSString *)keyword2;

@end
