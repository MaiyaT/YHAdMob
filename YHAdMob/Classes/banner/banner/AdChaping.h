//
//  GDTBanner.h
//  LinTool
//
//  Created by 林宁宁 on 15/11/13.
//  Copyright © 2015年 000. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDTMobInterstitial.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface AdChaping : NSObject<GDTMobInterstitialDelegate,GADInterstitialDelegate>
{
    GDTMobInterstitial *_interstitialGDTObj;
    
    GADInterstitial * _interstitialADMob;
}

+ (AdChaping *)shareManager;

///**
// *  显示插屏广告
// */
//- (void)showAdChaPing;

/**
 *  加载显示插屏广告
 */
- (void)loadAdChaPing;

//- (void)removeChapinBanner;

@end
