//
//  GDTBanner.m
//  LinTool
//
//  Created by 林宁宁 on 15/11/13.
//  Copyright © 2015年 000. All rights reserved.
//

#import "AdChaping.h"
#import "BannerManager.h"
#import "UserInfoTool.h"


@implementation AdChaping

+(AdChaping *)shareManager
{
    static AdChaping * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AdChaping alloc] init];
    });
    return manager;
}



#pragma mark -------- 插屏广告


/**
 *  在适当的时候，初始化并调用loadAd方法进行预加载
 */
-(void)loadAdChaPing
{
    if([UserInfoTool shareManager].userIdClosedAD)
    {
        //广告是关闭的 不需要加载
        return;
    }
    
    if(_interstitialGDTObj)
    {
        return;
    }
    
    if(_interstitialADMob.hasBeenUsed)
    {
        return;
    }
    else if (_interstitialADMob)
    {
        [self clean];
    }
    
    ADItem * item = [[BannerManager shareManager] showAD];
    
    if([item.adType isEqualToString:@"gdt"])
    {
        NSLog(@"gdt插屏广告");
        _interstitialGDTObj = [[GDTMobInterstitial alloc] initWithAppkey:item.adKey placementId:item.adChaping];
        
        _interstitialGDTObj.delegate = self; //设置委托
        _interstitialGDTObj.isGpsOn = NO; //【可选】设置GPS开关
        
        
        //预加载广告
        [_interstitialGDTObj loadAd];
    }
    else
    {
        NSLog(@"admob插屏广告");
        GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:item.adChaping];
        
        _interstitialADMob = interstitial;
        
        interstitial.delegate = self;
        [interstitial loadRequest:[GADRequest request]];
    }
    
}




//- (void)removeChapinBanner
//{
//    UIViewController *vc = [[[UIApplication sharedApplication] keyWindow] rootViewController];
//
//    if(vc.presentedViewController)
//    {
//        [vc.presentedViewController dismissViewControllerAnimated:YES completion:nil];
//    }
//
//
//}

/**
 *  在适当的时候，调用presentFromRootViewController来展现插屏广告
 */
-(void)showAdChaPing
{
    [_interstitialGDTObj presentFromRootViewController:[self getCurrentShowVC]];
}

#pragma mark - 插屏代理

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    if ([_interstitialADMob isReady])
    {
        [_interstitialADMob presentFromRootViewController:[self getCurrentShowVC]];
    }
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"abmob 插屏加载失败");
    
    [self clean];
    
    [self showAdChaPing];
}


/**
 *  广告预加载成功回调
 *  详解:当接收服务器返回的广告数据成功后调用该函数
 */
- (void)interstitialSuccessToLoadAd:(GDTMobInterstitial *)interstitial
{
    [self showAdChaPing];
}

/**
 *  广告预加载失败回调
 *  详解:当接收服务器返回的广告数据失败后调用该函数
 */
- (void)interstitialFailToLoadAd:(GDTMobInterstitial *)interstitial error:(NSError *)error
{
    [self clean];
}

/**
 *  插屏广告将要展示回调
 *  详解: 插屏广告即将展示回调该函数
 */
- (void)interstitialWillPresentScreen:(GDTMobInterstitial *)interstitial
{
    
}

/**
 *  插屏广告视图展示成功回调
 *  详解: 插屏广告展示成功回调该函数
 */
- (void)interstitialDidPresentScreen:(GDTMobInterstitial *)interstitial
{
    
}

/**
 *  插屏广告展示结束回调
 *  详解: 插屏广告展示结束回调该函数
 */
- (void)interstitialDidDismissScreen:(GDTMobInterstitial *)interstitial
{
    [self clean];
}

/**
 *  应用进入后台时回调
 *  详解: 当点击下载应用时会调用系统程序打开，应用切换到后台
 */
- (void)interstitialApplicationWillEnterBackground:(GDTMobInterstitial *)interstitial
{
    
}

/**
 *  插屏广告曝光时回调
 *  详解: 插屏广告曝光时回调
 */
-(void)interstitialWillExposure:(GDTMobInterstitial *)interstitial
{
    
}
/**
 *  插屏广告点击时回调
 *  详解: 插屏广告点击时回调
 */
-(void)interstitialClicked:(GDTMobInterstitial *)interstitial
{
    
}
//广告加载失败的时候


- (UIViewController *)getCurrentShowVC
{
    UIViewController *vc = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if(vc.presentedViewController)
    {
        if([vc.presentedViewController isKindOfClass:[UINavigationController class]])
        {
            UINavigationController * navc = (UINavigationController *)vc.presentedViewController;
            if(navc.topViewController.presentedViewController)
            {
                return navc.topViewController.presentedViewController;
            }
            else
            {
                return navc.topViewController;
            }
        }
        else
        {
            return vc.presentedViewController;
        }
    }
    else
    {
        return vc;
    }
}


- (void)clean
{
    
    _interstitialGDTObj.delegate = nil;
    _interstitialGDTObj = nil;
    
    _interstitialADMob.delegate = nil;
    _interstitialADMob = nil;
    
}



@end
