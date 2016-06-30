//
//  AppDelegate+Assess.m
//  Shudu
//
//  Created by 林宁宁 on 16/3/1.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "AppDelegateBase+Assess.h"
#import "AppConfigNote.h"
#import "SCLAlertView.h"
#import "MacroAppInfo.h"
#import "UIColor+BBXApp.h"

#define Launch_Times        @"Launch_Times"
#define AlerVersion         @"alert_version"

@implementation AppDelegateBase (Assess)




/**
 *  弹出好评的提示窗
 */
- (void)popAssessVWithText:(NSString *)message
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
    
    [alertV addButton:@"马上赏" actionBlock:^{
        
        [[NSUserDefaults standardUserDefaults] setObject:[MacroAppInfo APP_VERSION] forKey:AlerVersion];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_STORE_URL]];
        
    }];
    
    [alertV showTitle:[AppDelegateBase shareAppDelegate].rootNavc title:@"\(^o^)/~" subTitle:message style:Notice closeButtonTitle:@"等一等" duration:0];
    
}


- (void)popAssessVWithTitle:(NSString *)title andAssessKey:(NSString *)key andBtnWarn:(BOOL)haveWarnBtn
{
    BOOL donotShow = [[[NSUserDefaults standardUserDefaults] objectForKey:key] boolValue];
    
    if(!donotShow)
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
        
        if(haveWarnBtn)
        {
            [alertV addButton:@"不再提醒" actionBlock:^{
                
                [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:key];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }];
        }
        else
        {
            [alertV alertIsDismissed:^{
                [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:key];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
            }];
        }
        
        [alertV showTitle:[AppDelegateBase shareAppDelegate].rootNavc title:@"友情提示" subTitle:title style:Notice closeButtonTitle:@"知道了" duration:0];
    }
}

@end
