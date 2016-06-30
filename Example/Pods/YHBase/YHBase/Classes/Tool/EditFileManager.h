//
//  EditFileManager.h
//  SuoShi
//
//  Created by 林宁宁 on 15/12/18.
//  Copyright © 2015年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EditFileManager : NSObject

/**
 *  图片保存
 *
 *  @param saveImage   要保存的图片
 *  @param finishBlock 回调
 *  @param location    图片的位置 图片的路劲会一样
 */
+ (void)fileSaveImage:(UIImage *)saveImage andLocation:(NSInteger)location andFinishBlock:(void(^)(BOOL isSuccess, NSString * savepath))finishBlock;

/**
 *  通过图片的名字获取本地保存的图片
 */
+ (UIImage *)fileGetImageWithName:(NSString *)imagename;



/**
 *  保存视频
 *
 *  @param inputURL  源地址 手机相册中的地址
 *  @param outputURL 要保存的地址
 *  @param handler   回调
 */
+(void)fileSaveVideoPath:(NSURL *)videoFilepathURL
          andFinishBlock:(void (^)(BOOL, NSString *))finishBlock;

/**
 *  文件是否存在
 */
+ (BOOL)fileIsExitAtFile:(NSString *)filepath;


/**
 *  获取文件的路径
 */
+ (NSString *)getFilaPathWithName:(NSString *)filename;



/**
 *  将下载下来的文件移动到note目录下 然后重命名
 */
+ (BOOL)moveFileAtPath:(NSString *)originPath andFileName:(NSString *)filename;

@end
