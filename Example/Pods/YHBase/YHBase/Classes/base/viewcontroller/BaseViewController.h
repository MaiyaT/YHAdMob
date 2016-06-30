//
//  BaseViewController.h
//  LinTool
//
//  Created by 林宁宁 on 15/9/21.
//  Copyright © 2015年 000. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+BBX.h"



@interface BaseViewController : UIViewController
{
    /**
     *  是已经创建过视图的
     */
    BOOL _isBuildedWillAppear;
    
    
    BOOL _isBuildedDidAppear;
    
    BOOL _isBuildedWillAppearDealay;
    
    BOOL _isBuildedDidAppearDealay;
}


@property (nonatomic, strong) UIButton *navRightBar;
@property (nonatomic, strong) UIButton *navLeftBar;


/** 不能可以全屏幕滑动去pop上一级*/
@property (assign, nonatomic) BOOL cannotPanToPop;

/**
 *  自定义返回的按钮
 */
@property (assign, nonatomic) BOOL isCustomBackBtn;

/**
 *  不显示广告
 */
//@property (assign, nonatomic) BOOL isDonotShowBanner;

/**
 *  下个界面传递到上个界面的回调
 */
@property (copy, nonatomic) void(^passBlock)(id passValue);

#pragma mark - NavigationViewController

//  设置左边的按钮 之后 IOS7上面右滑返回的动作会失效

-(void)setLeftNavigationItemBarWithImg:(NSString *)imgURL andSelectImg:(NSString *)imgSelect andTitle:(NSString *)title andSelectTitle:(NSString *)selectTitle andEvent:(SEL)event andTarget:(id)target andSize:(CGSize)size andFinishBlock:(void(^)(UIButton *))barBtnBlock;

- (void)backEvent;

-(void)setRightNavigationItemBarWithImg:(NSString *)imgURL andSelectImg:(NSString *)imgSelect andTitle:(NSString *)title andSelectTitle:(NSString *)selectTitle andEvent:(SEL)event andTarget:(id)target andSize:(CGSize)size andFinishBlock:(void(^)(UIButton *))barBtnBlock;

- (void)setBackBarItem;


/**
 *  创建视图
 */
- (void)buildContentViewWillAppear;

/**
 *  视图出现之后再创建视图
 */
- (void)buildContentViewDidAppear;

/**
 *  延时创建视图
 */
- (void)buildContentViewWillAppearDelay;

/**
 *  视图出现之后 延迟执行的
 */
- (void)buildContentViewDidAppearDelay;

/**
 *  视图要释放
 */
- (void)viewWillDeallocEvent;


/**
 *  设置返回的按钮
 */
- (void)setLeftPopback;


/**
 *  显示广告
 */
//- (void)showBanner;

@end
