//
//  UITextField+MultiPicker.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/4.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBXPickerItem.h"

@class BBXDatePickerItem;

/** 多个数据选择的*/
@interface UITextField (MultiPicker)<UIPickerViewDelegate,UIPickerViewDataSource>

/** 这个里面的数据是 BBXPickerItem 类型*/
@property (retain, nonatomic) NSArray * dataList;

/** 选择时间*/
@property (retain, nonatomic) NSNumber * isDatePicker;

/** 弹出框的类型 0是正常 1只有月日 2是有现在和接送机 3有现在没有接送机  4有现在没有接送机 有用车时长选择   5.只有时 分*/
@property (retain, nonatomic) NSNumber * pickerMode;

/** 选中的是什么*/
@property (retain, nonatomic) BBXDatePickerItem * pickerDateSelect;

/** 点击完成之后  BBXPickerItem 类型*/
@property (strong, nonatomic) void(^pickerFinishBlock)(id selectItems);

/**
 *  分钟显示的大小 是五分钟
 */
@property (retain, nonatomic) NSNumber * minuteSizeIsFive;

/** 当期选中的选项*/
//@property (retain, nonatomic) NSArray * currentSelectItems;


/** 点击弹出数量选择器*/
- (void)appendMultiPickerWithDataList:(NSArray *)dataList andFinishBlock:(void(^)(NSArray * selectItems))pickerFinishBlock;


/** 点击弹出数量选择器*/
- (void)appendMultiPickerWithDataList:(NSArray *)dataList andAlertTilte:(NSString *)alertTitle andFinishBlock:(void(^)(NSArray * selectItems))pickerFinishBlock;


/** 点击弹出日期选择器  mode  0是正常 1只有月日 2是有现在和接送机 3有现在没有接送机*/
- (void)appendDatePickerFinishBlock:(void(^)(id selectItem))pickerFinishBlock andMode:(NSNumber *)mode andPickerBottomV:(UIView *)pickerBottomV;


#pragma mark - 时间



@end






@interface BBXDatePickerItem : NSObject

@property (nonatomic, copy) NSString * pickerCurrentYear;
@property (nonatomic, copy) NSString * pickerYear;
@property (nonatomic, copy) NSString * pickerMonthAndDay;
@property (nonatomic, copy) NSString * pickerHour;
@property (nonatomic, copy) NSString * pickerMinute;

@end

