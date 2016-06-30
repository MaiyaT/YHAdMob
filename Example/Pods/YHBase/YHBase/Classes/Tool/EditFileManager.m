//
//  EditFileManager.m
//  SuoShi
//
//  Created by 林宁宁 on 15/12/18.
//  Copyright © 2015年 林宁宁. All rights reserved.
//

#import "EditFileManager.h"

#import <AVFoundation/AVFoundation.h>



@implementation EditFileManager


/**
 *  图片保存
 *
 *  @param saveImage   要保存的图片
 *  @param imageName   图片的名字
 *  @param finishBlock 回调
 */
+ (void)fileSaveImage:(UIImage *)saveImage andLocation:(NSInteger)location andFinishBlock:(void (^)(BOOL, NSString *))finishBlock
{
    NSString * filepath = [self filepath];
    
    __block NSData *data;

    __block NSString * filename;
    NSString * timetemp = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];

    if(UIImagePNGRepresentation(saveImage) == nil)
    {
        data = UIImageJPEGRepresentation(saveImage, 1);
        filename = [NSString stringWithFormat:@"%d_%@.jpeg",(int)location,timetemp];
    }
    else
    {
        data = UIImagePNGRepresentation(saveImage);
        filename = [NSString stringWithFormat:@"%d_%@.png",(int)location,timetemp];
    }
    
    NSString * imagePath = [filepath stringByAppendingPathComponent:filename];
    
    BOOL isSuccess = [data writeToFile:imagePath atomically:YES];
    
    if(finishBlock)
    {
        finishBlock(isSuccess,filename);
    }
}

/**
 *  通过图片的名字获取本地保存的图片
 */
+ (UIImage *)fileGetImageWithName:(NSString *)imagename
{
    NSString * filepath = [self getFilaPathWithName:imagename];
    
    NSData * imageData = [NSData dataWithContentsOfFile:filepath];
    
    return [UIImage imageWithData:imageData];
}


+ (NSString *)getFilaPathWithName:(NSString *)filename
{
    return [[self filepath] stringByAppendingPathComponent:filename];;
}



+(void)fileSaveVideoPath:(NSURL *)videoFilepathURL andFinishBlock:(void (^)(BOOL, NSString *))finishBlock
{
    NSParameterAssert(videoFilepathURL);
    
//    NSData * dataVideo = [NSData dataWithContentsOfURL:videoFilepathURL];
//    
//    NSString * filepath = [self filepath];
//    NSString * timetemp = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
//    
//    NSString * exportPath = [filepath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov",timetemp]];
//    
//    NSFileManager * filemanager = [NSFileManager defaultManager];
//    
//    BOOL isSuccess = [filemanager createFileAtPath:exportPath contents:dataVideo attributes:nil];
//    
//    NSLog(@"asdasd");
//    
//    
//    
//
//    if(![filemanager fileExistsAtPath:exportPath])
//    {
//                    [filemanager createDirectoryAtPath:exportPath withIntermediateDirectories:YES attributes:nil error:nil];
////        [filemanager createFileAtPath:exportPath contents:nil attributes:nil];
//        
//        
//    }
//
//    
//    

    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:videoFilepathURL options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality])
    {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
        
        NSString * filepath = [self filepath];
        NSString * timetemp = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
        
        NSString * filename = [NSString stringWithFormat:@"%@.mp4",timetemp];
        
        NSString * exportPath = [filepath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",filename]];

        exportSession.outputURL = [NSURL fileURLWithPath:exportPath];
        NSLog(@"%@", exportPath);
        exportSession.outputFileType = AVFileTypeMPEG4;

        //创建文件
//        NSFileManager * filemanager = [NSFileManager defaultManager];
//        if(![filemanager fileExistsAtPath:exportPath])
//        {
////            [filemanager createDirectoryAtPath:exportPath withIntermediateDirectories:YES attributes:nil error:nil];
//            [filemanager createFileAtPath:exportPath contents:nil attributes:nil];
//        }
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed:
                    NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
                    
                    if(finishBlock)
                    {
                        finishBlock(NO,nil);
                    }
                    break;
                case AVAssetExportSessionStatusCancelled:
                    NSLog(@"Export canceled");
                    break;
                case AVAssetExportSessionStatusCompleted:
                    NSLog(@"转换成功");
                    if(finishBlock)
                    {
                        finishBlock(YES,filename);
                    }
                    
                    break;
                default:
                    break;
            }
        }];
    }
}

/**
 *  文件是否存在
 */
+ (BOOL)fileIsExitAtFile:(NSString *)filepath
{
    if([filepath isKindOfClass:[NSURL class]])
    {
        return NO;
    }
    
    if(!filepath)
    {
        return NO;
    }
    
    NSFileManager * filemanager = [NSFileManager defaultManager];
    NSString * path = [self filepath];
    NSString * inputPath = [path stringByAppendingPathComponent:filepath];
    if([filemanager fileExistsAtPath:inputPath])
    {
        return YES;
    }
    return NO;
}


/**
 *  将下载下来的文件移动到note目录下 然后重命名
 */
+ (BOOL)moveFileAtPath:(NSString *)originPath andFileName:(NSString *)filename
{
    //  /var/mobile/Containers/Data/Application/A0AC2D0F-939F-4782-89EA-F4978E0BE8E1/Library/Caches/DownloadFile/01C7C570E94447C9AB380EDBD213DBBD.png
    NSFileManager * filemanager = [NSFileManager defaultManager];
    
    NSString * path = [self filepath];
    NSString * inputPath = [path stringByAppendingPathComponent:filename];
    
    if([filemanager moveItemAtPath:originPath toPath:inputPath error:nil])
    {
        [filemanager removeItemAtPath:originPath error:nil];
        return YES;
    }
    return NO;
}


+ (NSString *)filepath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString * filepath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"medias"]];
    
    NSFileManager * filemanager = [NSFileManager defaultManager];
    if(![filemanager fileExistsAtPath:filepath])
    {
        [filemanager createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
//    NSLog(@"##########  %@  #############",filepath);
    
    return filepath;
}



@end
