//
//  UIView+BBX.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/8/6.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "UIView+BBX.h"

#import <objc/runtime.h>

#import "LPPopup.h"
#import "AppDelegateBase.h"
#import "POP.h"

@implementation UIView (BBX)

-(void)setAppendObj:(id)appendObj
{
    objc_setAssociatedObject(self, @selector(appendObj), appendObj, OBJC_ASSOCIATION_RETAIN);
}


-(id)appendObj
{
    return objc_getAssociatedObject(self, @selector(appendObj));
}



/**
 *  弹出提醒
 */
- (void)showWithText:(NSString *)alertStr
{
    LPPopup *popup = [LPPopup popupWithText:alertStr];
    
    [popup showInView:[[AppDelegateBase shareAppDelegate] window]
        centerAtPoint:[[AppDelegateBase shareAppDelegate] window].center
             duration:kLPPopupDefaultWaitDuration
           completion:nil];
}


/**
 *  请求的时候 弹出提示
 *
 *  @param otherMessage 如果不为空 直接提示这个错误 如果 为空 提示网络异常
 */
- (void)showRequestFailToast:(NSString *)otherMessage
{
    if(otherMessage && [otherMessage isKindOfClass:[NSString class]])
    {
        [self showWithText:otherMessage];
    }
    else
    {
//        if (![[MacroAppInfo shareManager] is_with_network]) {
//            [self showWithText:@"当前无网络"];
//        }
//        else
//        {
            [self showWithText:@"网络异常"];
//        }
    }
}



- (BOOL) containsSubView:(UIView *)subView
{
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL) containsSubViewOfClassType:(Class)aClass
{
    for (UIView *view in [self subviews]) {
        if ([view isMemberOfClass:aClass]) {
            return YES;
        }
    }
    return NO;
}

- (CGPoint) origin
{
    return self.frame.origin;
}

- (void) setOrigin:(CGPoint)newOrigin
{
    self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize) size
{
    return self.frame.size;
}

- (void) setSize:(CGSize)newSize
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newSize.width, newSize.height);
}

- (CGFloat) originX
{
    return self.frame.origin.x;
}

