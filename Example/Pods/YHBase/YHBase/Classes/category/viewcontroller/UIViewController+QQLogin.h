//
//  UIViewController+QQLogin.h
//  SuoShi
//
//  Created by 林宁宁 on 16/3/17.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (QQLogin)

/**
 *  qq登录
 *
 *  @param showAlertTitle 显示的标题
 *
 *  @return YES 已登录 NO 未登录
 */
- (BOOL)isLoginWithAlertTitle:(NSString *)showAlertTitle;

@end
