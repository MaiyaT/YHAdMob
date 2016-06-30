//
//  AppDelegateBase.h
//  Pods
//
//  Created by 林宁宁 on 16/4/16.
//
//

#import <UIKit/UIKit.h>
#import "BBXBaseNAVController.h"
#import "HomeViewController.h"


@interface AppDelegateBase : UIResponder<UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BBXBaseNAVController * rootNavc;

@property (retain, nonatomic) HomeViewController * homeVC;

/**
 *  退到后台的时间
 */
@property (retain, nonatomic) NSDate * enterBackgroundDate;

+ (AppDelegateBase *)shareAppDelegate;

+ (void)updateHomeTableList;


/**
 *  初始化设置  给子类 调用
 */
- (void)appInitSetting;

/**
 *  第三方设置
 */
- (void)appThirdLibrarySetting:(NSDictionary *)launchOptions;

/**
 *  获取主界面设置  没有就使用默认的
 */
- (HomeViewController *)appHomeCustomVC;

/**
 *  基本视图 window的rootvc视图
 */
- (BBXBaseNAVController *)appRootNavcCustomNAVCWithHomeVC:(HomeViewController *)homeVC;

/**
 *  app跳回之后的回调
 */
- (BOOL)appHandleOpenURL:(NSURL *)url;

/**
 *  app
 */
- (void)appDidiBecomeActive;

/**
 *  app 退到后台
 */
- (void)appEnterBackground;

/**
 *  app 后台回来
 */
- (void)appEnterForeground;

/**
 *  注册远程通知
 */
- (void)appRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

/**
 *  收到远程通知
 */
- (void)appReceiveRemoteNotification:(NSDictionary *)userInfo;

/**
 *  首页开始启动
 */
- (void)appHomeStart;

@end
