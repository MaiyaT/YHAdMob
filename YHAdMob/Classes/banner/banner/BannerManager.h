//
//  BannerManager.h
//  BannerBrush
//
//  Created by 林宁宁 on 15/11/4.
//  Copyright © 2015年 000. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ADItem;

@interface BannerManager : NSObject

//@property (nonatomic, copy) NSString * appkey;
//
///**
// *  广告位的ID
// */
//@property (nonatomic, retain) NSMutableArray * appPosIDList;
//
///**
// *  开屏广告
// */
//@property (nonatomic, copy) NSString * appKaiPingID;
//
///**
// *  差评广告的ID
// */
//@property (nonatomic, copy) NSString * appChaPinID;
//
//
//@property (nonatomic, assign) NSInteger appBannerTime;


@property (retain, nonatomic) NSArray * appADList;

/**
 *  广点通的显示概率
 */
@property (assign, nonatomic) float appADScaleGDT;

/**
 *  是否显示 showadclose
 */
//@property (nonatomic, assign) BOOL appIsCheckFinish;

+ (BannerManager *)shareManager;

/**
 *  保存到本地
 */
- (void)saveToLocal;

/**
 *  根据概率看显示什么广告
 */
- (ADItem *)showAD;

//- (NSString *)getBannerID;

- (void)updateContentWithDataDic:(NSDictionary *)dataDic;


@end


@interface ADItem : NSObject

@property (copy, nonatomic) NSString * adType;
@property (copy, nonatomic) NSString * adKey;
@property (copy, nonatomic) NSString * adChaping;
@property (copy, nonatomic) NSString * adKaiping;
@property (retain, nonatomic) NSArray * adPosList;
@property (assign, nonatomic) int adTime;

- (instancetype)initWithDataDic:(NSDictionary *)dataDic;

- (NSDictionary *)getADDataDic;

- (NSString *)getShowBanner;

@end

