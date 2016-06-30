//
//  BBXAlertTextInputV.m
//  BangBangXing
//
//  Created by 林宁宁 on 16/1/13.
//  Copyright © 2016年 蓝海(福建)信息科技有限公司. All rights reserved.
//

#import "BBXAlertTextInputV.h"
#import "UIColor+BBXApp.h"
#import "UITextView+Placeholder.h"
#import "UIView+BBX.h"
#import "NSObject+Keyboard.h"
#import "NSString+BBX.h"
#import "UIFont+BBX.h"


@interface BBXAlertTextInputV()

@property (copy, nonatomic) NSString * popTitle;

@property (copy, nonatomic) NSString * popPlaceHoldTitle;

@property (retain, nonatomic) NSArray * popBtns;

@property (retain, nonatomic) UITextView * popTextV;

@property (assign, nonatomic) NSInteger popLimitNum;

@end

@implementation BBXAlertTextInputV


- (void)creatPopContentV
{
    self.popContentV.backgroundColor = [UIColor clearColor];
    
    UIView * contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.popWidth, 20)];
    contentV.backgroundColor = [UIColor whiteColor];
    
    float offx = 17;
    
    UILabel * headTitle = [[UILabel alloc] initWithFrame:CGRectMake(offx, 20, CGRectGetWidth(contentV.frame)-offx*2, 30)];
    headTitle.text = self.popTitle;
    headTitle.font = [UIFont bbxSystemFont:16];
    headTitle.textColor = [UIColor bbxTextHeadTitleColor];
    headTitle.numberOfLines = 0;
    headTitle.lineBreakMode = NSLineBreakByWordWrapping;
    headTitle.textAlignment = NSTextAlignmentCenter;
    [headTitle sizeToFit];
    headTitle.frame = CGRectMake(headTitle.frame.origin.x, headTitle.frame.origin.y, CGRectGetWidth(contentV.frame)-offx*2, CGRectGetHeight(headTitle.frame));
    [contentV addSubview:headTitle];
    
    
    UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(offx, CGRectGetMaxY(headTitle.frame)+ 10, CGRectGetWidth(contentV.frame)-offx*2, 0.5)];
    lineV.backgroundColor = [UIColor bbxBorderAndSepartionLineColor];
    [contentV addSubview:lineV];
    
    
    UITextView * textV = [[UITextView alloc] initWithFrame:CGRectMake(offx, CGRectGetMaxY(headTitle.frame) + 17, CGRectGetWidth(contentV.frame)-offx*2, 120)];
    textV.font = [UIFont bbxSystemFont:13];
    textV.placeholder = self.popPlaceHoldTitle;
    textV.placeholderLabel.font = [UIFont bbxSystemFont:13];
    textV.placeholderColor = [UIColor bbxTextHeadSubTitleColor];
    textV.layer.borderColor = [UIColor bbxTextHeadSubTitleColor].CGColor;
    textV.layer.borderWidth = 0.5;
    self.popTextV = textV;
    [contentV addSubview:textV];
    
    
    float btnW = self.popWidth/self.popBtns.count;
    float btnOffx = 0;
    float btnOffy = CGRectGetMaxY(textV.frame)+13;
    float btnH = 44;
    
    
    lineV = [UIView new];
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
        btn.titleLabel.font = [UIFont bbxSystemFont:16];
        [btn setTitleColor:[UIColor colorWithHexString:@"00aaff"] forState:UIControlStateNormal];
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
    
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        __weak typeof(&*self)weakSelf = self;
        
        [self registerKeyBoardNotifitionWithBlock:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {
            
            //        NSLog(@"%@",NSStringFromCGRect(keyboardRect));
            
            if (isShowing) {
                
                CGRect textFrame = [weakSelf convertRect:weakSelf.popContentV.frame toView:[[UIApplication sharedApplication] keyWindow]];
                
                NSInteger textMaxy = CGRectGetMaxY(textFrame);
                
                float offset = textMaxy - (CGRectGetMinY(keyboardRect));
                
                if(offset>0)
                {
                    weakSelf.popContentV.transform = CGAffineTransformMakeTranslation(0, - offset);
                }
                
            } else {
                weakSelf.popContentV.transform = CGAffineTransformIdentity;
            }
            //        [weakSelf layoutIfNeeded];
            
        }];
        
        
        [self.popTextV becomeFirstResponder];
        
    });
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChangeNotiftion:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)textViewDidChangeNotiftion:(NSNotification *)notifition
{
    UITextView * textV = notifition.object;
    
    if([textV isEqual:self.popTextV])
    {
        [self textViewContentChange];
    }
}

- (void)textViewContentChange
{
    if([self.popTextV.text hasPrefix:@"\n"])
    {
        self.popTextV.text = [self.popTextV.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    
    UITextRange *selectedRange = [self.popTextV markedTextRange];
    NSString * newText = [self.popTextV textInRange:selectedRange];
    
    if(newText.length == 0)
    {
        if([self.popTextV.text lengthUnicode] > self.popLimitNum)
        {
            [self showWithText:[NSString stringWithFormat:@"最多%d个字符",(int)self.popLimitNum]];
            self.popTextV.text = [self.popTextV.text subStringUnicodeIndex:self.popLimitNum];
        }
    }
}


- (void)btnEvent:(UIButton *)sender
{
    [self.popTextV resignFirstResponder];
    
    if(self.popAlertBlock)
    {
        self.popAlertBlock(sender.tag,self.popTextV.text,self,[sender currentTitle]);
    }
}

-(void)tapBackgroundEvent
{
    [self endEditing:YES];
}


-(void)dealloc
{
    [self registerKeyBoardNotifitionRemove];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}



+(void)popAlertInputContentWithTitle:(NSString *)title
                   andPlaceHoldTitle:(NSString *)placeTitle
                    andAlertBtnTitle:(NSArray *)btns
                     andLimitWordNum:(NSInteger)limitNum
                    andPopAlertBlock:(void (^)(NSInteger, NSString *, BBXAlertTextInputV *, NSString *))popAlertBlock
{
    UIWindow * mainV = [[UIApplication sharedApplication] keyWindow];
    
    float alpha = 0.1;
    
    BBXAlertTextInputV * popV = [[BBXAlertTextInputV alloc] initWithFrame:CGRectZero popVAddToSuperview:mainV andWithBgAlpha:alpha];
    
    popV.popTitle    = title;
    popV.popPlaceHoldTitle = placeTitle;
    popV.popBtns       = btns;
    popV.popLimitNum = limitNum;
    if(limitNum == 0)
    {
        popV.popLimitNum = 100000;
    }
    popV.popWidth           = CGRectGetWidth(mainV.frame)*0.8;
    
    popV.popAlertBlock  = popAlertBlock;
    
    [popV creatPopContentV];
    
    [popV popShowWithBG:alpha!=0];
}


@end
