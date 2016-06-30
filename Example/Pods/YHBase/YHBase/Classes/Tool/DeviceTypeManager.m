//
//  DeviceTypeManager.m
//  直播吧
//
//  Created by 林宁宁 on 15/1/28.
//  Copyright (c) 2015年 傲播网络科技有限公司. All rights reserved.
//

#import "DeviceTypeManager.h"

#include <sys/types.h>
#include <sys/sysctl.h>

@implementation DeviceTypeManager


+ (id)sharedManager
{
    static dispatch_once_t onceToken;
    static id sharedManager = nil;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

/** 固件和设备对照表*/
+ (void)allDeviceContrastTab
{
    
}

/**
 *  型号对应的地址
 *  http://theiphonewiki.com/wiki/Models
 */
+ (NSString *)getDevicePlatform
{
    //    NSString * platform  = [UIDevice currentDevice].model;
    
    size_t size;
    
    int nR = sysctlbyname("hw.machine",
                          NULL, &size, NULL,
                          0);
    
    char*machine = (char*)malloc(size);
    
    nR =
    sysctlbyname("hw.machine", machine, &size,
                 NULL, 0);
    
    
    NSString *platform = [NSString
                          stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    //Apple TV
    if ([platform isEqualToString:@"AppleTV2,1"]) return @"Apple TV 2G";
    if ([platform isEqualToString:@"AppleTV3,1"]) return @"Apple TV 3G";
    if ([platform isEqualToString:@"AppleTV3,2"]) return @"Apple TV 3G";
    if ([platform isEqualToString:@"AppleTV5,3"]) return @"Apple TV 4G";
    
    
    //Apple Watch
    if ([platform isEqualToString:@"Watch1,1"]) return @"Apple Watch";
    if ([platform isEqualToString:@"Watch1,2"]) return @"Apple Watch";
    
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad1";
    
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad2";
    
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    
    if ([platform isEqualToString:@"iPad6,7"]) return @"iPad Pro (12.9 inch)";
    if ([platform isEqualToString:@"iPad6,8"]) return @"iPad Pro (12.9 inch)";
    if ([platform isEqualToString:@"iPad6,3"]) return @"iPad Pro (9.7 inch)";
    if ([platform isEqualToString:@"iPad6,4"]) return @"iPad Pro (9.7 inch)";
    
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad mini 1G";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad mini 1G";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad mini 1G";
    
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    
    if ([platform isEqualToString:@"iPad5,1"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,2"]) return @"iPad mini 3";
    
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    //iPod touch
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod touch";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod touch 2G";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod touch 3G";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod touch 4G";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod touch 5G";
    if ([platform isEqualToString:@"iPod7,1"]) return @"iPod touch 6G";
    
    
    
    //iPhone Simulator
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}


@end
