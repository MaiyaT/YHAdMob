//
//  UIViewController+IAP.m
//  SuoShi
//
//  Created by 林宁宁 on 16/4/14.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "UIViewController+IAP.h"
#import "IAPShare.h"
#import "AppConfigNote.h"
#import "SVProgressHUD.h"

@implementation UIViewController (IAP)

- (void)iapPurasheWithProductID:(NSString *)productID withFinishBlock:(void (^)(BOOL))finishBlock
{
    
    if(!productID)
    {
        if(finishBlock)
        {
            finishBlock(NO);
        }
        return;
    }
    
    NSSet* dataSet = [[NSSet alloc] initWithObjects:productID, nil];
    
    [IAPShare sharedHelper].iap = [[IAPHelper alloc] initWithProductIdentifiers:dataSet];

    
    [SVProgressHUD show];
    
    [IAPShare sharedHelper].iap.production = !isDebug;
    
    [[IAPShare sharedHelper].iap requestProductsWithCompletion:^(SKProductsRequest* request,SKProductsResponse* response)
     {
         if(response > 0 )
         {
             SKProduct* product =[[IAPShare sharedHelper].iap.products objectAtIndex:0];
         
             [[IAPShare sharedHelper].iap buyProduct:product onCompletion:^(SKPaymentTransaction *trans) {
                 if(trans.error)
                 {
                     if(finishBlock)
                     {
                         finishBlock(NO);
                     }
                     NSLog(@"Fail %@",[trans.error localizedDescription]);
                     
                     [SVProgressHUD showErrorWithStatus:@"支付失败"];
                 }
                 else if(trans.transactionState == SKPaymentTransactionStatePurchased)
                 {
                     
                     if(finishBlock)
                     {
                         finishBlock(YES);
                     }
                     
                     [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                     
                 }
                 else if(trans.transactionState == SKPaymentTransactionStateFailed) {
                     NSLog(@"Fail");
                     if(finishBlock)
                     {
                         finishBlock(NO);
                     }
                     
                     [SVProgressHUD showErrorWithStatus:@"支付失败"];
                 }
                 else if(trans.transactionState == SKPaymentTransactionStateRestored) {

                     if(finishBlock)
                     {
                         finishBlock(YES);
                     }
                     
                     [SVProgressHUD showSuccessWithStatus:@"已购买过"];
                 }
                 
             }];//end of buy product
         }
     }];

}


- (void)iapRestoreWithProductID:(NSString *)productID withFinishBlock:(void (^)(BOOL))finishBlock
{
    if(!productID)
    {
        if(finishBlock)
        {
            finishBlock(NO);
        }
        return;
    }
    
    NSSet* dataSet = [[NSSet alloc] initWithObjects:productID, nil];
    
    [IAPShare sharedHelper].iap = [[IAPHelper alloc] initWithProductIdentifiers:dataSet];
    
    
    [SVProgressHUD show];
    
    [IAPShare sharedHelper].iap.production = !isDebug;
    
    [[IAPShare sharedHelper].iap restoreProductsWithCompletion:^(SKPaymentQueue *payment, NSError *error) {
        
        [SVProgressHUD dismiss];

        for (SKPaymentTransaction *transaction in payment.transactions)
        {
            NSString *purchased = transaction.payment.productIdentifier;
            if([purchased isEqualToString:productID])
            {
                //enable the prodcut here
                if(finishBlock)
                {
                    finishBlock(YES);
                }
                
                break;
            }
        }
    }];
}

@end
