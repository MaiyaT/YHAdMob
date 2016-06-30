//
//  BBXLaunchViewController.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/16.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface BBXLaunchViewController : BaseViewController

@property (copy, nonatomic) void(^launchShowBlock)();

@end