- (void) setOriginX:(CGFloat)originX
{
    self.frame = CGRectMake(originX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (void)setOriginY:(CGFloat)originY
{
    self.frame = CGRectMake(self.frame.origin.x, originY, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameRight
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setFrameRight:(CGFloat)newRight
{
    self.frame = CGRectMake(newRight - self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameBottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setFrameBottom:(CGFloat)newBottom
{
    self.frame = CGRectMake(self.frame.origin.x, newBottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameWidth
{
    return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)newWidth
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, self.frame.size.height);
}

- (CGFloat)frameHeight
{
    return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)newHeight
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newHeight);
}





- (void)animationDynamics
{
    //    [self.layer pop_removeAllAnimations];
    
    
    POPSpringAnimation *sizeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    sizeAnimation.velocity = [NSValue valueWithCGPoint:self.layer.position];
    sizeAnimation.springBounciness = 0.5f;
    sizeAnimation.dynamicsFriction = 5.0f;
    sizeAnimation.removedOnCompletion = YES;
    
    [sizeAnimation setCompletionBlock:^(POPAnimation * animtion, BOOL isSuccess) {
        
        
        [self.layer pop_removeAnimationForKey:@"sizeAnimationDynamics"];
        
    }];
    
    [self.layer pop_addAnimation:sizeAnimation forKey:@"sizeAnimationDynamics"];
    
    //
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];//必须写opacity才行。
    //    animation.fromValue = [NSNumber numberWithFloat:0.9f];
    //    animation.toValue = [NSNumber numberWithFloat:1.1f];//这是透明度。
    //    animation.autoreverses = YES;
    //    animation.duration = 0.2;
    //    animation.repeatCount = 1;
    //    animation.removedOnCompletion = YES;
    //    animation.fillMode = kCAFillModeForwards;
    //    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    //
    //    [self.layer addAnimation:animation forKey:@"transformScale"];
}


- (void)animationPopShowFinishBlock:(void (^)(UIView *))finishBlock
{
    //    [self.layer pop_removeAllAnimations];
    
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    scaleAnimation.fromValue  = [NSValue valueWithCGSize:CGSizeMake(0.1, 0.1)];
    scaleAnimation.toValue  = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    scaleAnimation.springBounciness = 15.f;
    scaleAnimation.springSpeed = 10;
    [scaleAnimation setCompletionBlock:^(POPAnimation * animation, BOOL issuccess) {
        
        if(finishBlock)
        {
            finishBlock(self);
        }
        
        [self.layer pop_removeAnimationForKey:@"scaleAnimationPopShow"];
    }];
    
    [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimationPopShow"];
}

- (void)animationPopHiddenFinishBlock:(void (^)(UIView *))finishBlock
{
    //    [self.layer pop_removeAllAnimations];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    scaleAnimation.toValue  = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    scaleAnimation.springBounciness = 15.f;
    scaleAnimation.springSpeed = 10;
    [scaleAnimation setCompletionBlock:^(POPAnimation * animation, BOOL issuccess) {
        
        if(finishBlock)
        {
            finishBlock(self);
        }
        [self.layer pop_removeAnimationForKey:@"scaleAnimationPopHidden"];
    }];
    
    [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimationPopHidden"];
    
}


- (void)animationDownUp
{
    //    [self.layer pop_removeAllAnimations];
    
    POPSpringAnimation * posYAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    posYAnimation.fromValue = @(self.center.y + 20);
    posYAnimation.toValue = @(self.center.y);
    posYAnimation.velocity = @2000;
    //反弹－－影响动画作用的参数变化幅度
    posYAnimation.springBounciness = 10;
    //动态晃动率
    posYAnimation.dynamicsMass = 5;
    posYAnimation.springSpeed = 12;
    posYAnimation.removedOnCompletion = YES;
    
    [posYAnimation setCompletionBlock:^(POPAnimation * animation, BOOL issuccess) {
        
        [self.layer pop_removeAnimationForKey:@"posYAnimationDownup"];
    }];
    
    [self.layer pop_addAnimation:posYAnimation forKey:@"posYAnimationDownup"];
}

- (void)animationUpDown
{
    //    [self.layer pop_removeAllAnimations];
    
    POPSpringAnimation * posYAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    posYAnimation.fromValue = @(self.center.y - 20);
    posYAnimation.toValue = @(self.center.y);
    posYAnimation.velocity = @2000;
    //反弹－－影响动画作用的参数变化幅度
    posYAnimation.springBounciness = 10;
    //动态晃动率
    posYAnimation.dynamicsMass = 5;
    posYAnimation.springSpeed = 12;
    posYAnimation.removedOnCompletion = YES;
    
    [posYAnimation setCompletionBlock:^(POPAnimation * animation, BOOL issuccess) {
        
        [self.layer pop_removeAnimationForKey:@"posYAnimationUpDown"];
    }];
    
    [self.layer pop_addAnimation:posYAnimation forKey:@"posYAnimationUpDown"];
}

/**
 *  从地下弹回来 一点点
 */
- (void)animationDownUpALittle
{
    POPSpringAnimation * posYAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    posYAnimation.fromValue = @(self.center.y + 0.1);
    posYAnimation.toValue = @(self.center.y);
    posYAnimation.velocity = @50;
    posYAnimation.springBounciness = 0.1;
    posYAnimation.dynamicsMass = 1;
    posYAnimation.springSpeed = 0.1;
    posYAnimation.removedOnCompletion = YES;
    
    [posYAnimation setCompletionBlock:^(POPAnimation * animation, BOOL issuccess) {
        
        [self.layer pop_removeAnimationForKey:@"animationDownUpALittle"];
    }];
    
    [self.layer pop_addAnimation:posYAnimation forKey:@"animationDownUpALittle"];

}


- (void)animationUpDownALittle
{
    POPSpringAnimation * posYAnimation1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    posYAnimation1.toValue = @(self.center.y - 10);
    posYAnimation1.fromValue = @(self.center.y);
    posYAnimation1.removedOnCompletion = YES;
    
    [posYAnimation1 setCompletionBlock:^(POPAnimation * animation, BOOL issuccess) {
        
        [self.layer pop_removeAnimationForKey:@"animationUpDownALittle1"];
    }];
    
    [self.layer pop_addAnimation:posYAnimation1 forKey:@"animationUpDownALittle1"];
    
    
    
    POPSpringAnimation * posYAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    posYAnimation.fromValue = @(self.center.y - 10);
    posYAnimation.toValue = @(self.center.y);
    posYAnimation.velocity = @20;
    posYAnimation.springBounciness = 0.1;
    posYAnimation.dynamicsMass = 1;
    posYAnimation.springSpeed = 0.1;
    posYAnimation.removedOnCompletion = YES;
    
    [posYAnimation setCompletionBlock:^(POPAnimation * animation, BOOL issuccess) {
        
        [self.layer pop_removeAnimationForKey:@"animationUpDownALittle"];
    }];
    
    [self.layer pop_addAnimation:posYAnimation forKey:@"animationUpDownALittle"];
}

/**
 *  上下翻转
 */
- (void)animationFlipX
{
    //    [self.layer pop_removeAllAnimations];
    
    POPBasicAnimation * rotationY = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationX];
    
    rotationY.fromValue = @(2*M_PI);
    rotationY.toValue = @(0);
    rotationY.removedOnCompletion = YES;
    
    [rotationY setCompletionBlock:^(POPAnimation * animation, BOOL issuccess) {
        
        [self.layer pop_removeAnimationForKey:@"posYAnimationFlip"];
    }];
    
    [self.layer pop_addAnimation:rotationY forKey:@"posYAnimationFlip"];
}


/**
 *  旋转二周
 */
- (void)animationRotateTwoCycleFinishBlock:(void (^)(UIView *))finishBlock
{
    //    [self.layer pop_removeAllAnimations];
    
    POPBasicAnimation * rotationY = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    rotationY.fromValue = @(4*M_PI);
    rotationY.toValue = @(0);
    rotationY.removedOnCompletion = YES;
    rotationY.duration = 1;
    
    [rotationY setCompletionBlock:^(POPAnimation * animation, BOOL issuccess) {
        if(finishBlock)
        {
            finishBlock(self);
        }
        [self.layer pop_removeAnimationForKey:@"rotateAnimationTwoCycle"];
    }];
    
    [self.layer pop_addAnimation:rotationY forKey:@"rotateAnimationTwoCycle"];
}

/**
 *  旋转一周
 */
- (void)animationRotateOneCycleFinishBlock:(void (^)(UIView *))finishBlock
{
    //    [self.layer pop_removeAllAnimations];
    
    POPBasicAnimation * rotationY = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    rotationY.fromValue = @(2*M_PI);
    rotationY.toValue = @(0);
    rotationY.removedOnCompletion = YES;
    rotationY.duration = 1;
    
    [rotationY setCompletionBlock:^(POPAnimation * animation, BOOL issuccess) {
        if(finishBlock)
        {
            finishBlock(self);
        }
        [self.layer pop_removeAnimationForKey:@"rotateAnimationOneCycle"];
    }];
    
    [self.layer pop_addAnimation:rotationY forKey:@"rotateAnimationOneCycle"];
}


- (void)animationRotateShakeWithDelayBegin:(float)delayTime withFinishBlock:(void (^)(UIView *))finishBlock
{
    //    [self.layer pop_removeAllAnimations];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    anim.beginTime = CACurrentMediaTime() + delayTime;
    anim.velocity = @(3);
    anim.springBounciness = 10.f;
    anim.springSpeed = 0.1;
    anim.velocity = @(10);
    anim.fromValue = @(M_PI_4);
    anim.toValue = @(0);
    
    //    anim.springBounciness = 10.0f;
    //    anim.dynamicsMass = 2.0f;
    //    anim.dynamicsTension = 200;
    
    //    anim.removedOnCompletion = YES;
    [anim setCompletionBlock:^(POPAnimation *animR, BOOL finished) {
        if(finishBlock)
        {
            finishBlock(self);
        }
        
        [self.layer pop_removeAnimationForKey:@"animationRotateShake"];
    }];
    [self.layer pop_addAnimation:anim forKey:@"animationRotateShake"];
    
}


- (void)animationDropDownWithDelayBegin:(float)delayTime
{
    //    [self.layer pop_removeAllAnimations];
    
    POPBasicAnimation* posYAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    posYAnimation.beginTime = CACurrentMediaTime() + delayTime;
    
    posYAnimation.toValue = @([UIScreen mainScreen].bounds.size.height);
    
    posYAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    posYAnimation.duration = 0.6;
    
    [posYAnimation setCompletionBlock:^(POPAnimation * animtion, BOOL isSuccess) {
        
        
        [self.layer pop_removeAnimationForKey:@"posYAnimationDropDown"];
        
    }];
    
    [self.layer pop_addAnimation:posYAnimation forKey:@"posYAnimationDropDown"];
}



- (void)animationBackgroundColor:(UIColor *)toColor
{
    //    [self.layer pop_removeAllAnimations];
    
    POPSpringAnimation * colorAnimation = [POPSpringAnimation animation];
    colorAnimation.property = [POPAnimatableProperty propertyWithName: kPOPLayerBackgroundColor];
    colorAnimation.toValue= toColor;
    
    [colorAnimation setCompletionBlock:^(POPAnimation * animtion, BOOL isSuccess) {
        
        
        [self.layer pop_removeAnimationForKey:@"colorAnimationChange"];
        
    }];
    
    [self.layer pop_addAnimation:colorAnimation forKey:@"colorAnimationChange"];
    
}

- (void)animationAlphaZero
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}

- (void)animationAlphaShow
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

/**
 *  警示动画
 */
- (void)animationWarning
{
    [self.layer removeAllAnimations];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = 0.1;
    animation.repeatCount = 3;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    
    [self.layer addAnimation:animation forKey:@"opacity"];
}


@end
