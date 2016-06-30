//
//  BBXAlertTextInputV.h
//  BangBangXing
//
//  Created by 林宁宁 on 16/1/13.
//  Copyright © 2016年 蓝海(福建)信息科技有限公司. All rights reserved.
//

#import "PopAnimationV.h"

@interface BBXAlertTextInputV : PopAnimationV

@property (copy, nonatomic) void(^popAlertBlock)(NSInteger index,NSString * inputContent, BBXAlertTextInputV * alertV,NSString * btnTitle);

+(void)popAlertInputContentWithTitle:(NSString *)title andPlaceHoldTitle:(NSString *)placeTitle andAlertBtnTitle:(NSArray *)btns andLimitWordNum:(NSInteger)limitNum
    andPopAlertBlock:(void(^)(NSInteger index,NSString * inputContent, BBXAlertTextInputV * alertV,NSString * btnTitle))popAlertBlock;

@end
