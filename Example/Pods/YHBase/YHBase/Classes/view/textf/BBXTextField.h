//
//  BBXTextField.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/22.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBXCustomTextField.h"

#import "UITextView+Placeholder.h"

struct SpaceImg{
    CGFloat img1_left;
    CGFloat img1_right;
    CGFloat img2_left;
    CGFloat img2_right;
};
typedef struct SpaceImg SpaceImg;



@interface BBXTextField : UIView
{
    UIImageView * _imgLeft;
    UIImageView * _imgRight;
}





-(instancetype)initWithLeftImg:(NSString *)leftImgStr andRightImg:(NSString *)rightImg andSpace:(SpaceImg)space;

-(instancetype)initTextViewWithLeftImg:(NSString *)leftImgStr andRightImg:(NSString *)rightImg andSpace:(SpaceImg)space;

-(instancetype)initWithLeftView:(UIView *)leftV andRightView:(UIView *)rightV andSpace:(SpaceImg)space andLeftSize:(float)leftWSize andRightSize:(float)rightWSize andVerSpace:(float)vSpace;

-(instancetype)initTextViewWithLeftView:(UIView *)leftV andRightView:(UIView *)rightV andSpace:(SpaceImg)space andLeftSize:(float)leftWSize andRightSize:(float)rightWSize andVerSpace:(float)vSpace;

@property (retain, nonatomic) BBXCustomTextField * textF;

@property (retain, nonatomic) UITextView * textV;

@property (retain, nonatomic) id appendObj;

@property (copy, nonatomic) void(^tapRightImgBlock)();



/** 设置顶部是蓝色字  底部是黑色字  通过 \n来区分*/
- (void)setTextVTopTextIsBlueColorAndDownIsBlockWithText:(NSString *)contentStr;



@end
