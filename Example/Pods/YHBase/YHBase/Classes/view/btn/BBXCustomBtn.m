//
//  BBXCustomBtn.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/8/7.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "BBXCustomBtn.h"

@implementation BBXCustomBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if(self.rectImge.size.height == 0 || self.rectImge.size.width == 0)
    {
        return contentRect;
    }
    
    return self.rectImge;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if(self.rectTitle.size.height == 0 || self.rectTitle.size.width == 0)
    {
        return contentRect;
    }
    
    return self.rectTitle;
}

@end
