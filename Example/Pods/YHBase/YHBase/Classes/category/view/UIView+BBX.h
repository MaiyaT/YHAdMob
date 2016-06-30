//
//  UIView+BBX.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/8/6.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BBX)


@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;

@property (nonatomic, assign) CGFloat frameRight;
@property (nonatomic, assign) CGFloat frameBottom;

@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHeight;


/**
 *  附加的数据
 */
@property (retain, nonatomic) id appendObj;


/**
 *  弹出提醒
 */
- (void)showWithText:(NSString *)alertStr;

/**
 *  请求的时候 弹出提示
 *
 *  @param otherMessage 如果不为空 直接提示这个错误 如果 为空 提示网络异常
 */
- (void)showRequestFailToast:(NSString *)otherMessage;


- (BOOL) containsSubView:(UIView *)subView;
- (BOOL) containsSubViewOfClassType:(Class)aClass;


/**
 *  弹动的动画
 */
- (void)animationDynamics;

/**
 *  从地下弹回来
 */
- (void)animationDownUp;
- (void)animationUpDown;

/**
 *  从地下弹回来 一点点
 */
- (void)animationDownUpALittle;
- (void)animationUpDownALittle;


- (void)animationBackgroundColor:(UIColor *)toColor;

/**
 *  警示动画
 */
- (void)animationWarning;

- (void)animationAlphaZero;

- (void)animationAlphaShow;

/**
 *  旋转抖动一下
 */
- (void)animationRotateShakeWithDelayBegin:(float)delayTime withFinishBlock:(void(^)(UIView * animationV))finishBlock;

/**
 *  掉落动画
 */
- (void)animationDropDownWithDelayBegin:(float)delayTime;

/**
 *  弹出动画
 */
- (void)animationPopShowFinishBlock:(void (^)(UIView *animationV))finishBlock
;

/**
 *  弹 隐藏 动画
 */
- (void)animationPopHiddenFinishBlock:(void(^)(UIView * animationV))finishBlock;

/**
 *  上下翻转
 */
- (void)animationFlipX;

/**
 *  旋转二周
 */
- (void)animationRotateTwoCycleFinishBlock:(void (^)(UIView * animationV))finishBlock;
/**
 *  旋转一周
 */
- (void)animationRotateOneCycleFinishBlock:(void (^)(UIView * animationV))finishBlock;

@end
