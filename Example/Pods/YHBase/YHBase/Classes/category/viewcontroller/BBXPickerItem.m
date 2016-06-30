//
//  BBXPickerItem.m
//  BangBangXing
//
//  Created by 林宁宁 on 16/1/12.
//  Copyright © 2016年 蓝海(福建)信息科技有限公司. All rights reserved.
//

#import "BBXPickerItem.h"

@implementation BBXPickerItem

-(instancetype)initWithTitle:(NSString *)title andPickerList:(NSArray *)list andPickerSelectTitle:(NSString *)selectTitle
{
    self = [super init];
    if(self)
    {
        self.pickerDataList = [NSMutableArray arrayWithArray:list];
        self.pickerTitle = title;
        self.pickerSelectTitle = selectTitle;
    }
    return self;
}


-(instancetype)initWithTitle:(NSString *)title andPickerList:(NSArray *)list andPickerSelectItem:(id)selectItem
{
    self = [super init];
    if(self)
    {
        self.pickerDataList = [NSMutableArray arrayWithArray:list];
        self.pickerTitle = title;
        self.pickerSelectItem = selectItem;
    }
    return self;
}

@end
