//
//  AdNativeView.m
//  SuoShi
//
//  Created by 林宁宁 on 16/3/29.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "AdNativeView.h"
#import "BannerManager.h"

@implementation AdNativeView

-(void)buildNativeADAtViewController:(UIViewController *)vc
{
    /*
     * 创建原生广告
     * "appkey" 指在 http://e.qq.com/dev/ 能看到的app唯一字符串
     * "placementId" 指在 http://e.qq.com/dev/ 生成的数字串，广告位id
     *
     * 本原生广告位ID在联盟系统中创建时勾选的详情图尺寸为1280*720，开发者可以根据自己应用的需要
     * 创建对应的尺寸规格ID
     *
     * 这里详情图以1280*720为例
     */
    
    
    ADItem * item = [[BannerManager shareManager] showAD];
    
    if([item.adType isEqualToString:@"gdt"])
    {
        _nativeAd = [[GDTNativeAd alloc] initWithAppkey:item.adKey placementId:item.adChaping];
        _nativeAd.controller = vc;
        _nativeAd.delegate = self;
        

        
        /*
         * 拉取广告,传入参数为拉取个数。
         * 发起拉取广告请求,在获得广告数据后回调delegate
         */
        [_nativeAd loadAd:30]; //这里以一次拉取一条原生广告为例
    }

}


- (void)attach
{
    if(self.dataList.count == 0)
    {
        return;
    }
    /*选择展示广告*/
    _currentAd = self.dataList[(arc4random()%1000)%self.dataList.count];
    
    /*开始渲染广告界面*/
    UIView * adView = [[UIView alloc] initWithFrame:CGRectMake(320, 20, 320, 250)];
    adView.layer.borderWidth = 1;
    
    /*广告详情图*/
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(2, 70, 316, 176)];
    [adView addSubview:imgV];
    NSURL *imageURL = [NSURL URLWithString:[_currentAd.properties objectForKey:GDTNativeAdDataKeyImgUrl]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            imgV.image = [UIImage imageWithData:imageData];
        });
    });
    
    /*广告Icon*/
    UIImageView *iconV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
    [adView addSubview:iconV];
    NSURL *iconURL = [NSURL URLWithString:[_currentAd.properties objectForKey:GDTNativeAdDataKeyIconUrl]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:iconURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            iconV.image = [UIImage imageWithData:imageData];
        });
    });
    
    /*广告标题*/
    UILabel *txt = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 100, 35)];
    txt.text = [_currentAd.properties objectForKey:GDTNativeAdDataKeyTitle];
    [adView addSubview:txt];
    
    /*广告描述*/
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, 200, 20)];
    desc.text = [_currentAd.properties objectForKey:GDTNativeAdDataKeyDesc];
    [adView addSubview:desc];
    
    [self addSubview:adView];
    
    /*注册点击事件*/
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [adView addGestureRecognizer:tap];
    
    
    /*
     * 广告数据渲染完毕，即将展示时需调用AttachAd方法。
     */
    [_nativeAd attachAd:_currentAd toView:adView];
    
}



- (void)viewTapped:(UITapGestureRecognizer *)gr {
    /*点击发生，调用点击接口*/
    [_nativeAd clickAd:_currentAd];
}



-(void)nativeAdSuccessToLoad:(NSArray *)nativeAdDataArray
{
    NSLog(@"%s",__FUNCTION__);
    /*广告数据拉取成功，存储并展示*/
    self.dataList = [NSMutableArray arrayWithArray:nativeAdDataArray];
    
    [self attach];
}

-(void)nativeAdFailToLoad:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
    /*广告数据拉取失败*/
    [self.dataList removeAllObjects];
}

/**
 *  原生广告点击之后将要展示内嵌浏览器或应用内AppStore回调
 */
- (void)nativeAdWillPresentScreen
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  原生广告点击之后应用进入后台时回调
 */
- (void)nativeAdApplicationWillEnterBackground
{
    NSLog(@"%s",__FUNCTION__);
}


@end
