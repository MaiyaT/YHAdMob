//
//  BBXTextField.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/22.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "BBXTextField.h"
#import "Masonry.h"
#import "UIColor+BBXApp.h"
#import "UIFont+BBX.h"

@implementation BBXTextField

-(instancetype)initWithLeftImg:(NSString *)leftImgStr andRightImg:(NSString *)rightImg andSpace:(SpaceImg)space
{
    self = [super init];
    if(self)
    {
        if(leftImgStr)
        {
            _imgLeft = [[UIImageView alloc] init];
            _imgLeft.image = [UIImage imageNamed:leftImgStr];
            _imgLeft.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:_imgLeft];
        }
        
        if(rightImg)
        {
            _imgRight = [[UIImageView alloc] init];
            _imgRight.image = [UIImage imageNamed:rightImg];
            _imgRight.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:_imgRight];
        }
        
        
        self.textF = [[BBXCustomTextField alloc] init];
        self.textF.textAlignment = NSTextAlignmentLeft;
        self.textF.backgroundColor = [UIColor whiteColor];
        self.textF.font = [UIFont bbxSystemFont:14];
        self.textF.clearButtonMode = UITextFieldViewModeNever;
        self.textF.textColor = [UIColor bbxTextHeadTitleColor];
        [self addSubview:self.textF];
        
        
        __weak typeof(&*self)weakSelf = self;
        __weak typeof(&*_imgLeft)weakImgLeft = _imgLeft;
        __weak typeof(&*_imgRight)weakImgRight = _imgRight;
        
        if(_imgLeft)
        {
            [_imgLeft mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(weakSelf);
                make.left.equalTo(weakSelf).offset(space.img1_left);
                make.width.mas_equalTo(weakImgLeft.image.size.width);
            }];
        }
        
        if(_imgRight)
        {
            [_imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(weakSelf);
                make.right.equalTo(weakSelf).offset(-space.img2_right);
                make.width.mas_equalTo(weakImgRight.image.size.width);
            }];
        }
        
        [self.textF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            
            if(weakImgLeft)
            {
                make.left.equalTo(weakImgLeft.mas_right).offset(space.img1_right);
            }
            else
            {
                make.left.equalTo(weakSelf).offset(space.img1_right);
            }
            
            if(weakImgRight)
            {
                make.right.equalTo(weakImgRight.mas_left).offset(-space.img2_left);
            }
            else
            {
                make.right.equalTo(weakSelf).offset(-space.img2_left);
            }
        }];
    }
    return self;
}



-(instancetype)initWithLeftView:(UIView *)leftV andRightView:(UIView *)rightV andSpace:(SpaceImg)space andLeftSize:(float)leftWSize andRightSize:(float)rightWSize andVerSpace:(float)vSpace
{
    self = [super init];
    if(self)
    {
        if(leftV)
        {
            [self addSubview:leftV];
        }
        
        if(rightV)
        {
            [self addSubview:rightV];
        }
        
        self.textF = [[BBXCustomTextField alloc] init];
        self.textF.textAlignment = NSTextAlignmentLeft;
        self.textF.backgroundColor = [UIColor whiteColor];
        self.textF.font = [UIFont bbxSystemFont:14];
        self.textF.clearButtonMode = UITextFieldViewModeNever;
        self.textF.textColor = [UIColor bbxTextHeadTitleColor];
        [self addSubview:self.textF];
        
        
        __weak typeof(&*self)weakSelf = self;
        __weak typeof(&*leftV)weakLeft = leftV;
        __weak typeof(&*rightV)weakRight = rightV;
        
        if(leftV)
        {
            [leftV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf).offset(vSpace);
                make.bottom.equalTo(weakSelf).offset(-vSpace);
                make.left.equalTo(weakSelf).offset(space.img1_left);
                make.width.mas_equalTo(leftWSize);
            }];
        }
        
        if(rightV)
        {
            [rightV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf).offset(vSpace);
                make.bottom.equalTo(weakSelf).offset(-vSpace);
                make.right.equalTo(weakSelf).offset(-space.img2_right);
                make.width.mas_equalTo(rightWSize);
            }];
        }
        
        [self.textF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            
            if(weakLeft)
            {
                make.left.equalTo(weakLeft.mas_right).offset(space.img1_right);
            }
            else
            {
                make.left.equalTo(weakSelf).offset(space.img1_right);
            }
            
            if(weakRight)
            {
                make.right.equalTo(weakRight.mas_left).offset(-space.img2_left);
            }
            else
            {
                make.right.equalTo(weakSelf).offset(-space.img2_left);
            }
        }];
    }
    return self;
}


