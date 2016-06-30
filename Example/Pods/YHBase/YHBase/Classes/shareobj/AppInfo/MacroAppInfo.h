//
//  MacroAppInfo.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/22.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MacroAppInfo : NSObject

@property (assign, nonatomic) BOOL is_with_network;

/** 退到后台了*/
@property (assign, nonatomic) BOOL isGotoBackGround;

/** 后台回来*/
@property (assign, nonatomic) BOOL isBackGroundComeBack;

/**
 *  本地最大的信息ID
 */
@property (copy, nonatomic) NSString * localMaxMessageID;


/**
 *  TCP的登录状态
 */
@property (assign, nonatomic) BOOL tcpLoginState;

/**
 *  设备的标识
 */
@property (copy, nonatomic) NSString * deviceToken;


/**
 *  隐藏状态栏
 */
@property (assign, nonatomic) BOOL statusBarIsHidden;


+ (instancetype)shareManager;

/**
 *  更新本地引导页 存储本地的版本号信息  判断保存的版本号信息 跟 当前的版本号信息是否一致
 */
- (void)updateGuidState;

/**
 *  第一次启动app的时候弹出登录的界面
 */
-(void)updateFirstLoginState;





/** 系统的版本号*/
+ (float)IOS_VERSION;

/** app的版本号*/
+ (NSString *)APP_VERSION;

+ (BOOL)isiPhone4;

+ (BOOL)isiPhone5;

+ (BOOL)isiPhone6;

+ (BOOL)isiPhone6P;

+ (BOOL)isiPhone6OriPhone6P;

+ (BOOL)isiPad;

+ (BOOL)isPortrait;


/** 客服电话*/
+ (NSString *)appServicePhoneNum;

/**
 *  网络是连接正常的状态
 */
+ (BOOL)appNetworkConnect;

/**
 *  设备的唯一标识  UDID
 */
+ (NSString *)udid;

/**
 *  是否需要启动页
 */
+ (BOOL)needShowGuid;

/**
 *  是否是第一次启动app 然后弹出登录的界面
 */
+ (BOOL)needShowLoginVCWhenFirstOpenApp;


/**
 *  商店上的地址
 */
+ (NSString *)appstoreURL;


@end
