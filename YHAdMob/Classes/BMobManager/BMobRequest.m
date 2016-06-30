//
//  BMobRequest.m
//  SuoShi
//
//  Created by 林宁宁 on 16/3/12.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BMobRequest.h"
#import <BmobSDK/Bmob.h>
#import "BannerManager.h"
#import "MacroAppInfo.h"
#import "SCLAlertView.h"
#import "UIColor+BBXApp.h"
#import "AppDelegateBase.h"
#import "UserInfoTool.h"
#import "NSString+BBX.h"
#import "NSDate+BBX.h"
#import "AppConfigNote.h"


@implementation BMobRequest

/**
 *  请求广告的信息
 */
+ (void)requestGetAppConfig
{
    //创建BmobQuery实例，指定对应要操作的数据表名称
    BmobQuery *query = [BmobQuery queryWithClassName:BMOB_TAB_NAME_CONFIG_APP];
    //按updatedAt进行降序排列
    [query orderByDescending:@"updatedAt"];
    
    //返回最多20个结果
    query.limit = 20;
    
    [query whereKey:@"version" containedIn:@[AD_CONFIG_VERSION]];
    [query whereKey:@"isused" containedIn:@[@(YES)]];
    
    //执行查询
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        //处理查c询结果
        if([array isKindOfClass:[NSArray class]])
        {
            BmobObject * obj;
            if(array.count > 0)
            {
                obj = array[(arc4random()%1000)%array.count];
            }
            else
            {
                obj= [array firstObject];
            }
            if([obj isKindOfClass:[BmobObject class]])
            {
                NSString * kaipin = [obj objectForKey:@"JsonStr"];
                
                BOOL isInChina = [[obj objectForKey:@"isInChina"] boolValue];
                
                if(isChina)
                {
                    [AppConfigNote shareManager].noteAPPIsInChina = isInChina;
                }
                
                NSDictionary * configDic = [NSJSONSerialization JSONObjectWithData:[kaipin dataUsingEncoding:4] options:NSJSONReadingMutableContainers error:nil];
                
                if([configDic isKindOfClass:[NSDictionary class]])
                {
                    [[BannerManager shareManager] updateContentWithDataDic:configDic];
                    
                    [[BannerManager shareManager] saveToLocal];
                    
                }
            }
        }
        
    }];
}


/**
 *  支付成功之后
 */
+ (void)requestPurchasedFinishWithMoney:(NSString *)money andComboType:(NSInteger)type andOrderID:(NSString *)orderID andStartTime:(NSString *)startTime andFinishBlock:(void (^)())finishBlock
{
    BmobObject * orderInfo = [BmobObject objectWithClassName:BMOB_TAB_NAME_ORDER_AD];
    [orderInfo setObject:[UserInfoTool shareManager].userID forKey:@"uidqq"];
    [orderInfo setObject:money forKey:@"paymoney"];
    [orderInfo setObject:@(type) forKey:@"type"];
    [orderInfo setObject:orderID forKey:@"orderid"];
    [orderInfo setObject:startTime forKey:@"starttime"];
    [orderInfo setObject:@(NO) forKey:@"isoutdate"];
    
    [orderInfo saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if(!isSuccessful)
        {
            orderInfo.objectId = @"10001";
        }
        
        if(finishBlock)
        {
            finishBlock();
        }
    }];
}



/**
 *  备份数据支付成功之后
 */
+ (void)requestCouponPurchasedFinishWithMoney:(NSString *)money andComboType:(NSInteger)type andOrderID:(NSString *)orderID andOrderTime:(NSString *)orderTime andFinishBlock:(void (^)())finishBlock
{
    BmobObject * orderInfo = [BmobObject objectWithClassName:BMOB_TAB_NAME_ORDER];
    [orderInfo setObject:[UserInfoTool shareManager].userID forKey:@"uidqq"];
    [orderInfo setObject:money forKey:@"price"];
    [orderInfo setObject:@(type) forKey:@"type"];
    [orderInfo setObject:orderID forKey:@"orderid"];
    [orderInfo setObject:orderTime forKey:@"ordertime"];
    
    [orderInfo saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if(!isSuccessful)
        {
            orderInfo.objectId = @"10001";
        }
        
        if(finishBlock)
        {
            finishBlock();
        }
    }];
}


/**
 *  查询用户是否开通上传多媒体的套餐
 */
+ (void)requestQueryUserIsOpenMultiMediaBlock:(void (^)(BmobObject *, BOOL))finishBlock
{
    BmobQuery *query = [BmobQuery queryWithClassName:BMOB_TAB_NAME_ORDER];
    query.limit = 20;
    
    [query whereKey:@"uidqq" containedIn:@[[UserInfoTool shareManager].userID]];
    [query whereKey:@"type" containedIn:@[@(3)]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if(!error)
        {
            if(finishBlock)
            {
                finishBlock([array firstObject],YES);
            }
        }
        else
        {
            if(finishBlock)
            {
                finishBlock(nil,NO);
            }
        }
    }];
}



