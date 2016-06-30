//
//  BMobManager.m
//  SuoShi
//
//  Created by 林宁宁 on 16/2/5.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BMobManager.h"
#import <BmobSDK/Bmob.h>
#import "APPConfigNote.h"
#import <BmobPay/BmobPay.h>

@implementation BMobManager


+(void)setupConfigBmob
{
    NSLog(@"设置bmob的key");
    
    [Bmob registerWithAppKey:BMOB_KEY];

    [BmobPaySDK registerWithAppKey:BMOB_KEY];
}



@end
