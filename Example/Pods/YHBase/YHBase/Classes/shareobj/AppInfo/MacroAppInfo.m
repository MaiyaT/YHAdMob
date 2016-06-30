//
//  MacroAppInfo.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/22.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "MacroAppInfo.h"
#import <UIKit/UIKit.h>
#import "YHKeychain.h"
#import "BBXTool.h"
#import "DeviceTypeManager.h"
#import "NSString+BBX.h"
#import "APPConfigNote.h"


@interface MacroAppInfo()

/** 系统的版本号*/
@property (assign, nonatomic) float IOS_VERSION;

/** app的版本号*/
@property (copy, nonatomic) NSString * APP_VERSION;


@property (retain, nonatomic) NSNumber * is_iphone4;

@property (retain, nonatomic) NSNumber * is_iphone5;

/**
 *  4.7寸
 */
@property (retain, nonatomic) NSNumber * is_iphone6;

/**
 *  5.5寸
 */
@property (retain, nonatomic) NSNumber * is_iphone6p;

@property (copy, nonatomic) NSString * udid;

/**
 *  启动的时候需要弹出引导页
 */
@property (assign, nonatomic) BOOL needShowGuid;

/**
 *  启动的时候需要弹出登录的界面
 */
@property (assign, nonatomic) BOOL needShowLoginVC;

@end

@implementation MacroAppInfo

+ (instancetype)shareManager
{
    static MacroAppInfo * manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MacroAppInfo alloc] init];
        
        [manager getAppInfo];
    });
    
    return manager;
}


- (void)getAppInfo
{
    
    self.APP_VERSION = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.IOS_VERSION = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    [self getDeviceType];
    
    [self getDeviceUDID];
    
    [self getGuidState];
    
    [self getFirstLoginState];
}

//获取当前设备的类型
- (void)getDeviceType
{
    NSString * deviceStr = [DeviceTypeManager getDevicePlatform];

    if([deviceStr containStr:@"iPhone 4"])
    {
        self.is_iphone4 = @(YES);
    }
    else if ([deviceStr containStr:@"iPhone 5"])
    {
        self.is_iphone5 = @(YES);
    }
    else if ([deviceStr containStr:@"iPhone 6 Plus"])
    {
        self.is_iphone6p = @(YES);
    }
    else if ([deviceStr containStr:@"iPhone 6"])
    {
        self.is_iphone6 = @(YES);
    }
    else
    {
        self.is_iphone4 = @([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO);
        
        self.is_iphone4 = @([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO);
        
        self.is_iphone5 = @([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO);
        
        self.is_iphone6 = @([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO);
        
        self.is_iphone6p = @([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO);
    }
    
}

- (void)getDeviceUDID
{
    NSString * savePatch = @"com.alone.suoshi.userInfo";
    NSString * udidKey = @"com.alone.suoshi.udid";
    
    NSDictionary * dicData = (NSDictionary *)[YHKeychain keyChainLoad:savePatch];
    if(dicData[udidKey])
    {
        self.udid = dicData[udidKey];
    }
    else
    {
        NSString * udidCreate = [BBXTool uuid];
        
        NSDictionary * dataDic = @{udidKey:udidCreate};
        [YHKeychain keyChainSave:savePatch data:dataDic];
        
        self.udid = udidCreate;
    }
//    self.udid = [self.udid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    //C3434527-7973-4700-91CF-FC1F8B264429
    //CC6CA242-6CF8-47B0-A33B-BF9F93F61BB7  手机的 5s mine
    NSLog(@"\nudid___===========___%@",self.udid);
}


- (void)getGuidState
{
    NSString * guidVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"localGuidVersion"];
    
    self.needShowGuid = ![guidVersion isEqualToString:self.APP_VERSION];
    
    //测试 现在目前不需要引导页
    self.needShowGuid = NO;
}

-(void)updateGuidState
{
    [[NSUserDefaults standardUserDefaults] setObject:self.APP_VERSION forKey:@"localGuidVersion"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)getFirstLoginState
{
    NSNumber * showLoginVC = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstOpenAppToShowLoginVC"];
    
    self.needShowLoginVC = [showLoginVC boolValue];
}

-(void)updateFirstLoginState
{
    [[NSUserDefaults standardUserDefaults] setObject:@(self.needShowLoginVC) forKey:@"firstOpenAppToShowLoginVC"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}




+(NSString *)APP_VERSION
{
    return [[MacroAppInfo shareManager] APP_VERSION];
}

+(float)IOS_VERSION
{
    return [[MacroAppInfo shareManager] IOS_VERSION];
}

+(BOOL)isiPhone6
{
    return [[[MacroAppInfo shareManager] is_iphone6] boolValue];
}

+ (BOOL)isiPhone6P
{
    return [[[MacroAppInfo shareManager] is_iphone6p] boolValue];
}

+ (BOOL)isiPhone4
{
    return [[[MacroAppInfo shareManager] is_iphone4] boolValue];
}

+ (BOOL)isiPhone5
{
    return [[[MacroAppInfo shareManager] is_iphone5] boolValue];
}

+(BOOL)isiPhone6OriPhone6P
{
    return [[[MacroAppInfo shareManager] is_iphone6] boolValue] || [[[MacroAppInfo shareManager] is_iphone6p] boolValue];
}

+ (NSString *)appServicePhoneNum
{
    return @"968969";
}

+(BOOL)appNetworkConnect
{
    return [[MacroAppInfo shareManager] is_with_network];
}

+(NSString *)udid
{
    return [[MacroAppInfo shareManager] udid];
}

/**
 *  是否需要启动页
 */
+ (BOOL)needShowGuid
{
    return [[MacroAppInfo shareManager] needShowGuid];
}

+ (BOOL)needShowLoginVCWhenFirstOpenApp
{
    return [[MacroAppInfo shareManager] needShowLoginVC];
}


+ (BOOL)isiPad
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (BOOL)isPortrait
{
    int winW = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    int winH = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    
    return winH > winW;
}

/**
 *  商店上的地址
 */
+ (NSString *)appstoreURL
{
    return APP_STORE_URL_SHORT;
}

@end
