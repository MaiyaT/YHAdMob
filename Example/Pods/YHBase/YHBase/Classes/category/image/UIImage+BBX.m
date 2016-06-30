//
//  UIImage+BBX.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/29.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "UIImage+BBX.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (BBX)

- (UIImage *)addImage:(UIImage *)image
{
    UIGraphicsBeginImageContext(self.size);
    
    // Draw image1
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    // Draw image2
    [image drawInRect:CGRectMake((self.size.width - image.size.width)*0.5, (self.size.height - image.size.height)*0.5, image.size.width, image.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}




@end

