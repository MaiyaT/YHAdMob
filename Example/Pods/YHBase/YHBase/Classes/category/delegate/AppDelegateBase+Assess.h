//
//  AppDelegate+Assess.h
//  Shudu
//
//  Created by 林宁宁 on 16/3/1.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "AppDelegateBase.h"

/**
 *  跳到app store赏个好评提示
 */
@interface AppDelegateBase (Assess)

/**
 *  弹出好评的提示窗
 */
- (void)popAssessVWithText:(NSString *)message;

- (void)popAssessVWithTitle:(NSString *)title andAssessKey:(NSString *)key andBtnWarn:(BOOL)haveWarnBtn;

@end
