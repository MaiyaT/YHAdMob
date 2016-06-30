//
//  UITextField+MultiPicker.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/4.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "UITextField+MultiPicker.h"
#import <objc/runtime.h>
#import "BBXCommon.h"
#import "NSDate+BBX.h"
#import "NSString+BBX.h"
#import "UIColor+BBXApp.h"
#import "UIFont+BBX.h"


@implementation UITextField (MultiPicker)


-(void)setPickerDateSelect:(BBXDatePickerItem *)pickerDateSelect
{
    objc_setAssociatedObject(self, @selector(pickerDateSelect), pickerDateSelect, OBJC_ASSOCIATION_RETAIN);
}

-(BBXDatePickerItem *)pickerDateSelect
{
    return objc_getAssociatedObject(self, @selector(pickerDateSelect));
}

-(void)setIsDatePicker:(NSNumber *)isDatePicker
{
    objc_setAssociatedObject(self, @selector(isDatePicker), isDatePicker, OBJC_ASSOCIATION_RETAIN);
}

-(NSNumber *)isDatePicker
{
    return objc_getAssociatedObject(self, @selector(isDatePicker));
}


-(void)setPickerMode:(NSNumber *)pickerMode
{
    objc_setAssociatedObject(self, @selector(pickerMode), pickerMode, OBJC_ASSOCIATION_RETAIN);
}

-(NSNumber *)pickerMode
{
    return objc_getAssociatedObject(self, @selector(pickerMode));
}


-(void)setMinuteSizeIsFive:(NSNumber *)minuteSizeIsFive
{
    objc_setAssociatedObject(self, @selector(minuteSizeIsFive), minuteSizeIsFive, OBJC_ASSOCIATION_RETAIN);
}

-(NSNumber *)minuteSizeIsFive
{
    return objc_getAssociatedObject(self, @selector(minuteSizeIsFive));
}

- (void)setDataList:(NSArray *)dataList
{
    objc_setAssociatedObject(self, @selector(dataList), dataList, OBJC_ASSOCIATION_RETAIN);
}

-(NSArray *)dataList
{
    return objc_getAssociatedObject(self, @selector(dataList));
}

-(void)setPickerFinishBlock:(void (^)(id))pickerFinishBlock
{
    objc_setAssociatedObject(self, @selector(pickerFinishBlock), pickerFinishBlock, OBJC_ASSOCIATION_RETAIN);
}

-(void (^)(id))pickerFinishBlock
{
    return objc_getAssociatedObject(self, @selector(pickerFinishBlock));
}

//-(void)setCurrentSelectItems:(NSArray *)currentSelectItems
//{
//    objc_setAssociatedObject(self, @selector(currentSelectItems), currentSelectItems, OBJC_ASSOCIATION_RETAIN);
//}
//
//-(NSArray *)currentSelectItems
//{
//    return objc_getAssociatedObject(self, @selector(currentSelectItems));
//}


