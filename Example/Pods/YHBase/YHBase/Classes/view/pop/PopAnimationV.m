//
//  PopAnimationV.m
//  直播吧
//
//  Created by 林宁宁 on 15/1/6.
//
//

#import "PopAnimationV.h"

//#import "UIImage+AHKAdditions.h"
//#import "UIWindow+AHKAdditions.h"
#import "UIColor+BBXApp.h"

#import "UIColor+BBXApp.h"

@interface PopAnimationV()
{
    
    UIView * _popTopV;
    
//    UIImageView * _popBgImgV;
    
    UIView * _popBgV;
}




@end



@implementation PopAnimationV

-(instancetype)initWithFrame:(CGRect)frame popVAddToSuperview:(UIView *)superV andWithBgAlpha:(float)alpha
{
    self = [super initWithFrame:superV.bounds];
    if(self)
    {
        UIView * bgV = [[UIView alloc]initWithFrame:superV.bounds];
        bgV.autoresizingMask = 0xff;
        bgV.backgroundColor = alpha==0?[UIColor clearColor]:[[UIColor blackColor] colorWithAlphaComponent:alpha];
        [self addSubview:bgV];
        
        UITapGestureRecognizer * tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundEvent)];
        [bgV addGestureRecognizer:tapgesture];
        
        UIView * contentV = [[UIView alloc]init];
        contentV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.popContentV = contentV;
        contentV.backgroundColor = [UIColor clearColor];
        [self addSubview:contentV];
        
        UIView * popV = [[UIView alloc]init];
//        popV.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _popTopV = popV;
        popV.backgroundColor = [UIColor clearColor];
        [contentV addSubview:popV];
        
        UIView * popM = [[UIView alloc]init];
//        popM.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.popMiddleV = popM;
        popM.backgroundColor = [UIColor clearColor];
        [contentV addSubview:popM];
        
        UIView * popB = [[UIView alloc]init];
//        popB.autoresizingMask = UIViewAutoresizingFlexibleTopMargin; //UIViewAutoresizingFlexibleWidth;
        self.popBottomV = popB;
        popB.backgroundColor = [UIColor clearColor];
        [contentV addSubview:popB];
        
        self.popSuperV = superV;
        
    }
    return self;
}


- (void)creatContentVWithTop:(UIView *)topV andBottom:(UIView *)bottomV andMid:(UIView *)midV andHaveLine:(BOOL)hline
{
    float offy = 0;
    float contentW = 0;
    
    if(topV)
    {
        _popTopV.backgroundColor = topV.backgroundColor;
        [_popTopV addSubview:topV];
        
        float w = CGRectGetWidth(topV.frame);
        float h = CGRectGetHeight(topV.frame);
        
        contentW = MAX(contentW, w);
        
        _popTopV.frame = CGRectMake(0, offy, w, h);
        
        offy += h;
        
        if(hline)
        {
            UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(0, h-0.5, w, 0.5)];
            lineV.backgroundColor = [UIColor bbxBorderAndSepartionLineColor];
            lineV.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
            [_popTopV addSubview:lineV];
        }
    }
    
    
    if(midV)
    {
        self.popMiddleV.backgroundColor = midV.backgroundColor;
        [self.popMiddleV addSubview:midV];
        
        float w = CGRectGetWidth(midV.frame);
        float h = CGRectGetHeight(midV.frame);
        
        contentW = MAX(contentW, w);
        
        self.popMiddleV.frame = CGRectMake(0, offy, w, h);
        
        offy += h;
        
        if(hline)
        {
            UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(0, h-0.5, w, 0.5)];
            lineV.backgroundColor = [UIColor bbxBorderAndSepartionLineColor];
            lineV.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
            [self.popMiddleV addSubview:lineV];
        }
    }
    
    
    if(bottomV)
    {
        self.popBottomV.backgroundColor = bottomV.backgroundColor;
//        bottomV.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self.popBottomV addSubview:bottomV];
        
        float w = CGRectGetWidth(bottomV.frame);
        float h = CGRectGetHeight(bottomV.frame);
        
        contentW = MAX(contentW, w);
        
        self.popBottomV.frame = CGRectMake(0, offy, w, h);
        
        offy += h;
    }
    
    float wid = CGRectGetWidth(self.frame);
    int offCy = (CGRectGetHeight(self.frame) - offy)/2;
    float offx = (wid - contentW)/2;
    
    self.popContentFrame = CGRectMake(offx, offCy, contentW, offy);
    
    self.popContentV.frame = self.popContentFrame;
    
}


//- (UIImage *)getBlurImage
//{
//    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
//    UIImage * winShot = [keyWindow ahk_snapshot];
//    
//#define BLUR_RADIUS         10
//#define BLUR_COLOR          [RGB(30, 30, 30) colorWithAlphaComponent:0.5]
//#define BLUR_FACTOR         1.8
//    
//    UIImage * blurImg = [winShot ahk_applyBlurWithRadius:BLUR_RADIUS tintColor:BLUR_COLOR saturationDeltaFactor:BLUR_FACTOR maskImage:nil];
//    
//    return blurImg;
//}

- (void)tapBackgroundEvent
{
    
}

- (void)popDismiss
{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        _popContentV.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
        self.alpha = 0.3;
//        _popBgImgV.alpha = 0;
        _popBgV.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)popShow
{
    [self popShowWithBG:YES];
}

- (void)popShowWithBG:(BOOL)withBg
{
    if(self.popSuperV)
    {
        self.autoresizingMask = 0xff;
        [self.popSuperV addSubview:self];
    }
    
    if(!_popBgV && withBg)
    {
        _popBgV = [[UIView alloc] initWithFrame:self.bounds];
        _popBgV.alpha = 0;
        _popBgV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:_popBgV];
        [self sendSubviewToBack:_popBgV];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _popBgV.alpha = 1;
    }];
    
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    bounceAnimation.values = @[
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)],
                               ];
    
    bounceAnimation.duration = 0.3f;
    
    bounceAnimation.fillMode = kCAFillModeForwards;
    
    [_popContentV.layer addAnimation:bounceAnimation forKey:@"popAnimation"];
}

@end
