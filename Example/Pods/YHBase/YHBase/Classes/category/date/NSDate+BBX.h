//
//  NSDate+BBX.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/26.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BBX)


/** 距离当前的时间间隔描述*/
- (NSString *)descriptionTimeIntervalSinceNow;

/**
 *  距离当前的时间间隔描述 12个小时内的描述 超过十二个小时用日期
 */
- (NSString *)descriptionTimeIntervalSinceNowWhitIn12Hours;


/**
 *  距离当前的时间间隔描述 12个小时内的描述 超过十二个小时用日期 没有年份
 */
- (NSString *)descriptionTimeIntervalSinceNowWhitIn12HoursWithOutYear;


/** 精确到分钟的日期描述*/
- (NSString *)descriptionMinute;

- (NSString *)description;

/** 今天 昨天 本周 日期*/
//- (NSString *)descriptionOldDay;

-(NSString *)descriptionWthoutSecond;


-(NSString *)descriptionOnlyday;

/**
 *  距离当前时间 相差几天
 *
 *  @return 天数
 */
- (NSInteger)dayIntervalSinceNow;

/**
 *  多少分钟之后的时间
 *
 *  @param interval 分钟
 *
 *  @return 时间
 */
- (NSDate *)dateSinceAfterMinTime:(NSTimeInterval)minInterval;

@end
