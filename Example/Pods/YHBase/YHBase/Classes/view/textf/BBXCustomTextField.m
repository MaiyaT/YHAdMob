//
//  BBXCustomTextField.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/25.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "BBXCustomTextField.h"
#import "UIColor+BBXApp.h"
#import "UIColor+BBXApp.h"
#import "BBXRegex.h"
#import "UIFont+BBX.h"


@interface BBXCustomTextField()

@property (copy, nonatomic) void(^clickRightImageBlock)();

@end

@implementation BBXCustomTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initTextField];
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        [self initTextField];
    }
    return self;
}

- (void)initTextField
{
    
    self.placeholder = @"";
//    self.keyboardAppearance = UIKeyboardAppearanceDark;
    self.backgroundColor = [UIColor whiteColor];
    self.textColor = [UIColor blackColor];
    self.font = [UIFont bbxSystemFont:14];
    self.textAlignment = NSTextAlignmentCenter;
    
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    
//    self.layer.cornerRadius = layout_cornerRadius;
//    self.layer.masksToBounds = YES;
//    self.layer.borderColor = [UIColor bbxBorderAndSepartionLineColor].CGColor;
//    self.layer.borderWidth = Layout_boraderWidth;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBeginEdit:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEndEdit:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

- (void)creatPlaceHoledString:(NSString *)plsceStr
{
    self.placeholder = plsceStr;
    
    self.textColor = [UIColor blackColor];
    
    if(self.placeholder)
    {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor bbxTextNoteColor],
                                                                                                              NSFontAttributeName:[UIFont bbxSystemFont:14]}];
    }
}


//
//-(void)setTextTapEventBlock:(void (^)(BBXCustomTextField *))textTapEventBlock
//{
//    _textTapEventBlock = textTapEventBlock;
//    
//    [self setEnabled:NO];
//    
//    UITapGestureRecognizer * tapEvent = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
//    [self addGestureRecognizer:tapEvent];
//}

//- (void)tapEvent:(UITapGestureRecognizer *)gesture
//{
//    if(self.textTapEventBlock)
//    {
//        self.textTapEventBlock(self);
//    }
//}




- (void)textBeginEdit:(NSNotification *)notifition
{
    if([notifition.object isEqual:self])
    {
        self.layer.borderColor = [UIColor bbxThemeColor].CGColor;
        
        if(self.textBeginEditBlock)
        {
            self.textBeginEditBlock(self);
        }
    }
    
}

//- (void)textChange:(NSNotification *)notifition
//{
//    if([notifition.object isEqual:self])
//    {
//
//    }
//}

- (void)textEndEdit:(NSNotification *)notifition
{
    if([notifition.object isEqual:self])
    {
        self.layer.borderColor = [UIColor bbxBorderAndSepartionLineColor].CGColor;
        
        if(self.textEndEditBlock)
        {
            self.textEndEditBlock(self);
        }
    }
    
    
//    if([notifition.object isEqual:self])
//    {
//        self.textColor = RGB(151, 151, 151);
//        
//        if(self.placeholder)
//        {
//            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: RGB(74, 74, 74)}];
//        }
//        
//        self.backgroundColor = RGB(47, 47, 47);//COLOR_74_74_74;
//    }
}

- (void)creatLeftView
{
    UIImageView * imgLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nilhalf"]];
    imgLeft.contentMode = UIViewContentModeScaleAspectFit;
    self.leftImage= imgLeft;
    
    self.leftView= imgLeft;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)creatRightViewWithImage:(UIImage *)image andMode:(UITextFieldViewMode )mode
{
    [self creatRightViewWithImage:image andMode:mode andClickBlock:nil];
}

-(void)creatRightViewWithImage:(UIImage *)image andMode:(UITextFieldViewMode)mode andClickBlock:(void (^)())clickBlock
{
    UIImageView * imgRight = [[UIImageView alloc] initWithImage:image];
    imgRight.contentMode = UIViewContentModeScaleAspectFit;
    self.rightImage= imgRight;
    
    self.rightView= imgRight;
    self.rightViewMode = mode;
    
    if(clickBlock)
    {
        imgRight.userInteractionEnabled = YES;
        self.clickRightImageBlock = clickBlock;
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRightImageEvent)];
        [self.rightView addGestureRecognizer:tapGesture];
    }
}


-(void)creatLeftViewWithImage:(UIImage *)image andMode:(UITextFieldViewMode)mode
{
    UIImageView * imgLeft = [[UIImageView alloc] initWithImage:image];
    imgLeft.contentMode = UIViewContentModeScaleAspectFit;
    imgLeft.frame = CGRectMake(0, 0, 35, image.size.height);
//    imgLeft.backgroundColor = [UIColor redColor];
    self.leftImage= imgLeft;
    
    self.leftView= imgLeft;
    self.leftViewMode = mode;
}


