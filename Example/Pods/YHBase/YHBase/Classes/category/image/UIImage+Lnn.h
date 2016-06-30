//
//  UIImage+Lnn.h
//  SuoShi
//
//  Created by 林宁宁 on 15/12/18.
//  Copyright © 2015年 林宁宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Lnn)


/**
 *  根据给定得图片，从其指定区域截取一张新得图片
 *
 *  @param areaFrame  截图的区域
 */
-(UIImage *)getImagePointArea:(CGRect)areaFrame;


/**
 *  缩放
 *
 *  @param thumbRect 缩放的比例
 */
-(UIImage*)resizedToRect:(CGRect)thumbRect;

/**
 *  缩放
 *
 *  @param thumbRect 缩放的比例
 */
-(UIImage*)resizedToRect2:(CGRect)thumbRect;


/**
 *  最大的高度 或者 宽度
 *
 *  @param maxWidth  最大宽度
 *  @param maxHeight 最大高度
 */
- (UIImage *)scaleMaxWidth:(float) maxWidth maxHeight:(float) maxHeight;

- (UIImage *)scaleMaxWidth:(float) maxWidth;

@end
