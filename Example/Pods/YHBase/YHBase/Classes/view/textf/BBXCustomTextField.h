//
//  BBXCustomTextField.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/25.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TextLimit)
{
    /**
     *  不限制
     */
    TextLimit_None,
    
    /**
     *  6位数字
     */
    TextLimit_Num_6,
    
    /**
     *  4位数字
     */
    TextLimit_Num_4,
    
    /**
     *  11位数字
     */
    TextLimit_Num_11,
    
    /**
     *  12个字符
     */
    TextLimit_Chars_12,
    
    /**
     *  15个字符
     */
    TextLimit_Num_15,
    
    /**
     *  4到23位的数字和字母的组合
     */
    TextLimit_Num_Char_4_23,
    
    /**
     *  4到6位的数字和字母的组合
     */
    TextLimit_Num_Char_4_6,
    
    
    /**
     *  数字和字母的组合
     */
    TextLimit_Num_Char,
    
    /**
     *  纯数字
     */
    TextLimit_Num
};

@interface BBXCustomTextField : UITextField

@property (retain, nonatomic) UIImageView * leftImage;
@property (retain, nonatomic) UIImageView * rightImage;

/** 附加上的对象*/
@property (strong, nonatomic) id appendObj;

/** 这个文本是文字格式是正确的*/
@property (assign, nonatomic) BOOL textFormatAvailable;

/** 开始编辑*/
@property (copy, nonatomic) void(^textBeginEditBlock)(BBXCustomTextField * textF);

/** 结束编辑*/
@property (copy, nonatomic) void(^textEndEditBlock)(BBXCustomTextField * textF);

/** 不让他编辑的 点击之后回调*/
@property (copy, nonatomic) void(^textTapEventBlock)(BBXCustomTextField * textF);


/**
 *  输入限制
 */
@property (assign, nonatomic) TextLimit textLimit;

- (void)creatPlaceHoledString:(NSString *)plsceStr;


/** 空置 创建输入框的 左边和右边的师徒*/
-(void)creatRightAndLeftView;

/** 创建输入框左边的提示*/
- (void)creatLeftViewWithString:(NSString *)leftString withHeight:(float)height;

- (void)creatLeftViewWithString:(NSString *)leftString withHeight:(float)height andMode:(UITextFieldViewMode )mode;

-(void)creatLeftViewWithString:(NSString *)leftString andLeftImg:(NSString *)leftImgName andRightImg:(NSString *)rightImgName withHeight:(float)height;

- (void)creatLeftView;

- (void)creatRightViewWithImage:(UIImage *)image andMode:(UITextFieldViewMode )mode;

-(void)creatLeftViewWithImage:(UIImage *)image andMode:(UITextFieldViewMode)mode;

- (void)creatRightViewWithImage:(UIImage *)image andMode:(UITextFieldViewMode )mode andClickBlock:(void(^)())clickBlock;


/**
 *  编辑的时候格式是否符合
 */
+ (BOOL)shouldChangeWhenEditWithStr:(NSString *)string andTextField:(UITextField *)textField andLimitType:(TextLimit)limitType;


@end
