//
//  NSDate+BBX.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/26.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "NSDate+BBX.h"
#import "NSDateFormatter+BBX.h"
#import "NSString+BBX.h"


@implementation NSDate (BBX)


/*距离当前的时间间隔描述*/
- (NSString *)descriptionTimeIntervalSinceNow
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return @"1分钟内";
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60];
    } else if (timeInterval < 86400) {
        return [NSString stringWithFormat:@"%.f小时前", timeInterval / 3600];
    } else if (timeInterval < 2592000) {//30天内
        return [NSString stringWithFormat:@"%.f天前", timeInterval / 86400];
    } else if (timeInterval < 31536000) {//30天至1年内
        NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"M月d日"];
        return [dateFormatter stringFromDate:self];
    } else {
        return [NSString stringWithFormat:@"%.f年前", timeInterval / 31536000];
    }
}

/**
 *  距离当前的时间间隔描述
 */
- (NSString *)descriptionTimeIntervalSinceNowWhitIn12Hours
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return @"1分钟内";
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60];
    } else if (timeInterval < 60*60*12) {
        return [NSString stringWithFormat:@"%.f小时前", timeInterval / 3600];
    } else
    {
        return [self descriptionWthoutSecond];
    }
}

/**
 *  距离当前的时间间隔描述 没有年份
 */
- (NSString *)descriptionTimeIntervalSinceNowWhitIn12HoursWithOutYear
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return @"1分钟内";
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60];
    } else if (timeInterval < 60*60*12) {
        return [NSString stringWithFormat:@"%.f小时前", timeInterval / 3600];
    } else
    {
        NSDateFormatter * dateFormater = [NSDateFormatter dateFormatterWithFormat:@"MM-dd HH:mm"];
        
        return [dateFormater stringFromDate:self];
    }
}


/*精确到分钟的日期描述*/
- (NSString *)descriptionMinute
{
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
    
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    if ([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] < 86400 * 7) {//间隔一周内
        [dateFormatter setDateFormat:@"EEEE ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else {//以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd ah:mm"];
        return [dateFormatter stringFromDate:self];
    }
}

///** 今天 昨天 本周 日期*/
//- (NSString *)descriptionOldDay
//{
//    
//    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
//    if (timeInterval < 60) {
//        return @"1分钟内";
//    } else if (timeInterval < 3600) {
//        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60];
//    } else if (timeInterval < 86400) {
//        return [NSString stringWithFormat:@"%.f小时前", timeInterval / 3600];
//    } else if (timeInterval < 2592000) {//30天内
//        return [NSString stringWithFormat:@"%.f天前", timeInterval / 86400];
//    } else if (timeInterval < 31536000) {//30天至1年内
//        NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"M月d日"];
//        return [dateFormatter stringFromDate:self];
//    } else {
//        return [NSString stringWithFormat:@"%.f年前", timeInterval / 31536000];
//    }
//    
//}


-(NSString *)description
{
    NSDateFormatter * dateFormater = [NSDateFormatter defaultDateFormatter];
    
    return [dateFormater stringFromDate:self];
}

-(NSString *)descriptionWthoutSecond
{
    NSDateFormatter * dateFormater = [NSDateFormatter defaultDateFormatterWithoutSecond];
    
    return [dateFormater stringFromDate:self];
}

-(NSString *)descriptionOnlyday
{
    NSDateFormatter * dateFormater = [NSDateFormatter defaultDateFormatterOnlyDay];
    
    return [dateFormater stringFromDate:self];
}



/**
 *  多少分钟之后的时间
 *
 *  @param interval 分钟
 *
 *  @return 时间
 */
- (NSDate *)dateSinceAfterMinTime:(NSTimeInterval)minInterval
{
    return [self dateByAddingTimeInterval:minInterval*60];
}

-(NSInteger)dayIntervalSinceNow
{
    NSDateFormatter * dateFormater = [NSDateFormatter defaultDateFormatterOnlyDay];
    
    NSString * dateOnlyDayStr = [dateFormater stringFromDate:[NSDate date]];
    NSDate * dateOnlyDay = [dateOnlyDayStr changeToDateOnlyDay];
    
    if(!dateOnlyDay)
    {
        return 0;
    }
    
    double interval = (double)[self timeIntervalSinceDate:dateOnlyDay];
    //相差多少天
    NSInteger disDay = floor(interval/(24*60*60));
    disDay = MAX(0, disDay);
    
    return disDay;
}

@end
