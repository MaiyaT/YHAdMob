//
//  AdNativeView.h
//  SuoShi
//
//  Created by 林宁宁 on 16/3/29.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDTNativeAd.h"

/**
 *  原生广告
 */
@interface AdNativeView : UIView<GDTNativeAdDelegate>

/** 原生广告实例*/
@property (retain, nonatomic) GDTNativeAd * nativeAd;

/** 当前展示的原生广告数据对象*/
@property (retain, nonatomic) GDTNativeAdData * currentAd;

/** 原生广告数据数组*/
@property (retain, nonatomic) NSMutableArray * dataList;


- (void)buildNativeADAtViewController:(UIViewController *)vc;

@end
