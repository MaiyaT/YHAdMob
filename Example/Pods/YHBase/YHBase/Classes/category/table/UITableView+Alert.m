//
//  UITableView+Alert.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/21.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "UITableView+Alert.h"
#import "Masonry.h"
#import "UIColor+BBXApp.h"
#import <objc/runtime.h>



@implementation UITableView (Alert)

-(NSNumber *)isLoaded
{
    return objc_getAssociatedObject(self, @selector(isLoaded));
}

-(void)setIsLoaded:(NSNumber *)isLoaded
{
    objc_setAssociatedObject(self, @selector(isLoaded), isLoaded, OBJC_ASSOCIATION_RETAIN);
}




-(void)alertNoneOrder
{
    self.clipsToBounds = YES;
    
    UIView * alertV = [[UIView alloc] initWithFrame:self.bounds];
//    alertV.autoresizingMask = 0xff;
//    alertV.backgroundColor =
//    alertV.backgroundColor = [UIColor orangeColor];
    self.backgroundView = alertV;
    
    UIImageView * imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_noorders"]];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    [imgV sizeToFit];
    imgV.frame = CGRectMake(0, 0, CGRectGetWidth(imgV.frame), CGRectGetHeight(imgV.frame));
    imgV.center = CGPointMake(CGRectGetWidth(self.frame)*0.5, CGRectGetHeight(self.frame)*0.5-30);
    [alertV addSubview:imgV];
    
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgV.frame)+20, CGRectGetWidth(self.frame), 30)];
    lab.text = @"这里没有订单哦";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor bbxTextNoteColor];
    [alertV addSubview:lab];
}


-(void)alertNoneData
{
    self.clipsToBounds = YES;
    
    [self cleanAlertV];
    
    UIView * alertV = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroundView = alertV;
    
    UIImageView * imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_nodata"]];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    [imgV sizeToFit];
    imgV.frame = CGRectMake(0, 0, CGRectGetWidth(imgV.frame), CGRectGetHeight(imgV.frame));
    imgV.center = CGPointMake(CGRectGetWidth(self.frame)*0.5, CGRectGetHeight(self.frame)*0.5-30);
    [alertV addSubview:imgV];
}


-(void)alertLoadingWithTitle:(NSString *)alertTitle
{
    [self cleanAlertV];
    
    UIView * alertV = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroundView = alertV;
    
    
    UILabel * lab = [[UILabel alloc] initWithFrame:self.bounds];
    lab.text = alertTitle;
    lab.autoresizingMask = 0xff;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor bbxTextNoteColor];
    
    [alertV addSubview:lab];
}



-(void)cleanAlertV
{
    self.backgroundView = nil;
}



@end