-(void)appendDatePickerFinishBlock:(void (^)(id))pickerFinishBlock andMode:(NSNumber *)mode andPickerBottomV:(UIView *)pickerBottomV
{
    self.pickerMode = mode;
    
    self.isDatePicker = @(YES);
    self.pickerFinishBlock = pickerFinishBlock;
    
    //    if(self.minuteSize == 0)
    //    {
    //
    //    }
    
    self.inputView = nil;
    self.inputAccessoryView = nil;
    
    UIPickerView * pickerV = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 200)];
    pickerV.backgroundColor = [UIColor whiteColor];
    pickerV.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    pickerV.dataSource = self;
    pickerV.delegate = self;
    
    if(pickerBottomV)
    {
        UIView * inputV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 300)];
        [inputV addSubview:pickerV];
        
        pickerBottomV.frame = CGRectMake(0, CGRectGetMaxY(pickerV.frame), CGRectGetWidth(self.frame), CGRectGetHeight(inputV.frame) - CGRectGetHeight(pickerV.frame));
        pickerBottomV.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [inputV addSubview:pickerBottomV];
        
        self.inputView = inputV;
    }
    else
    {
        self.inputView = pickerV;
    }
    
    
    NSString * contentStr = self.text;
    if([contentStr containStr:@"小时"])
    {
        //裁减掉小时的信息 算出时间
        NSRange spaceRange = [contentStr rangeOfString:@"  " options:NSBackwardsSearch];
        
        contentStr = [contentStr substringToIndex:spaceRange.location];
    }
    
    //当前的时间
    NSDate * currentDate;
    if([contentStr isEqualToString:@""])
    {
        currentDate = [[NSDate date] dateSinceAfterMinTime:20];
    }
    else
    {
        currentDate = [contentStr changeToDateWithoutSecond];
        
        if(!currentDate)
        {
            currentDate = [contentStr changeToDateOnlyDay];
        }
        
        if(!currentDate)
        {
            currentDate = [contentStr changeToDateWithHourAndMinutes];
        }
        
        if(!currentDate)
        {
            currentDate = [[NSDate date] dateSinceAfterMinTime:20];
        }
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmm"];
    NSString *dateString = [formatter stringFromDate:currentDate];
    
    
    //设置默认初始的状态
    self.pickerDateSelect = [[BBXDatePickerItem alloc] init];
    
    self.pickerDateSelect.pickerCurrentYear = [dateString substringWithRange:NSMakeRange(0, 4)];
    
    self.pickerDateSelect.pickerYear = [dateString substringWithRange:NSMakeRange(0, 4)];
    self.pickerDateSelect.pickerMonthAndDay = [NSString stringWithFormat:@"%@月%@日",[dateString substringWithRange:NSMakeRange(4, 2)],[dateString substringWithRange:NSMakeRange(6, 2)]];
    self.pickerDateSelect.pickerHour  = [dateString substringWithRange:NSMakeRange(8, 2)];
    
    if([self.minuteSizeIsFive boolValue])
    {
        NSString * minutes = [dateString substringWithRange:NSMakeRange(10, 2)];
        minutes = [NSString stringWithFormat:@"%02d",(int)[minutes integerValue]/5];
        
        self.pickerDateSelect.pickerMinute = minutes;
    }
    else
    {
        self.pickerDateSelect.pickerMinute = [dateString substringWithRange:NSMakeRange(10, 2)];
    }
    
    if([self.pickerMode integerValue] == 5)
    {
        self.pickerDateSelect.pickerHour = [dateString substringWithRange:NSMakeRange(8, 2)];
        self.pickerDateSelect.pickerMinute = [dateString substringWithRange:NSMakeRange(10, 2)];
        
        [pickerV selectRow:[self.pickerDateSelect.pickerHour integerValue] inComponent:0 animated:YES];
        
        [pickerV selectRow:[self.pickerDateSelect.pickerMinute integerValue] inComponent:2 animated:YES];
        
    }
    else if([self.pickerMode intValue])
    {
        self.pickerDateSelect.pickerMonthAndDay = @"现在出发";
        [pickerV selectRow:([self.pickerMode intValue] == 2)?1:0 inComponent:0 animated:YES];
    }
    else if(([self.text isEqualToString:@""] && [self.pickerMode intValue] > 1) ||
       [self.text containStr:@"现在出发"])
    {
        self.pickerDateSelect.pickerMonthAndDay = @"现在出发";
        [pickerV selectRow:([self.pickerMode intValue] == 2)?1:0 inComponent:0 animated:YES];
    }
    else if ([self.text isEqualToString:@"接送机"])
    {
        self.pickerDateSelect.pickerMonthAndDay = @"接送机";
        [pickerV selectRow:0 inComponent:0 animated:YES];
    }
    else
    {
        //相差多少天
        NSInteger disDay = [currentDate dayIntervalSinceNow];
        
        if([self.pickerMode intValue] > 1)
        {
            [pickerV selectRow:([self.pickerMode intValue] == 2)?disDay+2:disDay+1 inComponent:0 animated:YES];
        }
        else
        {
            [pickerV selectRow:disDay inComponent:0 animated:YES];
        }
        
        if([self.pickerMode intValue] != 1)
        {
            [self setPikerSelectHourAndMinute:pickerV];
        }
    }
    
    
    [self creatToolBar];
}



#pragma mark - picker view的代理

-(void)appendMultiPickerWithDataList:(NSArray *)dataList andFinishBlock:(void (^)(NSArray *))pickerFinishBlock
{
    [self appendMultiPickerWithDataList:dataList andAlertTilte:nil andFinishBlock:pickerFinishBlock];
}

