//
//  NSDateFormatter+BBX.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/26.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (BBX)

+ (id)dateFormatter;
+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/

+ (id)defaultDateFormatterWithoutSecond;

+ (id)defaultDateFormatterOnlyDay;

@end
