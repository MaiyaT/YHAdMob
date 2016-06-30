//
//  AppDelegateBase+Open.m
//  Pods
//
//  Created by 林宁宁 on 16/4/16.
//
//

#import "AppDelegateBase+Open.h"
#import "MacroAppInfo.h"
#import "BBXGuideViewController.h"
#import "AppDelegateBase+Assess.h"
#import "AppDelegateBase+Reachability.h"
#import "UserInfoTool.h"
#import "SVProgressHUD.h"


@implementation AppDelegateBase (Open)

- (void)startApp
{
    //是否需要启动页判断
    if([MacroAppInfo needShowGuid])
    {
        //    弹出启动页
        __weak typeof(&*self)weakSelf = self;
        
        BBXGuideViewController * guideVC = [[BBXGuideViewController alloc] init];
        
        
        [guideVC setEnterAppBlock:^{
            
            [weakSelf openHomePageVC];
            
        }];
        
        [UIView transitionFromView:self.window.rootViewController.view
                            toView:guideVC.view
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        completion:^(BOOL finished)
         {
             weakSelf.window.rootViewController = guideVC;
             [weakSelf.window makeKeyAndVisible];
         }];
        
    }
    else
    {
        [self openHomePageVC];
    }
}

- (void)openGuideVC
{
    BBXGuideViewController * guideVC = [[BBXGuideViewController alloc] init];
    
    [self.rootNavc  pushViewController:guideVC animated:YES];
}

/**
 *  打开主界面
 */
- (void)openHomePageVC
{
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:self.rootNavc.view
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionCurveEaseInOut |UIViewAnimationOptionCurveLinear
                    completion:^(BOOL finished)
     {
         self.window.rootViewController = self.rootNavc;
         [self.window makeKeyAndVisible];
         
         //检查网络
         [self setNetworkingConfig];
         
         [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
         [SVProgressHUD setMinimumDismissTimeInterval:1];
         
//         [[UserInfoTool shareManager] updateUserObjectID];
         
         [self appHomeStart];
     }];
}

@end
