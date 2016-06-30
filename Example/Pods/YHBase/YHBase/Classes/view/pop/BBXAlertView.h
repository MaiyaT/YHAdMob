//
//  BBXAlertView.h
//  BangBangXing
//
//  Created by 林宁宁 on 16/1/11.
//  Copyright © 2016年 蓝海(福建)信息科技有限公司. All rights reserved.
//

#import "PopAnimationV.h"

@interface BBXAlertView : PopAnimationV

@property (copy, nonatomic) void(^popAlertBlock)(NSInteger index,NSString * title, BBXAlertView * alertV);

+(void)popAlertTitle:(NSString *)alertTitle andAlertBtnTitle:(NSArray *)btns
    andPopAlertBlock:(void(^)(NSInteger index,NSString * title, BBXAlertView * alertV))popAlertBlock andTapBGToDismiss:(BOOL)tapToDismiss;

@end
