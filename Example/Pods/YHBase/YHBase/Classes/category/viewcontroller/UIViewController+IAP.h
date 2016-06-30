//
//  UIViewController+IAP.h
//  SuoShi
//
//  Created by 林宁宁 on 16/4/14.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (IAP)

- (void)iapPurasheWithProductID:(NSString *)productID withFinishBlock:(void(^)(BOOL isSuccess))finishBlock;

- (void)iapRestoreWithProductID:(NSString *)productID withFinishBlock:(void(^)(BOOL isSuccess))finishBlock;;

@end
