//
//  UIViewController+Banner.m
//  SuoShi
//
//  Created by 林宁宁 on 16/1/26.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "UIViewController+Banner.h"
#import "BannerManager.h"
#import <objc/runtime.h>
#import "MacroAppInfo.h"
#import "Masonry.h"
#import "UserInfoTool.h"


//#import <KeymobAd/KeymobAd.h>



@implementation UIViewController (Banner)




-(void)setBannerVGDT:(GDTMobBannerView *)bannerVGDT
{
    objc_setAssociatedObject(self, @selector(bannerVGDT), bannerVGDT, OBJC_ASSOCIATION_RETAIN);
}

-(void)setBannerShowBlock:(void (^)())bannerShowBlock
{
    objc_setAssociatedObject(self, @selector(bannerShowBlock), bannerShowBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setBannerCloseBlock:(void (^)())bannerCloseBlock
{
    objc_setAssociatedObject(self, @selector(bannerCloseBlock), bannerCloseBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(void)setBannerVGAD:(GADBannerView *)bannerVGAD
{
    objc_setAssociatedObject(self, @selector(bannerVGAD), bannerVGAD, OBJC_ASSOCIATION_RETAIN);
}




-(GDTMobBannerView *)bannerVGDT
{
    return objc_getAssociatedObject(self, @selector(bannerVGDT));
}

-(GADBannerView *)bannerVGAD
{
    return objc_getAssociatedObject(self, @selector(bannerVGAD));
}


-(void (^)())bannerShowBlock
{
    return objc_getAssociatedObject(self, @selector(bannerShowBlock));
}

-(void (^)())bannerCloseBlock
{
    return objc_getAssociatedObject(self, @selector(bannerCloseBlock));
}


-(NSNumber *)bannerTapClose
{
    return objc_getAssociatedObject(self, @selector(bannerTapClose));
}

-(void)setBannerTapClose:(NSNumber *)bannerTapClose
{
    objc_setAssociatedObject(self, @selector(bannerTapClose), bannerTapClose, OBJC_ASSOCIATION_RETAIN);
}



- (void)showBannerAtTop
{
    [self showBannerIsBottom:NO haveCloseBtn:NO];
}

- (void)showBannerTapToClose
{
    self.bannerTapClose = @(YES);
    [self showBannerAtTop];
}

- (void)showBanner
{
    [self showBannerIsBottom:YES haveCloseBtn:YES];
}

- (void)showBannerIsBottom:(BOOL)isBottom haveCloseBtn:(BOOL)haveCloseBtn
{
    [self bannerViewWillClose];
    
    if(self.bannerVGDT)
    {
        return;
    }
    
    if(self.bannerVGAD)
    {
        return;
    }
    
    ADItem * item = [[BannerManager shareManager] showAD];
    
    if([item.adType isEqualToString:@"gdt"])
    {
        //关闭ADMob的
        NSString * appkey = item.adKey;
        
        if(!appkey)
        {
            return;
        }
        
        NSString * bannerID = [item getShowBanner];
        
        if(!bannerID)
        {
            return;
        }
        
        if([UserInfoTool shareManager].userIdClosedAD)
        {
            //广告是关闭的 不需要加载
            return;
        }
        
        GDTMobBannerView * bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - [self bannerSize].height, CGRectGetWidth(self.view.frame), [self bannerSize].height)
                                                                         appkey:appkey
                                                                    placementId:bannerID];
        
        bannerView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:bannerView]; //添加到当前的view中
        
        
        __weak typeof(&*self)weakSelf = self;
        [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view);
            make.height.mas_equalTo([weakSelf bannerSize].height);
            if(isBottom)
            {
                make.bottom.equalTo(weakSelf.view);
            }
            else
            {
                make.top.equalTo(weakSelf.view);
            }
        }];
        
        self.bannerVGDT = bannerView;
        bannerView.delegate = self; // 设置Delegate
        bannerView.currentViewController = self; //设置当前的ViewController
        bannerView.interval = item.adTime; //【可选】设置广告轮播时间;范围为30~120秒,0表示不轮播
        bannerView.isGpsOn = NO; //【可选】开启GPS定位;默认关闭
        //        bannerView.showCloseBtn = haveCloseBtn; //【可选】展示关闭按钮;默认显示
        bannerView.isAnimationOn = YES; //【可选】开启banner轮播和展现时的动画效果;默认开启
        
        bannerView.backgroundColor = [UIColor clearColor];
        
        
        [bannerView loadAdAndShow]; //加载广告并展示
    }
    else
    {
        NSLog(@"%@",item);
        //关闭gdt的
        
        GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:[MacroAppInfo isPortrait]?kGADAdSizeSmartBannerPortrait:kGADAdSizeSmartBannerLandscape];
        bannerView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:bannerView];
        
        __weak typeof(&*self)weakSelf = self;
        [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view);
            make.height.mas_equalTo([weakSelf bannerSize].height);
            if(isBottom)
            {
                make.bottom.equalTo(weakSelf.view);
            }
            else
            {
                make.top.equalTo(weakSelf.view);
            }
        }];
        
        bannerView.delegate = self;
        
        self.bannerVGAD = bannerView;
        
        self.bannerVGAD.adUnitID = [item getShowBanner];
        self.bannerVGAD.rootViewController = self;
        
        GADRequest *request = [GADRequest request];
        //        // Requests test ads on devices you specify. Your test device ID is printed to the console when
        //        // an ad request is made. GADBannerView automatically returns test ads when running on a
        //        // simulator.
        //        request.testDevices = @[
        //        @"2077ef9a63d2b398840261c8221a0c9a"  // Eric's iPod Touch
        //        ];
        
        [self.bannerVGAD loadRequest:request];
        
    }
}