-(void)appendMultiPickerWithDataList:(NSArray *)dataList andAlertTilte:(NSString *)alertTitle andFinishBlock:(void (^)(NSArray *))pickerFinishBlock
{
    
    self.dataList = dataList;
    self.pickerFinishBlock = pickerFinishBlock;
    
    self.inputView = nil;
    self.inputAccessoryView = nil;
    
    UIPickerView * pickerV = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 250)];
    pickerV.backgroundColor = [UIColor whiteColor];
    pickerV.dataSource = self;
    pickerV.delegate = self;
    
    self.inputView = pickerV;
    
    
    if(alertTitle)
    {
        UILabel * labAlert = [[UILabel alloc] init];
        labAlert.text = alertTitle;
        labAlert.textAlignment = NSTextAlignmentCenter;
        labAlert.frame = CGRectMake(0, CGRectGetHeight(pickerV.frame)-20, CGRectGetWidth(pickerV.frame), 20);
        labAlert.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        labAlert.textColor = [UIColor bbxTextNoteColor];
        labAlert.font = [UIFont bbxSystemFont:11];
        [pickerV addSubview:labAlert];
    }
    
    //设置当前选中的是哪个选项
    [self.dataList enumerateObjectsUsingBlock:^(BBXPickerItem * obj, NSUInteger idx, BOOL *stop) {
        if(![BBXCommon isEmptyStr:obj.pickerSelectTitle])
        {
            if([obj.pickerDataList containsObject:obj.pickerSelectTitle])
            {
                NSInteger index = [obj.pickerDataList indexOfObject:obj.pickerSelectTitle];
                [pickerV selectRow:index inComponent:idx animated:YES];
            }
        }
    }];
    
    
    [self creatToolBar];
}

- (void)pickerNumCancel
{
    [self resignFirstResponder];
}

- (void)pickerNumSubmit
{
    [self resignFirstResponder];
    
    if(self.pickerFinishBlock)
    {
        if([self.isDatePicker boolValue])
        {
            NSString * dateStr;
            
            if([self.pickerMode integerValue] == 5)
            {
                dateStr = [NSString stringWithFormat:@"%@:%@",
                           self.pickerDateSelect.pickerHour,
                           self.pickerDateSelect.pickerMinute];
            }
            else if([self.pickerDateSelect.pickerMonthAndDay isEqualToString:@"现在出发"])
            {
                dateStr = @"现在出发";
            }
            else if([self.pickerDateSelect.pickerMonthAndDay isEqualToString:@"接送机"])
            {
                dateStr = @"接送机";
            }
            else
            {
                dateStr = [self currentDateStr];
            }
            
            self.text = dateStr;
            
            self.pickerFinishBlock(dateStr);
        }
        else
        {
            self.pickerFinishBlock(self.dataList);
        }
    }
}

#pragma mark -


