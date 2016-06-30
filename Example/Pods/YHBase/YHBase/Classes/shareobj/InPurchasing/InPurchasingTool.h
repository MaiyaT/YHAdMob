//
//  InPurchasingTool.h
//  SuoShi
//
//  Created by 林宁宁 on 16/3/9.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "AppConfigNote.h"


@interface InPurchasingTool : NSObject<SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (copy, nonatomic) NSString * productID;


@property (copy, nonatomic) void(^purchaseBlock)(BOOL isSuccess, NSString * message);


/**
 *  购买
 */
- (void)requestBeginPurchaseWithProduceID:(NSString *)productID andFinishBlock:(void(^)(BOOL isSuccess, NSString * message))purchaseBlock;

/**
 *  恢复交易
 */
- (void)requestRestoreWithProduceID:(NSString *)productID andFinishBlock:(void(^)(BOOL isSuccess, NSString * message))purchaseBlock;

@end
