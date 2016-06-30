//
//  BMobRequest.h
//  SuoShi
//
//  Created by 林宁宁 on 16/3/12.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/BmobObject.h>
//#import "BmobObject.h"

@interface BMobRequest : NSObject


/**
 *  请求配置的信息
 */
+ (void)requestGetAppConfig;

/**
 *  支付成功之后 保存订单的信息
 */
+ (void)requestPurchasedFinishWithMoney:(NSString *)money andComboType:(NSInteger)type andOrderID:(NSString *)orderID andStartTime:(NSString *)startTime andFinishBlock:(void (^)())finishBlock;


/**
 *  备份数据支付成功之后
 */
+ (void)requestCouponPurchasedFinishWithMoney:(NSString *)money andComboType:(NSInteger)type andOrderID:(NSString *)orderID andOrderTime:(NSString *)orderTime andFinishBlock:(void (^)())finishBlock;

/**
 *  查询用户是否开通上传多媒体的套餐
 */
+ (void)requestQueryUserIsOpenMultiMediaBlock:(void(^)(BmobObject * responseObj, BOOL isRequestSuccess))finishBlock;

/**
 *  查询某个订单的信息
 */
//+ (void)requestQueryInfoWithObjectID:(NSString *)objectid withFinishBlock:(void(^)(BmobObject * responseObj))finishBlock;




/**
 *  订单时间到期了 更新这个订单的状态
 */
+ (void)requestOrderIsOutDateWithOrderID:(NSString *)orderID;

/**
 *  查询用户可用的订单 套餐时间还未过期的
 */
+ (void)requestQueryUserAvailableOrderBlock:(void(^)(BmobObject * responseObj, BOOL isRequestSuccess))finishBlock;




/**
 *  关闭广告
 */
+ (void)requestUpdateUserCloseAD;

/**
 *  更新用户的ObjectID
 */
+ (void)requestUpdateUserObjectID;




@end
