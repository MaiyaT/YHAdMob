//
//  BBXGuideViewController.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/8/5.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "BaseViewController.h"

/**
 *  引导页
 */
@interface BBXGuideViewController : BaseViewController

/**
 *  启动页的图片
 */
@property (retain, nonatomic) NSArray * listImageS;

/**
 *  进入app的回调
 */
@property (copy, nonatomic) void(^enterAppBlock)();

@end
