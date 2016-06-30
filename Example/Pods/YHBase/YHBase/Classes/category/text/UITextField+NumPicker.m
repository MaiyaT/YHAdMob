//
//  UITextField+NumPicker.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/26.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "UITextField+NumPicker.h"

@implementation UITextField (NumPicker)

-(void)appendNumPicker
{
    
    self.inputView = nil;
    self.inputAccessoryView = nil;

    UIPickerView * pickerV = [UIPickerView new];
    pickerV.backgroundColor = [UIColor whiteColor];
    pickerV.dataSource = self;
    pickerV.delegate = self;
    
    self.inputView = pickerV;
    
    if(![self.text isEqualToString:@""])
    {
        NSString * numP = [self.text stringByReplacingOccurrencesOfString:@"人" withString:@""];
        [pickerV selectRow:[numP intValue]-1 inComponent:0 animated:YES];
    }
    
    //2
    //创建工具条
    UIToolbar *toolbar=[[UIToolbar alloc]init];
    //设置工具条的颜色
    toolbar.barTintColor=[UIColor brownColor];
    //设置工具条的frame
    toolbar.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame), 44);
    
    UIBarButtonItem *item0=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pickerNumCancel) ];
    
    UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(pickerNumSubmit)];
    
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolbar.items = @[item0, item2, item1];
    
    self.inputAccessoryView = toolbar;
}

- (void)pickerNumCancel
{
    [self resignFirstResponder];
}

- (void)pickerNumSubmit
{
    [self resignFirstResponder];
    
    UIPickerView * pickerV = (UIPickerView *)self.inputView;
    if([pickerV isKindOfClass:[UIPickerView class]])
    {
        NSInteger selectIndex = [pickerV selectedRowInComponent:0];
        self.text = [NSString stringWithFormat:@"%d人",(int)selectIndex+1];
    }
}

#pragma mark -


#pragma mark - picker view的代理

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 100;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d",(int)row+1];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%d",(int)row+1);
}
    
@end
