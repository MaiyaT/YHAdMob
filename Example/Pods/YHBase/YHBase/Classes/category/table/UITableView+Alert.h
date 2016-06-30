//
//  UITableView+Alert.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/21.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 无数据的时候提醒*/
@interface UITableView (Alert)

/** 无订单的时候提醒的背景视图*/
- (void)alertNoneOrder;

/**
 *  无数据提示
 */
- (void)alertNoneData;

/** 清除提醒的视图*/
- (void)cleanAlertV;

/** 正在加载中的提示*/
- (void)alertLoadingWithTitle:(NSString *)alertTitle;


/**
 *  表格还未显示 判断是否加载过数据
 */
@property (retain, nonatomic) NSNumber * isLoaded;


@end
