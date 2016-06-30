//
//  UserInfoTool.h
//  SuoShi
//
//  Created by 林宁宁 on 16/3/15.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_ID_DEFAULT         @"u10000"

@interface UserInfoTool : NSObject

+ (instancetype)shareManager;

@property (copy, nonatomic) NSString * userID;
@property (copy, nonatomic) NSString * userName;
@property (copy, nonatomic) NSString * userImageURL;

@property (copy, nonatomic) NSString * userLoginType;

/**
 *  用户已关闭广告
 */
@property (assign, nonatomic) BOOL userIdClosedAD;


/**
 *  bmob后台对应的
 */
@property (copy, nonatomic) NSString * userObjectID;



- (void)saveToLocal;

- (void)cleanUserInfo;


//- (void)updateUserObjectID;

@end
