//
//  UITextField+NumPicker.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/26.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 数量选择的*/
@interface UITextField (NumPicker)<UIPickerViewDelegate,UIPickerViewDataSource>

/** 点击弹出数量选择器*/
- (void)appendNumPicker;

@end
