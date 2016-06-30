//
//  AppConfigNote.h
//  Pods
//
//  Created by 林宁宁 on 16/4/16.
//
//

#import <Foundation/Foundation.h>


/**
 *  ################### 发布的时候 注意 配置问题
 
 *  1.要去 bmob后台修改 是否显示点击的广告配置
 *  2.config 如果有修改  后台要配置 version字段 目前100
 *  3.发布的时候检查一下 警告的问题
 */

#define AD_CONFIG_VERSION           [[AppConfigNote shareManager] noteAppVersion]

#define APP_SCHEME                  [[AppConfigNote shareManager] noteAppScheme]


#define APP_STORE_URL           [[AppConfigNote shareManager] noteAppStoreURL]

#define APP_STORE_URL_SHORT     [[AppConfigNote shareManager] noteAppStoreShortURL]




#define SHARE_APP_URL           [[AppConfigNote shareManager] noteAppShareURL]

#define SHARE_APP_URL_SHORT     [[AppConfigNote shareManager] noteAppShareShortURL]



#define APP_SHARE_TITLE         [[AppConfigNote shareManager] noteAppShareTitle]

#define APP_ORDER_NAME          [[AppConfigNote shareManager] noteAppOrderName]


#define isDebug     [[AppConfigNote shareManager] noteAPPIsDebug]

#define isChina     [[AppConfigNote shareManager] noteAPPIsInChina]


//APP keys
/**
 *  umeng的appkey
 */
#define APP_KEY_UMeng           [[AppConfigNote shareManager] noteKeyUmeng]

#define KEY_WeChat_ID           [[AppConfigNote shareManager] noteKeyWechatID]
#define KEY_WeChat_Secret       [[AppConfigNote shareManager] noteKeyWechatSecret]


#define KEY_QQ_APPID            [[AppConfigNote shareManager] noteKeyQQID]
#define KEY_QQ_APPID_16         [[AppConfigNote shareManager] noteKeyQQID16]
#define KEY_QQ_APPKEY           [[AppConfigNote shareManager] noteKeyQQKey]


#define KEY_Sina_ID             [[AppConfigNote shareManager] noteKeySinaID]
#define KEY_Sina_Secret         [[AppConfigNote shareManager] noteKeySinaSecret]



#define KEY_JPush               [[AppConfigNote shareManager] noteKeyJPush]


#define BMOB_KEY                [[AppConfigNote shareManager] noteKeyBMob]



//table
#define BMOB_TAB_NAME_BANNER        [[AppConfigNote shareManager] noteTableBanner]

#define BMOB_TAB_NAME_CONFIG_APP    [[AppConfigNote shareManager] noteTableConfig]

#define BMOB_TAB_NAME_ORDER_AD      [[AppConfigNote shareManager] noteTableOrderAD]

#define BMOB_TAB_NAME_UINFO         [[AppConfigNote shareManager] noteTableUInfo]

#define BMOB_TAB_NAME_ORDER         [[AppConfigNote shareManager] noteTableOrder]

#define BMOB_TAB_NOTE_LIST          [[AppConfigNote shareManager] noteTableNoteList]








//IAP
#define IAP_Prop_All               [[AppConfigNote shareManager] noteIAPPropAll]

#define IAP_Prop_Single            [[AppConfigNote shareManager] noteIAPPropSingle]

#define IAP_Prop_Forever           [[AppConfigNote shareManager] noteIAPPropForever]

#define IAP_Ad_Close_Forever       [[AppConfigNote shareManager] noteIAPADForever]

#define IAP_Ad_Close_Month         [[AppConfigNote shareManager] noteIAPADMonth]







@interface AppConfigNote : NSObject

+ (instancetype)shareManager;


@property (assign, nonatomic) BOOL noteAPPIsDebug;

/**
 *  在中国区域
 */
@property (assign, nonatomic) BOOL noteAPPIsInChina;

//主题色
@property (copy, nonatomic) NSString * noteAPPThemeColor;


//IAP
@property (copy, nonatomic) NSString * noteIAPADForever;
@property (copy, nonatomic) NSString * noteIAPADMonth;
@property (copy, nonatomic) NSString * noteIAPPropAll;
@property (copy, nonatomic) NSString * noteIAPPropSingle;
@property (copy, nonatomic) NSString * noteIAPPropForever;



@property (copy, nonatomic) NSString * noteAppVersion;
@property (copy, nonatomic) NSString * noteAppScheme;
@property (copy, nonatomic) NSString * noteAppStoreURL;
@property (copy, nonatomic) NSString * noteAppStoreShortURL;
@property (copy, nonatomic) NSString * noteAppShareURL;
@property (copy, nonatomic) NSString * noteAppShareShortURL;
@property (copy, nonatomic) NSString * noteAppShareTitle;
@property (copy, nonatomic) NSString * noteAppOrderName;


//Keys
@property (copy, nonatomic) NSString * noteKeyUmeng;

@property (copy, nonatomic) NSString * noteKeyWechatID;
@property (copy, nonatomic) NSString * noteKeyWechatSecret;

@property (copy, nonatomic) NSString * noteKeyQQID;
@property (copy, nonatomic) NSString * noteKeyQQKey;
@property (copy, nonatomic) NSString * noteKeyQQID16;

@property (copy, nonatomic) NSString * noteKeySinaID;
@property (copy, nonatomic) NSString * noteKeySinaSecret;

@property (copy, nonatomic) NSString * noteKeyJPush;

@property (copy, nonatomic) NSString * noteKeyBMob;


//table
@property (copy, nonatomic) NSString * noteTableBanner;
@property (copy, nonatomic) NSString * noteTableConfig;
@property (copy, nonatomic) NSString * noteTableOrderAD;
@property (copy, nonatomic) NSString * noteTableUInfo;
@property (copy, nonatomic) NSString * noteTableOrder;
@property (copy, nonatomic) NSString * noteTableNoteList;


//ad gdt
@property (copy, nonatomic) NSString * noteADGDTKey;
@property (retain, nonatomic) NSArray * noteADGDTBanners;
@property (copy, nonatomic) NSString * noteADGDTChaping;
@property (copy, nonatomic) NSString * noteADGDTKaiping;
@property (assign, nonatomic) NSInteger noteADGDTBannerTime;

//ad gdt
@property (copy, nonatomic) NSString * noteADADMobKey;
@property (retain, nonatomic) NSArray * noteADADMobBanners;
@property (copy, nonatomic) NSString * noteADADMobChaping;
@property (copy, nonatomic) NSString * noteADADMobKaiping;
@property (assign, nonatomic) NSInteger noteADADMobBannerTime;

@end
