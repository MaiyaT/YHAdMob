//
//  AppDelegateBase.m
//  Pods
//
//  Created by 林宁宁 on 16/4/16.
//
//

#import "AppDelegateBase.h"

#import "AppDelegateBase+Open.h"
#import "MacroAppInfo.h"
#import "BBXLaunchViewController.h"
#import "UserInfoTool.h"


@implementation AppDelegateBase


+(AppDelegateBase *)shareAppDelegate
{
    AppDelegateBase * delegate = (AppDelegateBase *)[[UIApplication sharedApplication] delegate];
    return delegate;
}

+ (void)updateHomeTableList
{
    AppDelegateBase * delegate = [self shareAppDelegate];
    
    [delegate.homeVC updateHomeContentV];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow * mainWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = mainWindow;
    
    HomeViewController * homeVC = [self appHomeCustomVC];
    if(!homeVC)
    {
        homeVC = [[HomeViewController alloc] init];
    }
    self.homeVC = homeVC;
    
    BBXBaseNAVController * rootNAVC = [self appRootNavcCustomNAVCWithHomeVC:homeVC];
    if(!rootNAVC)
    {
        rootNAVC = [[BBXBaseNAVController alloc] initWithRootViewController:homeVC];
    }
    self.rootNavc = rootNAVC;
    
    BBXLaunchViewController * launchVC = [BBXLaunchViewController new];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = launchVC;
    [self.window makeKeyAndVisible];
    
    
    [self appInitSetting];
    
    [self appThirdLibrarySetting:launchOptions];
    
    [self startApp];
    
    return YES;
}


/**
 *  获取主界面设置  没有就使用默认的
 */
- (HomeViewController *)appHomeCustomVC
{
    return nil;
}

/**
 *  基本视图 window的rootvc视图
 */
- (BBXBaseNAVController *)appRootNavcCustomNAVCWithHomeVC:(HomeViewController *)homeVC
{
    return nil;
}

/**
 *  初始化设置  给子类 调用
 */
- (void)appInitSetting
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [UserInfoTool shareManager];
}


- (void)appThirdLibrarySetting:(NSDictionary *)launchOptions
{
    
}

-(BOOL)appHandleOpenURL:(NSURL *)url
{
    return YES;
}

- (void)appDidiBecomeActive
{
    
}

- (void)appRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
}

/**
 *  首页开始启动
 */
- (void)appHomeStart
{

}

- (void)appReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}

/**
 *  app 退到后台
 */
- (void)appEnterBackground
{
    
}

/**
 *  app 后台回来
 */
- (void)appEnterForeground
{
    
}





/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self appHandleOpenURL:url];
}




/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self appDidiBecomeActive];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    self.enterBackgroundDate = [NSDate date];
    [self appEnterBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [self appEnterForeground];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Remote Notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [self appRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self appReceiveRemoteNotification:userInfo];
}


-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    
}


@end
