//
//  BBXAlertView.m
//  BangBangXing
//
//  Created by 林宁宁 on 16/1/11.
//  Copyright © 2016年 蓝海(福建)信息科技有限公司. All rights reserved.
//

#import "BBXAlertView.h"

#import "UIColor+BBXApp.h"
#import "UIFont+BBX.h"

@interface BBXAlertView()

@property (copy, nonatomic) NSString * popAlertTitle;
@property (retain, nonatomic) NSArray * popBtns;

/**
 *  是否可以点击背景 来关闭弹窗
 */
@property (assign, nonatomic) BOOL popTapBGVToDismiss;

@end

@implementation BBXAlertView

- (void)creatPopContentV
{
    self.popContentV.backgroundColor = [UIColor clearColor];
    
    UIView * contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.popWidth, 20)];
    contentV.backgroundColor = [UIColor whiteColor];
    
    float offx = 20;
    
    UILabel * headTitle = [[UILabel alloc] initWithFrame:CGRectMake(offx, 20, CGRectGetWidth(contentV.frame)-offx*2, 30)];
    headTitle.text = self.popAlertTitle;
    headTitle.font = [UIFont bbxSystemFont:18];
    headTitle.textColor = [UIColor blackColor];//[UIColor colorWithHexString:@"3b3b3b"];
    headTitle.numberOfLines = 0;
    headTitle.lineBreakMode = NSLineBreakByWordWrapping;
    headTitle.textAlignment = NSTextAlignmentCenter;
    [headTitle sizeToFit];
    headTitle.frame = CGRectMake(headTitle.frame.origin.x, headTitle.frame.origin.y, CGRectGetWidth(contentV.frame)-offx*2, CGRectGetHeight(headTitle.frame));
    [contentV addSubview:headTitle];
    
    
    float btnW = self.popWidth/self.popBtns.count;
    float btnOffx = 0;
    float btnOffy = CGRectGetMaxY(headTitle.frame)+20;
    float btnH = 44;
    
    UIView * lineV = [UIView new];
    lineV.backgroundColor = [UIColor bbxBorderAndSepartionLineColor];
    lineV.frame = CGRectMake(0, btnOffy-0.5, CGRectGetWidth(contentV.frame), 0.5);
    [contentV addSubview:lineV];
    
    for(NSString * str in self.popBtns)
    {
        NSInteger index = [self.popBtns indexOfObject:str];
    
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        [btn setTitle:str forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(btnOffx, btnOffy, btnW, btnH);
        btn.titleLabel.font = [UIFont bbxSystemFont:18];
        [btn setTitleColor:[UIColor colorWithHexString:@"007aff"] forState:UIControlStateNormal];
        [contentV addSubview:btn];

        btnOffx = btnW + btnOffx;
        
        if(![str isEqualToString:[self.popBtns lastObject]])
        {
            UIView * btnSepLineV = [UIView new];
            btnSepLineV.backgroundColor = [UIColor bbxBorderAndSepartionLineColor];
            btnSepLineV.frame = CGRectMake(btnOffx - 0.5, btnOffy, 0.5, btnH);
            [contentV addSubview:btnSepLineV];
        }
    }
    
    
    contentV.frame = CGRectMake(0, 0, self.popWidth, btnOffy + btnH);
    
    [self creatContentVWithTop:nil andBottom:nil andMid:contentV andHaveLine:YES];
    
    self.popContentV.layer.cornerRadius = 6;
    self.popContentV.layer.masksToBounds = YES;
}

- (void)btnEvent:(UIButton *)sender
{
    if(self.popAlertBlock)
    {
        self.popAlertBlock(sender.tag,[sender currentTitle],self);
    }
}

-(void)tapBackgroundEvent
{
    if(self.popTapBGVToDismiss)
    {
        [self popDismiss];
    }
}


+(void)popAlertTitle:(NSString *)alertTitle andAlertBtnTitle:(NSArray *)btns andPopAlertBlock:(void (^)(NSInteger, NSString *, BBXAlertView *))popAlertBlock andTapBGToDismiss:(BOOL)tapToDismiss
{
    UIWindow * mainV = [[UIApplication sharedApplication] keyWindow];
    
    float alpha = 0.1;
    
    if(tapToDismiss)
    {
        for(UIView * subV in mainV.subviews)
        {
            if([subV isKindOfClass:[BBXAlertView class]])
            {
                BBXAlertView * otherPop = (BBXAlertView *)subV;
                
                [otherPop popDismiss];
            }
        }
    }
    
    
    BBXAlertView * popV = [[BBXAlertView alloc] initWithFrame:CGRectZero popVAddToSuperview:mainV andWithBgAlpha:alpha];
    
    popV.popAlertTitle    = alertTitle;
    popV.popBtns       = btns;
    
    popV.popTapBGVToDismiss = tapToDismiss;
    
    popV.popAlertTitle      = alertTitle;
    
    popV.popWidth           = CGRectGetWidth(mainV.frame)*0.8;
    
    if(popV.popWidth > 260)
    {
        popV.popWidth = 260;
    }
    
    popV.popAlertBlock  = popAlertBlock;

    [popV creatPopContentV];
    
    [popV popShowWithBG:alpha!=0];
}
@end
