//
//  AppDelegateBase+Reachability.m
//  Pods
//
//  Created by 林宁宁 on 16/4/16.
//
//

#import "AppDelegateBase+Reachability.h"
#import "AFNetworking.h"
#import "MacroAppInfo.h"
#import "UIView+BBX.h"



@implementation AppDelegateBase (Reachability)


- (void)setNetworkingConfig
{
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager startMonitoring];
    
    [[MacroAppInfo shareManager] setIs_with_network:YES];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"无网络");
                
                if([[MacroAppInfo shareManager] is_with_network])
                {
                    [[[[AppDelegateBase shareAppDelegate] rootNavc] view] showWithText:@"当前无网络"];
                    
                    [[MacroAppInfo shareManager] setIs_with_network:NO];
                }
                
            }
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"WiFi网络");
                
                //无网络变到有网络 重新 链接
                if(![[MacroAppInfo shareManager] is_with_network])
                {
                    NSLog(@"无网络 - WiFi网络");
                    
                    [[MacroAppInfo shareManager] setIs_with_network:YES];
                }
                else
                {
                    [[MacroAppInfo shareManager] setIs_with_network:YES];
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"数据流量");
                //无网络变到有网络 重新 链接
                if(![[MacroAppInfo shareManager] is_with_network])
                {
                    NSLog(@"无网络 - 数据流量");
                    
                    [[MacroAppInfo shareManager] setIs_with_network:YES];                    
                }
                else
                {
                    [[MacroAppInfo shareManager] setIs_with_network:YES];
                }
                NSLog(@"3G网络");
                
                //                [[[[AppDelegate shareAppDelegate] rootNavc] view] showWithText:@"当前使用的是数据流量"];
            }
                break;
                
            default:
                
                break;
        }
        
    }];
    
}


@end
