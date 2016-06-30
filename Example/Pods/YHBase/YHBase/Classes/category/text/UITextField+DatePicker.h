//
//  UITextField+DatePicker.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/26.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (DatePicker)

/** 点击弹出时间选择器*/
- (void)appendDatePickerWithMode:(UIDatePickerMode)mode;

@end
