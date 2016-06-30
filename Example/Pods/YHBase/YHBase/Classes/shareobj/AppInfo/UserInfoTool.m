//
//  UserInfoTool.m
//  SuoShi
//
//  Created by 林宁宁 on 16/3/15.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "UserInfoTool.h"

@implementation UserInfoTool

+(instancetype)shareManager
{
    static UserInfoTool * tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tool = [[UserInfoTool alloc] init];
        
        [tool readFromLocal];
    });
    
    return tool;
}

- (void)readFromLocal
{
    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userinfo"];
    
    if([infoDic isKindOfClass:[NSDictionary class]])
    {
        id obj = infoDic[@"userID"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.userID = obj;
        }
        
        obj = infoDic[@"userImageURL"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.userImageURL = obj;
        }
        
        obj = infoDic[@"userName"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.userName = obj;
        }
        
        obj = infoDic[@"userIdClosedAD"];
        if(obj && ![obj isKindOfClass:[NSNull class]])
        {
            self.userIdClosedAD = [obj boolValue];
        }
        
        obj = infoDic[@"userLoginType"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.userLoginType = obj;
        }
        
        obj = infoDic[@"userObjectID"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.userObjectID = obj;
        }
    }
}

-(void)saveToLocal
{
    NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
    
    if(self.userID)
    {
        [dataDic setObject:self.userID forKey:@"userID"];
    }
    
    if(self.userImageURL)
    {
        [dataDic setObject:self.userImageURL forKey:@"userImageURL"];
    }
    
    if(self.userName)
    {
        [dataDic setObject:self.userName forKey:@"userName"];
    }
    
    
    if(self.userLoginType)
    {
        [dataDic setObject:self.userLoginType forKey:@"userLoginType"];
    }
    
    if(self.userObjectID)
    {
        [dataDic setObject:self.userObjectID forKey:@"userObjectID"];
    }
    
    [dataDic setObject:@(self.userIdClosedAD) forKey:@"userIdClosedAD"];
    
    [[NSUserDefaults standardUserDefaults] setObject:dataDic forKey:@"userinfo"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//- (void)updateUserObjectID
//{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        if(self.userID && !self.userObjectID)
//        {
//            //用户的objectid不存在 更新 或者创建一下
//            [BMobRequest requestUpdateUserObjectID];
//        }
//    });
//}

- (void)cleanUserInfo
{
    self.userID = nil;
    self.userImageURL = nil;
    self.userName = nil;
//    self.userIdClosedAD = NO;
    self.userLoginType = nil;
    self.userObjectID = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userinfo"];
    
    [self saveToLocal];
}


@end
