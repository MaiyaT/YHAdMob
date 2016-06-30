//
//  PopAnimationV.h
//  直播吧
//
//  Created by 林宁宁 on 15/1/6.
//
//

#import <UIKit/UIKit.h>

@interface PopAnimationV : UIView

@property (assign, nonatomic) CGRect popContentFrame;

@property (retain, nonatomic) UIView * popSuperV;

/** content包括 head middle bottom三个部分*/
@property (retain, nonatomic) UIView * popContentV;

@property (retain, nonatomic) UIView * popMiddleV;
@property (retain, nonatomic) UIView * popBottomV;

@property (assign, nonatomic) int popWidth;

-(void)tapBackgroundEvent;

-(instancetype)initWithFrame:(CGRect)frame popVAddToSuperview:(UIView *)superV andWithBgAlpha:(float)alpha;

- (void)creatContentVWithTop:(UIView *)topV andBottom:(UIView *)bottomV andMid:(UIView *)midV andHaveLine:(BOOL)hline;


- (void)popDismiss;

- (void)popShow;

- (void)popShowWithBG:(BOOL)withBg;

@end
