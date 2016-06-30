//
//  InPurchasingTool.m
//  SuoShi
//
//  Created by 林宁宁 on 16/3/9.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "InPurchasingTool.h"

@interface InPurchasingTool()



//@property (assign, nonatomic) BOOL isLoading;

@end

@implementation InPurchasingTool

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}


/**
 *  恢复交易
 */
- (void)requestRestoreWithProduceID:(NSString *)productID andFinishBlock:(void (^)(BOOL, NSString *))purchaseBlock
{
    NSParameterAssert(productID);
    
    self.productID = productID;
    self.purchaseBlock = purchaseBlock;
    
//    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)requestBeginPurchaseWithProduceID:(NSString *)productID andFinishBlock:(void (^)(BOOL, NSString *))purchaseBlock
{
    NSParameterAssert(productID);
    
    self.productID = productID;
    self.purchaseBlock = purchaseBlock;

    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    if([SKPaymentQueue canMakePayments]){
        [self requestProduct];
    }else{
        NSLog(@"不允许程序内付费");

        if(purchaseBlock)
        {
            purchaseBlock(NO,@"不允许程序内付费");
        }
    }
}


//请求商品
- (void)requestProduct
{
    NSLog(@"-------------请求对应的产品信息----------------");
    NSArray *product = [[NSArray alloc] initWithObjects:self.productID, nil];
    
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
    
}

//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        NSLog(@"--------------没有商品------------------");

        if(self.purchaseBlock)
        {
            self.purchaseBlock(NO,@"没有该商品服务");
        }
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {

        if([pro.productIdentifier isEqualToString:self.productID]){
            p = pro;
        }
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"------------------错误-----------------:%@", error);

    if(self.purchaseBlock)
    {
        self.purchaseBlock(NO,@"网络异常");
    }
}

- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"------------反馈信息结束-----------------");

    
}


//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    for(SKPaymentTransaction *tran in transaction){
        
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"交易完成");
            {
                if(self.purchaseBlock)
                {
                    self.purchaseBlock(YES,@"购买商品成功");
                }
                
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品");
            {
                if(self.purchaseBlock)
                {
                    self.purchaseBlock(YES,@"已经购买过商品");
                }
                
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"交易失败");
            {
                if(self.purchaseBlock)
                {
                    self.purchaseBlock(NO,@"购买商品失败");
                }
                
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            default:
                break;
        }
        
        
        
    }
    
    
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    
    
}


- (void)dealloc
{
    if(self.purchaseBlock)
    {
        [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];

        self.purchaseBlock = nil;
    }
}

@end