-(instancetype)initTextViewWithLeftView:(UIView *)leftV andRightView:(UIView *)rightV andSpace:(SpaceImg)space andLeftSize:(float)leftWSize andRightSize:(float)rightWSize andVerSpace:(float)vSpace
{
    self = [super init];
    if(self)
    {
        if(leftV)
        {
            [self addSubview:leftV];
        }
        
        if(rightV)
        {
            [self addSubview:rightV];
        }
        
        self.textV = [[UITextView alloc] init];
        self.textV.textAlignment = NSTextAlignmentLeft;
        self.textV.backgroundColor = [UIColor whiteColor];
        self.textV.font = [UIFont bbxSystemFont:14];
        self.textV.textColor = [UIColor bbxTextHeadTitleColor];
        
        
        [self addSubview:self.textV];
        
        
        __weak typeof(&*self)weakSelf = self;
        __weak typeof(&*leftV)weakLeft = leftV;
        __weak typeof(&*rightV)weakRight = rightV;
        
        if(leftV)
        {
            [leftV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf).offset(vSpace);
                make.bottom.equalTo(weakSelf).offset(-vSpace);
                make.left.equalTo(weakSelf).offset(space.img1_left);
                make.width.mas_equalTo(leftWSize);
            }];
        }
        
        if(rightV)
        {
            [rightV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf).offset(vSpace);
                make.bottom.equalTo(weakSelf).offset(-vSpace);
                make.right.equalTo(weakSelf).offset(-space.img2_right);
                make.width.mas_equalTo(rightWSize);
            }];
        }
        
        [self.textV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            
            if(weakLeft)
            {
                make.left.equalTo(weakLeft.mas_right).offset(space.img1_right);
            }
            else
            {
                make.left.equalTo(weakSelf).offset(space.img1_right);
            }
            
            if(weakRight)
            {
                make.right.equalTo(weakRight.mas_left).offset(-space.img2_left);
            }
            else
            {
                make.right.equalTo(weakSelf).offset(-space.img2_left);
            }
            
            make.centerY.equalTo(weakLeft.mas_centerY);
        }];

    }
    return self;
}

-(instancetype)initTextViewWithLeftImg:(NSString *)leftImgStr andRightImg:(NSString *)rightImg andSpace:(SpaceImg)space
{
    self = [super init];
    if(self)
    {
        if(leftImgStr)
        {
            _imgLeft = [[UIImageView alloc] init];
            _imgLeft.image = [UIImage imageNamed:leftImgStr];
            _imgLeft.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:_imgLeft];
        }
        
        if(rightImg)
        {
            _imgRight = [[UIImageView alloc] init];
            _imgRight.image = [UIImage imageNamed:rightImg];
            _imgRight.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:_imgRight];
        }
        
        
        self.textV = [[UITextView alloc] initWithFrame:CGRectZero];
        self.textV.textAlignment = NSTextAlignmentLeft;
        self.textV.backgroundColor = [UIColor whiteColor];
        self.textV.font = [UIFont bbxSystemFont:14];
        self.textV.textContainerInset = UIEdgeInsetsMake(3, 0, 0, 3);
        self.textV.textColor = [UIColor bbxTextHeadTitleColor];
        
        [self addSubview:self.textV];
        
        
        __weak typeof(&*self)weakSelf = self;
        __weak typeof(&*_imgLeft)weakImgLeft = _imgLeft;
        __weak typeof(&*_imgRight)weakImgRight = _imgRight;
        
        if(_imgLeft)
        {
            [_imgLeft mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(weakSelf);
                make.left.equalTo(weakSelf).offset(space.img1_left);
                make.width.mas_equalTo(weakImgLeft.image.size.width);
            }];
        }
        
        if(_imgRight)
        {
            [_imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(weakSelf);
                make.right.equalTo(weakSelf).offset(-space.img2_right);
                make.width.mas_equalTo(weakImgRight.image.size.width);
            }];
        }
        
        [self.textV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            
            if(weakImgLeft)
            {
                make.left.equalTo(weakImgLeft.mas_right).offset(space.img1_right);
            }
            else
            {
                make.left.equalTo(weakSelf).offset(space.img1_right);
            }
            
            if(weakImgRight)
            {
                make.right.equalTo(weakImgRight.mas_left).offset(-space.img2_left);
            }
            else
            {
                make.right.equalTo(weakSelf).offset(-space.img2_left);
            }
        }];
    }
    return self;
}


-(void)setTapRightImgBlock:(void (^)())tapRightImgBlock
{
    _tapRightImgBlock = tapRightImgBlock;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRighEvent)];
    _imgRight.userInteractionEnabled = YES;
    [_imgRight addGestureRecognizer:tapGesture];
}

- (void)tapRighEvent
{
    if(self.tapRightImgBlock)
    {
        self.tapRightImgBlock();
    }
}

- (void)setTextVTopTextIsBlueColorAndDownIsBlockWithText:(NSString *)contentStr
{
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    
    NSRange rangeReturn = [contentStr rangeOfString:@"\n"];
    
    [attStr addAttributes:@{NSFontAttributeName:self.textV.font} range:NSMakeRange(0, attStr.length)];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor bbxTextLinkNorColor]} range:NSMakeRange(0, rangeReturn.location)];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor bbxTextHeadTitleColor]} range:NSMakeRange(NSMaxRange(rangeReturn), attStr.length - NSMaxRange(rangeReturn))];
    
    self.textV.attributedText = attStr;
}


@end