/**
 *  订单时间到期了 更新这个订单的状态
 */
+ (void)requestOrderIsOutDateWithOrderID:(NSString *)orderID
{
    
//    [obj setObject:@(YES) forKey:@"isoutdate"];
//    //异步更新数据
//    [obj updateInBackground];
    
    if(!orderID)
    {
        return;
    }
    
    BmobQuery *query = [BmobQuery queryWithClassName:BMOB_TAB_NAME_ORDER_AD];
    query.limit = 20;
    
    [query whereKey:@"orderid" containedIn:@[orderID]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
       
        NSLog(@"############ 设置订单的状态是已过期的");
        
        if(!error)
        {
            for(BmobObject * obj in array)
            {
                [obj setObject:@(YES) forKey:@"isoutdate"];
                //异步更新数据
                [obj updateInBackground];
            }
        }
    }];
}


///**
// *  查询某个订单的信息
// */
//+ (void)requestQueryInfoWithObjectID:(NSString *)objectid withFinishBlock:(void (^)(BmobObject *))finishBlock
//{
//    BmobQuery   *bquery = [BmobQuery queryWithClassName:BMOB_TAB_NAME_ORDER_AD];
//
//    [bquery getObjectInBackgroundWithId:objectid block:^(BmobObject *object,NSError *error){
//        if (error)
//        {
//            if(finishBlock)
//            {
//                finishBlock(nil);
//            }
//        }
//        else
//        {
//            if(finishBlock)
//            {
//                finishBlock(object);
//            }
//        }
//    }];
//}



/**
 *  查询用户可用的订单 套餐时间还未过期的
 */
+ (void)requestQueryUserAvailableOrderBlock:(void (^)(BmobObject *, BOOL))finishBlock
{
    BmobQuery *query = [BmobQuery queryWithClassName:BMOB_TAB_NAME_ORDER_AD];
    query.limit = 20;
    
    [query whereKey:@"uidqq" containedIn:@[[UserInfoTool shareManager].userID]];
    [query whereKey:@"isoutdate" containedIn:@[@(NO)]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if(!error)
        {
            if(finishBlock)
            {
                finishBlock([array firstObject],YES);
            }
        }
        else
        {
            if(finishBlock)
            {
                finishBlock(nil,NO);
            }
        }
    }];
}





/**
 *  关闭广告
 */
+ (void)requestUpdateUserCloseAD
{
    [UserInfoTool shareManager].userIdClosedAD = YES;
    
    [[UserInfoTool shareManager] saveToLocal];
    
    if(![UserInfoTool shareManager].userObjectID)
    {
        return;
    }
    
    BmobObject * orderInfo = [BmobObject objectWithClassName:BMOB_TAB_NAME_UINFO];
    orderInfo.objectId = [UserInfoTool shareManager].userObjectID;
    [orderInfo setObject:@(YES) forKey:@"ad"];
    
    [orderInfo updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
    }];
}

/**
 *  更新用户的ObjectID
 */
+ (void)requestUpdateUserObjectID
{
    BmobQuery *query = [BmobQuery queryWithClassName:BMOB_TAB_NAME_UINFO];
    query.limit = 20;
    
    [query whereKey:@"uid" containedIn:@[[UserInfoTool shareManager].userID]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if(array.count == 0)
        {
            //插入一个
            BmobObject * userInfo = [BmobObject objectWithClassName:BMOB_TAB_NAME_UINFO];
            [userInfo setObject:[UserInfoTool shareManager].userID forKey:@"uid"];
            [userInfo setObject:[UserInfoTool shareManager].userName forKey:@"uname"];
            [userInfo setObject:@([UserInfoTool shareManager].userIdClosedAD) forKey:@"ad"];
            
            
            [userInfo saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                
                if(isSuccessful)
                {
                    [UserInfoTool shareManager].userObjectID = userInfo.objectId;
                    [[UserInfoTool shareManager] saveToLocal];
                }
            }];
        }
        else
        {
            BmobObject * userInfo = [array firstObject];
            BOOL adClose = [[userInfo objectForKey:@"ad"] boolValue];
            
            if(![UserInfoTool shareManager].userIdClosedAD)
            {
                [UserInfoTool shareManager].userIdClosedAD = adClose;
            }
            else if(!adClose)
            {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    [BMobRequest requestUpdateUserCloseAD];
                });
            }

            [UserInfoTool shareManager].userObjectID = userInfo.objectId;
            [[UserInfoTool shareManager] saveToLocal];
        }
    }];
}





@end