#pragma mark - ADMob 广告回调

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    [self.view bringSubviewToFront:self.bannerVGAD];
    if(self.bannerShowBlock)
    {
        self.bannerShowBlock();
    }
}

- (void)adView:(GADBannerView *)bannerView
didFailToReceiveAdWithError:(GADRequestError *)error
{
    [self closeBanner];
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView
{
    
}
- (void)adViewDidDismissScreen:(GADBannerView *)bannerView
{
    //    [self closeBanner];
    if([self.bannerTapClose boolValue])
    {
        [self closeBanner];
    }
}
- (void)adViewWillDismissScreen:(GADBannerView *)bannerView
{
    
}
- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView
{
    //    [self closeBanner];
    //    self.bannerVGAD
    if([self.bannerTapClose boolValue])
    {
        [self closeBanner];
    }
}




#pragma mark - 广点通广告回调

// 请求广告条数据成功后调用
- (void)bannerViewDidReceived
{
    [self.view bringSubviewToFront:self.bannerVGDT];
    //    NSLog(@"请求广告成功");
    if(self.bannerShowBlock)
    {
        self.bannerShowBlock();
    }
}
// 请求广告条数据失败后调用
- (void)bannerViewFailToReceived:(NSError *)error
{
    NSLog(@"请求广告失败%@",[error description]);
    
    [self closeBanner];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self showBanner];
    //    });
}

// 应用进入后台时调用
- (void)bannerViewWillLeaveApplication
{
    
}

// 广告条曝光回调
- (void)bannerViewWillExposure
{
    
}

// 广告条点击回调
- (void)bannerViewClicked
{
    //点击之后直接关闭掉
    //    [self closeBanner];
    if([self.bannerTapClose boolValue])
    {
        [self closeBanner];
    }
}



/**
 *  banner广告点击以后即将弹出全屏广告页
 */
- (void)bannerViewWillPresentFullScreenModal
{
    
}

/**
 *  banner广告点击以后弹出全屏广告页完毕
 */
- (void)bannerViewDidPresentFullScreenModal
{
    //    if(self.bannerShowed)
    //    {
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            self.bannerShowed();
    //        });
    //
    //    }
}

// banner条被用户关闭时调用
- (void)bannerViewWillClose
{
    [self closeBanner];
}


- (void)closeBanner
{
    for(UIView * subV in self.view.subviews)
    {
        if([subV isKindOfClass:[GDTMobBannerView class]])
        {
            GDTMobBannerView * bannerV = (GDTMobBannerView *)subV;
            bannerV.delegate = nil;
            bannerV.currentViewController = nil;
            [bannerV removeFromSuperview];
            bannerV = nil;
            self.bannerVGDT = nil;
        }
        else if ([subV isKindOfClass:[GADBannerView class]])
        {
            GADBannerView * bannerV = (GADBannerView *)subV;
            bannerV.delegate = nil;
            bannerV.rootViewController = nil;
            [bannerV removeFromSuperview];
            bannerV = nil;
            self.bannerVGAD = nil;
        }
    }
    
    if(self.bannerCloseBlock)
    {
        self.bannerCloseBlock();
    }
}


- (CGSize)bannerSize
{
    if([UserInfoTool shareManager].userIdClosedAD)
    {
        return CGSizeZero;
    }
    
    CGSize bannerSize = GDTMOB_AD_SUGGEST_SIZE_320x50;
    if([MacroAppInfo isiPad])
    {
        if([MacroAppInfo isPortrait])
        {
            bannerSize = GDTMOB_AD_SUGGEST_SIZE_468x60;
        }
        else
        {
            bannerSize = GDTMOB_AD_SUGGEST_SIZE_728x90;
        }
    }
    return bannerSize;
}



@end

