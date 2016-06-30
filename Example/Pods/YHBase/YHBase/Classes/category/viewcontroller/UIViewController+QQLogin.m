//
//  UIViewController+QQLogin.m
//  SuoShi
//
//  Created by 林宁宁 on 16/3/17.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "UIViewController+QQLogin.h"
#import "UserInfoTool.h"
#import "SCLAlertView.h"
#import "UIColor+BBXApp.h"
#import "SVProgressHUD.h"
#import "AppDelegateBase.h"


@implementation UIViewController (QQLogin)

-(BOOL)isLoginWithAlertTitle:(NSString *)showAlertTitle
{
    if(![UserInfoTool shareManager].userID)
    {        
        SCLAlertView * alertV = [[SCLAlertView alloc] initWithNewWindow];
        alertV.iconTintColor = [UIColor whiteColor];
        alertV.customViewColor = [UIColor bbxThemeColor];
        alertV.backgroundType = Shadow;
        alertV.buttonFormatBlock = ^NSDictionary* (void)
        {
            NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];
            
            buttonConfig[@"textColor"] = [UIColor whiteColor];
            
            return buttonConfig;
        };
        
        [alertV addButton:@"登录" actionBlock:^{

            NSLog(@"登录 界面  === 》》》 LoginViewController");
            
            UIViewController * loginVC = [[NSClassFromString(@"LoginViewController") alloc] init];
            [[AppDelegateBase shareAppDelegate].rootNavc presentViewController:loginVC animated:YES completion:nil];

            
        }];
        
        [alertV showTitle:[AppDelegateBase shareAppDelegate].rootNavc title:@"提醒" subTitle:showAlertTitle style:Info closeButtonTitle:@"不了" duration:0];
        
        return NO;
    }
    
    return YES;
}

@end
