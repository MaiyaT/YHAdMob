//
//  UIViewController+Banner.h
//  SuoShi
//
//  Created by 林宁宁 on 16/1/26.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GDTMobBannerView.h"
#import <GoogleMobileAds/GADBannerView.h>


@interface UIViewController (Banner)<GDTMobBannerViewDelegate,GADBannerViewDelegate>

//广点通的
@property (retain, nonatomic) GDTMobBannerView * bannerVGDT;

//abmob的
@property (retain, nonatomic) GADBannerView * bannerVGAD;

/**
 *  点击之后关闭
 */
@property (retain, nonatomic) NSNumber * bannerTapClose;

@property (copy, nonatomic) void(^bannerShowBlock)();
@property (copy, nonatomic) void(^bannerCloseBlock)();

- (void)showBanner;

- (void)showBannerTapToClose;

- (void)showBannerAtTop;

- (CGSize)bannerSize;
//- (void)showBanner;
//
//
//- (void)hiddenBanner;
//
//
//- (void)showChaping;

@end






/**
 *  说明
 *  http://www.keymob.com/tutorial_zh/index.html
 *
 */