#pragma mark - picker view的代理

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if([self.isDatePicker boolValue])
    {
        if([self.pickerMode intValue] == 5)
        {
            return 3;
        }
        else if([self.pickerDateSelect.pickerMonthAndDay isEqualToString:@"现在出发"]||
           [self.pickerDateSelect.pickerMonthAndDay isEqualToString:@"接送机"])
        {
            return 1;
        }
        else if ([self.pickerMode intValue] == 1)
        {
            return 1;
        }
        else if ([self.pickerMode intValue] == 2)
        {
            return 2;
        }
        return 4;
    }
    else
    {
        return self.dataList.count;
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if([self.isDatePicker boolValue])
    {
        if([self.pickerMode intValue] == 5)
        {
            if(component == 0)
            {
                return 24;
            }
            else if (component == 2)
            {
                return 60;
            }
            return 1;
        }
        
        switch (component)
        {
                //三个月的时间 现在 和 接送机
            case 0:
                if([self.pickerMode intValue] > 1)
                {
                    //                    return ([self.pickerMode intValue] == 2)?30*3+2:30*3+1;
                    return ([self.pickerMode intValue] == 2)?5+2:5+1;
                }
                else
                {
                    return 5; //30*3;
                }
                break;
                
                //24个小时
            case 1:
                return 24;
                break;
                
                //中间的冒号
            case 2:
                return 1;
                break;
                
                //分钟
            case 3:
                //                return 60;
                
                if([self.minuteSizeIsFive boolValue])
                {
                    return 12;
                }
                return 60;
                
                break;
            default:
                return 0;
                break;
        }
    }
    else
    {
        BBXPickerItem * item = self.dataList[component];
        
        return item.pickerDataList.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if([self.isDatePicker boolValue])
    {
        if([self.pickerMode intValue] == 5)
        {
            return CGRectGetWidth(self.frame)/3;
        }
        
        switch (component)
        {
                //三个月的时间
            case 0:
                return CGRectGetWidth(self.frame)*0.65;
                break;
                
                //24个小时
            case 1:
                return CGRectGetWidth(self.frame)*0.15;
                break;
                
                //中间的冒号
            case 2:
                return CGRectGetWidth(self.frame)*0.05;
                break;
                
                //分钟
            case 3:
                return CGRectGetWidth(self.frame)*0.15;
                break;
            default:
                return 0;
                break;
        }
    }
    else
    {
        return CGRectGetWidth(self.frame)/self.dataList.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 45;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    NSString * titleStr = @"";
    
    if([self.isDatePicker boolValue])
    {
        if([self.pickerMode intValue] == 5)
        {
            if(component == 1)
            {
                titleStr = @":";
            }
            else
            {
                titleStr =  [NSString stringWithFormat:@"%02d",(int)row];
            }
        }
        else
        {
        
            switch (component)
            {
                    //三个月的时间
                case 0:
                    titleStr = [self getDateStrWithCount:row];
                    break;
                    
                    //24个小时
                case 1:
                    if(row < 10)
                    {
                        titleStr =  [NSString stringWithFormat:@"0%d",(int)row];
                    }
                    else
                    {
                        titleStr =  StringInt(row);
                    }
                    break;
                    
                    //中间的冒号
                case 2:
                    titleStr =  @":";
                    break;
                    
                    //分钟
                case 3:
                    
                    if([self.minuteSizeIsFive boolValue])
                    {
                        row = row * 5;
                        if(row < 10)
                        {
                            titleStr =  [NSString stringWithFormat:@"0%d",(int)row];
                        }
                        else
                        {
                            titleStr =  StringInt(row);
                        }
                    }
                    else
                    {
                        if(row < 10)
                        {
                            titleStr =  [NSString stringWithFormat:@"0%d",(int)row];
                        }
                        else
                        {
                            titleStr =  StringInt(row);
                        }
                    }
                    
                    break;
                default:
                    break;
            }
        }
    }
    else
    {
        BBXPickerItem * item = self.dataList[component];
        
        titleStr =  item.pickerDataList[row];
    }
    
    UILabel * labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 45)];
    
    labTitle.text = titleStr;
    labTitle.textAlignment = NSTextAlignmentCenter;
    labTitle.textColor = [UIColor bbxLightBlackColor];
    labTitle.font = [UIFont systemFontOfSize:17];
    
    if([titleStr containStr:@"\n"])
    {
        labTitle.numberOfLines = 0;
        labTitle.lineBreakMode = NSLineBreakByWordWrapping;
        labTitle.font = [UIFont systemFontOfSize:16];
        
        NSRange returnRange = [titleStr rangeOfString:@"\n"];
        
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
        
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0, returnRange.location)];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:8]} range:NSMakeRange(returnRange.location, returnRange.length)];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor bbxTextHeadTitleColor]} range:NSMakeRange(0, returnRange.location)];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor bbxTextNoteColor]} range:NSMakeRange(returnRange.location, returnRange.length)];
        
        labTitle.attributedText = attStr;
    }
    
    //    [labTitle adjustsFontSizeToFitWidth];
    return labTitle;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSLog(@"%d",(int)row+1);
    if([self.isDatePicker boolValue])
    {
        NSLog(@"d");
        UIView * componentV = [pickerView viewForRow:row forComponent:component];
        
        if([componentV isKindOfClass:[UILabel class]])
        {
            UILabel * lab = (UILabel *)componentV;
            if(component == 0)
            {
                if([self.pickerMode integerValue] == 5)
                {
                    self.pickerDateSelect.pickerHour = lab.text;
                }
                else if([lab.text isEqualToString:@"现在出发"] ||
                   [lab.text isEqualToString:@"接送机"])
                {
                    self.pickerDateSelect.pickerMonthAndDay = lab.text;
                    [pickerView reloadAllComponents];
                }
                else
                {
                    if([self.pickerDateSelect.pickerMonthAndDay isEqualToString:@"现在出发"]||
                       [self.pickerDateSelect.pickerMonthAndDay isEqualToString:@"接送机"])
                    {
                        self.pickerDateSelect.pickerMonthAndDay = lab.text;
                        [pickerView reloadAllComponents];
                        
                        [self setPikerSelectHourAndMinute:pickerView];
                    }
                    else
                    {
                        self.pickerDateSelect.pickerMonthAndDay = lab.text;
                        
                        if ([lab.text containStr:@"次年"])
                        {
                            self.pickerDateSelect.pickerYear = StringInt([self.pickerDateSelect.pickerCurrentYear intValue] + 1);
                        }
                        else
                        {
                            self.pickerDateSelect.pickerYear = self.pickerDateSelect.pickerCurrentYear;
                        }
                    }
                }
                
            }
            else if (component == 1)
            {
                if([self.pickerMode integerValue] != 5)
                {
                    self.pickerDateSelect.pickerHour = lab.text;
                }
            }
            else if (component == 2)
            {
                if([self.pickerMode integerValue] == 5)
                {
                    self.pickerDateSelect.pickerMinute = lab.text;
                }
            }
            else if (component == 3)
            {
                if([self.minuteSizeIsFive boolValue])
                {
                    self.pickerDateSelect.pickerMinute = [NSString stringWithFormat:@"%02d",(int)[lab.text integerValue]/5]
                    ;
                }
                else
                {
                    self.pickerDateSelect.pickerMinute = lab.text;
                }
            }
            
            if ([self.pickerDateSelect.pickerMonthAndDay containStr:@"月"]&&
                [self.pickerDateSelect.pickerMonthAndDay containStr:@"日"] &&
                ([self.pickerMode integerValue] != 5))
            {
                NSString * currdateStr = [self currentDateStr];
                NSDate * selectDate = [currdateStr changeToDateWithoutSecond];
                if([[selectDate earlierDate:[[NSDate date] dateSinceAfterMinTime:20]] isEqualToDate:selectDate])
                {
                    //当前选中的时间比较早 所以要移动到最新的时间点
                    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                    [formatter setDateFormat:@"yyyyMMddHHmm"];
                    NSString *dateString = [formatter stringFromDate:[[NSDate date] dateSinceAfterMinTime:20]];
                    
                    self.pickerDateSelect.pickerHour  = [dateString substringWithRange:NSMakeRange(8, 2)];
                    
                    if([self.minuteSizeIsFive boolValue])
                    {
                        NSString * minutes = [dateString substringWithRange:NSMakeRange(10, 2)];
                        minutes = [NSString stringWithFormat:@"%02d",(int)[minutes integerValue]/5];
                        
                        self.pickerDateSelect.pickerMinute = minutes;
                    }else
                    {
                        self.pickerDateSelect.pickerMinute = [dateString substringWithRange:NSMakeRange(10, 2)];
                    }
                    
                    if([self.pickerMode integerValue] != 1)
                    {
                        [self setPikerSelectHourAndMinute:pickerView];
                    }
                }
            }
            
        }
        
    }
    else
    {
        BBXPickerItem * item = self.dataList[component];
        if(item.pickerDataList.count > 0)
        {
            item.pickerSelectTitle = item.pickerDataList[row];
        }
    }
}