- (void)tapRightImageEvent
{
    if(self.clickRightImageBlock)
    {
        self.clickRightImageBlock();
    }
}

-(void)creatRightAndLeftView
{
    UIImageView * imgRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nil"]];
    imgRight.contentMode = UIViewContentModeScaleAspectFit;
    
    self.rightImage = imgRight;
    self.rightView=imgRight;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    UIImageView * imgLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nil"]];
    imgLeft.contentMode = UIViewContentModeScaleAspectFit;
    self.leftImage= imgLeft;
    
    self.leftView= imgLeft;
    self.leftViewMode = UITextFieldViewModeAlways;
    
}

-(void)creatLeftViewWithString:(NSString *)leftString withHeight:(float)height
{
    [self creatLeftViewWithString:leftString withHeight:height andMode:UITextFieldViewModeUnlessEditing];
}

-(void)creatLeftViewWithString:(NSString *)leftString withHeight:(float)height andMode:(UITextFieldViewMode)mode
{
    UILabel * labLeft = [[UILabel alloc] init];
    labLeft.text = [NSString stringWithFormat:@"%@",leftString];
    labLeft.font = [UIFont bbxSystemFont:14];
    labLeft.textColor = [UIColor bbxTextHeadSubTitleColor];
    [labLeft sizeToFit];
    self.leftView=labLeft;
    self.leftViewMode = mode;
    
    
//    UIImageView * imgRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nil"]];
//    imgRight.contentMode = UIViewContentModeScaleAspectFit;
//    
//    self.rightView=imgRight;
//    self.rightViewMode = mode;
}

-(void)creatLeftViewWithString:(NSString *)leftString andLeftImg:(NSString *)leftImgName andRightImg:(NSString *)rightImgName withHeight:(float)height
{

    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.userInteractionEnabled = NO;
    [btn setTitle:leftString forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:leftImgName] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor bbxTextHeadSubTitleColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont bbxSystemFont:14];
    btn.frame = CGRectMake(0, 0, 110, height);
//    btn.backgroundColor = [UIColor redColor];
    self.leftView=btn;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UIImage * imag = [UIImage imageNamed:rightImgName];
    UIImageView * imgRight = [[UIImageView alloc] initWithImage:imag];
    imgRight.contentMode = UIViewContentModeScaleAspectFit;
    imgRight.frame = CGRectMake(0, 0, 25, imag.size.height);
    self.rightView=imgRight;
    self.rightViewMode = UITextFieldViewModeAlways;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}




/**
 *  编辑的时候格式是否符合
 */
+ (BOOL)shouldChangeWhenEditWithStr:(NSString *)string andTextField:(UITextField *)textField andLimitType:(TextLimit)limitType
{
    if([string isEqualToString:@""])
    {
        return YES;
    }
    
    //是数字类型
    if(limitType == TextLimit_Num ||
       limitType == TextLimit_Num_6 ||
       limitType == TextLimit_Num_11 ||
       limitType == TextLimit_Num_15 ||
       limitType == TextLimit_Num_4)
    {
        NSScanner* scan = [NSScanner scannerWithString:string];
        int val;
        BOOL isInt = [scan scanInt:&val] && [scan isAtEnd];
        
        if(isInt)
        {
            if(limitType == TextLimit_Num)
            {
                return YES;
            }
            else if (limitType == TextLimit_Num_6)
            {
                return textField.text.length<6;
            }
            else if (limitType == TextLimit_Num_11)
            {
                return textField.text.length<11;
            }
            else if (limitType == TextLimit_Num_15)
            {
                return textField.text.length<15;
            }
            else if (limitType == TextLimit_Num_4)
            {
                return textField.text.length<4;
            }
        }
        
        return NO;
    }
    else if (limitType == TextLimit_Chars_12)
    {
        return textField.text.length<12;
    }
    else if(limitType == TextLimit_Num_Char_4_23)
    {
        return [BBXRegex regexString:string withRegex:REGEX_NUM_CHAR_4_23];
    }
    else if (limitType == TextLimit_Num_Char)
    {
        return [BBXRegex regexString:string withRegex:REGEX_NUM_CHAR];
    }
    else if (limitType == TextLimit_Num_Char_4_6)
    {
        return [BBXRegex regexString:string withRegex:REGEX_NUM_CHAR_4_6];
    }
    return YES;
}



@end
