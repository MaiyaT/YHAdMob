//
//  BBXTool.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/22.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BBXTool : NSObject

/** 拨打电话*/
+ (void)callPhoneWithNum:(NSString *)phoneNum atView:(UIView *)aimView;


+ (NSString*) uuid;

/**
 *  获取视频第一针的图片
 */
+ (UIImage *)getFirstVideoWithURL:(NSURL *)videoURL;

/**
 *  将视频第一针的图片和视频的标志合并
 */
+ (UIImage *)getVideoImageConbainLogoWithURL:(NSURL *)videoURL;

/**
 *  时间 转化成 时  分 秒
 */
+(NSString*)timeStringForTimeInterval:(NSTimeInterval)timeInterval;

/**
 *  获取音频的图片
 */
+ (UIImage *)getAudioImageWithDuration:(float)duration;

/**
 *  获取音频时长
 */
+ (float)getAudioDurationWithFilaname:(NSString *)filename;


/**
 *  获取文件大小 kb
 */
+ (long long)fileSizeAtPath:(NSString*) filePath;

@end