/** 往后几天 的日期时间*/
- (NSString *)getDateStrWithCount:(NSInteger)count
{
    if([self.pickerMode intValue] == 2)
    {
        if(count == 0)
        {
            return @"接送机";
        }
        else if (count == 1)
        {
            return @"现在出发";
        }
        
        count = count - 2;
    }
    else if([self.pickerMode intValue] == 3 ||
            [self.pickerMode intValue] == 4)
    {
        if(count == 0)
        {
            return @"现在出发";
        }
        
        count = count - 1;
    }
    
    
    NSDate * afterData = [NSDate dateWithTimeIntervalSinceNow:24*60*60*count];
    
    NSString * dataStr = [afterData descriptionWthoutSecond];
    
    //    NSLog(@"%@",dataStr);
    
    NSString * part1 = [[dataStr componentsSeparatedByString:@" "] firstObject];
    NSArray * part2 = [part1 componentsSeparatedByString:@"-"];
    
    NSMutableString * strResult = [NSMutableString stringWithFormat:@"%@月%@日",part2[1],part2[2]];
    
    NSString * year = [part1 substringWithRange:NSMakeRange(0, 4)];
    
    if([self.pickerMode integerValue] != 5)
    {
        if(count == 0)
        {
            [strResult appendFormat:@"今天"];
        }
        else if (count == 1)
        {
            [strResult appendFormat:@"明天"];
        }
        else if(count == 2)
        {
            [strResult appendFormat:@"后天"];
        }
        else if (![year isEqualToString:self.pickerDateSelect.pickerCurrentYear])
        {
            strResult = [NSMutableString stringWithFormat:@"次年%@",strResult];
        }
    }
    //    else
    //    {
    //        NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    //
    //        NSDateComponents *weekdayComponents =
    //        [gregorian components:NSWeekdayCalendarUnit fromDate:afterData];
    //
    //        NSInteger weekday = [weekdayComponents weekday];
    //
    //        [strResult appendFormat:@"星期%d",(int)weekday];
    //    }
    
    return strResult;
}


