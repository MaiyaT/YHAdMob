//
//  UITextField+DatePicker.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/26.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "UITextField+DatePicker.h"
#import "NSDate+BBX.h"
#import "NSString+BBX.h"
#import "UIColor+BBXApp.h"

@implementation UITextField (DatePicker)

-(void)appendDatePickerWithMode:(UIDatePickerMode)mode
{
    self.inputView = nil;
    self.inputAccessoryView = nil;
    
    UIDatePicker * picker = [UIDatePicker new];
    picker.backgroundColor = [UIColor whiteColor];
    
    picker.minimumDate = [[NSDate alloc] init];
    
    picker.maximumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:60*60*24*30*3];
    
    picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    picker.datePickerMode = mode;
    
    if(![self.text isEqualToString:@""])
    {
        NSDate * selectDate = [self.text changeToDateWithoutSecond];
        picker.date = selectDate;
    }
    
    self.inputView = picker;
    
    
    //2
    //创建工具条
    UIToolbar *toolbar=[[UIToolbar alloc]init];
    //设置工具条的颜色
    toolbar.barTintColor=[UIColor bbxBackgroundColor];
    //设置工具条的frame
    toolbar.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame), 44);
    
    UIBarButtonItem *item0=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pickerDateCancel) ];
    
    UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(pickerDateSubmit)];
    
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolbar.items = @[item0, item2, item1];
    
    self.inputAccessoryView = toolbar;
}

- (void)pickerDateCancel
{
    [self resignFirstResponder];
}

- (void)pickerDateSubmit
{
    [self resignFirstResponder];
    
    UIDatePicker * pickerV = (UIDatePicker *)self.inputView;
    if([pickerV isKindOfClass:[UIDatePicker class]])
    {
        self.text = [pickerV.date descriptionWthoutSecond];
    }
}


@end
