//
//  BBXPickerItem.h
//  BangBangXing
//
//  Created by 林宁宁 on 16/1/12.
//  Copyright © 2016年 蓝海(福建)信息科技有限公司. All rights reserved.
//

#import "BaseObject.h"

@interface BBXPickerItem : BaseObject

//类型
@property (copy, nonatomic)     NSString * pickerTitle;
@property (retain, nonatomic)   NSMutableArray * pickerDataList;
@property (copy, nonatomic)     NSString * pickerSelectTitle;

@property (weak, nonatomic)     id pickerSelectItem;

/**
 *  获取标题
 */
@property (copy, nonatomic) NSString *(^getPickerTitleBlock)(NSInteger index);

- (instancetype)initWithTitle:(NSString *)title andPickerList:(NSArray *)list andPickerSelectTitle:(NSString *)selectTitle;


- (instancetype)initWithTitle:(NSString *)title andPickerList:(NSArray *)list andPickerSelectItem:(id)selectItem;

@end