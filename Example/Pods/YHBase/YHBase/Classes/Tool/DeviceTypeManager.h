//
//  DeviceTypeManager.h
//  直播吧
//
//  Created by 林宁宁 on 15/1/28.
//  Copyright (c) 2015年 傲播网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceTypeManager : NSObject

/**
 *  设备的固件 与 型号对应
 *  型号表更新于 2015-01-28
 */

//+ (id)sharedManager;


+ (NSString *)getDevicePlatform;

@end