//获取当前的时间字符串
- (NSString *)currentDateStr
{
    NSString * day = [self.pickerDateSelect.pickerMonthAndDay stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    day = [day substringToIndex:[day rangeOfString:@"日"].location];
    
    if([day containStr:@"次年"])
    {
        day = [day stringByReplacingOccurrencesOfString:@"次年" withString:@""];
    }
    
    if([self.minuteSizeIsFive boolValue])
    {
        return [NSString stringWithFormat:@"%@-%@ %@:%02d",
                self.pickerDateSelect.pickerYear,
                day,
                self.pickerDateSelect.pickerHour,
                (int)[self.pickerDateSelect.pickerMinute integerValue]*5];
    }
    else
    {
        return [NSString stringWithFormat:@"%@-%@ %@:%@",
                self.pickerDateSelect.pickerYear,
                day,
                self.pickerDateSelect.pickerHour,
                self.pickerDateSelect.pickerMinute];
    }
}

- (void)creatToolBar
{
    //    //2
    //    //创建工具条
    //    UIToolbar *toolbar=[[UIToolbar alloc]init];
    //    //设置工具条的颜色
    //    toolbar.barTintColor=[UIColor whiteColor];
    //    //设置工具条的frame
    //    toolbar.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame), 40);
    //
    //    UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(toolbar.frame)-0.5, CGRectGetWidth(toolbar.frame), 0.5)];
    //    lineV.backgroundColor = [UIColor bbxBorderAndSepartionLineColor];
    //    lineV.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //    [toolbar addSubview:lineV];
    //
    //    UIBarButtonItem *item0=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pickerNumCancel) ];
    //
    //    UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(pickerNumSubmit)];
    //
    //    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //
    //    toolbar.items = @[item0, item2, item1];
    //
    //    self.inputAccessoryView = toolbar;
    
    UIView * toolV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40)];
    toolV.backgroundColor = [UIColor whiteColor];
    
    
    UIButton * btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancel.backgroundColor = [UIColor clearColor];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor bbxLightBlackColor] forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [UIFont bbxSystemFont:14];
    [btnCancel addTarget:self action:@selector(pickerNumCancel) forControlEvents:UIControlEventTouchUpInside];
    btnCancel.frame = CGRectMake(0, 0, 40, CGRectGetHeight(toolV.frame));
    btnCancel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    [toolV addSubview:btnCancel];
    
    
    UIButton * btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSubmit.backgroundColor = [UIColor clearColor];
    [btnSubmit setTitle:@"确定" forState:UIControlStateNormal];
    [btnSubmit setTitleColor:[UIColor bbxBlueColor] forState:UIControlStateNormal];
    btnSubmit.titleLabel.font = [UIFont bbxSystemFont:14];
    [btnSubmit addTarget:self action:@selector(pickerNumSubmit) forControlEvents:UIControlEventTouchUpInside];
    btnSubmit.frame = CGRectMake(CGRectGetWidth(toolV.frame)-40, 0, 40, CGRectGetHeight(toolV.frame));
    btnSubmit.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    [toolV addSubview:btnSubmit];
    
    
    UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(toolV.frame)-0.5, CGRectGetWidth(toolV.frame), 0.5)];
    lineV.backgroundColor = [UIColor bbxBorderAndSepartionLineColor];
    lineV.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [toolV addSubview:lineV];
    
    lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(toolV.frame), 0.5)];
    lineV.backgroundColor = [UIColor bbxBorderAndSepartionLineColor];
    lineV.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [toolV addSubview:lineV];
    
    
    self.inputAccessoryView = toolV;
}

- (void)setPikerSelectHourAndMinute:(UIPickerView *)pickerV
{
    [pickerV selectRow:[self.pickerDateSelect.pickerHour integerValue] inComponent:1 animated:YES];
    [pickerV selectRow:[self.pickerDateSelect.pickerMinute integerValue] inComponent:3 animated:YES];
}

@end






@implementation BBXDatePickerItem



@end
