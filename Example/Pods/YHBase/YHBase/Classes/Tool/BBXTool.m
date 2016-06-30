//
//  BBXTool.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/22.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "BBXTool.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImage+BBX.h"
#import <CoreText/CoreText.h>
#import "NSString+BBX.h"
#import "EditFileManager.h"
#import "UIColor+BBXApp.h"
#import "UIFont+BBX.h"


@implementation BBXTool

+(void)callPhoneWithNum:(NSString *)phoneNum atView:(UIView *)aimView
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNum];
    UIWebView * callWebview = [[UIWebView alloc] init];
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [aimView addSubview:callWebview];
}



+ (NSString*) uuid
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    
    return result;
}


+ (UIImage *)getFirstVideoWithURL:(NSURL *)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}

+ (UIImage *)getVideoImageConbainLogoWithURL:(NSURL *)videoURL
{
    UIImage * img = [self getFirstVideoWithURL:videoURL];
    if(!img)
    {
        img = [UIImage imageNamed:@"icon180"];
    }
    
    //加上视频的图片
    img = [img addImage:[UIImage imageNamed:@"edit_attach_video"]];
    
    return img;
}


+(NSString*)timeStringForTimeInterval:(NSTimeInterval)timeInterval
{
    NSInteger ti = (NSInteger)timeInterval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    
    if (hours > 0)
    {
        return [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
    }
    else
    {
        return  [NSString stringWithFormat:@"%02li:%02li", (long)minutes, (long)seconds];
    }
}


+ (float)getAudioDurationWithFilaname:(NSString *)filename
{
    NSString * filepath = [EditFileManager getFilaPathWithName:filename];
    
    AVAudioPlayer * audioPlayer =  [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filepath] error:nil];
    float duration = audioPlayer.duration;
    
    return duration;
}

/**
 *  获取音频的图片
 */
+ (UIImage *)getAudioImageWithDuration:(float)duration
{
//    NSString * timeStr = [NSString stringWithFormat:@"%.1f",duration];
//
//    duration = [timeStr floatValue];
//
    
    UIImage * imgAudio = [UIImage imageNamed:@"audio_icon"];
    
    
    NSString * titleStr = [NSString stringWithFormat:@"%.1f",duration];
    
    [titleStr stringByReplacingOccurrencesOfString:@".00" withString:@""];
    if([titleStr hasSuffix:@"0"] && [titleStr containStr:@"."])
    {
        titleStr = [titleStr substringToIndex:titleStr.length-2];
    }
    
    titleStr = [NSString stringWithFormat:@"%@s",titleStr];
    
    int lengthTime = (int)(titleStr.length-5)>0?((int)titleStr.length-5):0;
    int appendLength = lengthTime*16;
    
    //上下文的大小
    int w = imgAudio.size.width + 90 + appendLength;
    int h = imgAudio.size.height;
    
    //不超过屏幕的大小
    w = MIN(w, [[UIScreen mainScreen] bounds].size.width - 20);
    
    //开启上下文
    //size新图片的大小
    //opaque YES不透明 NO透明
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), NO, 0.0);
    

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextStrokeRect(context,CGRectMake(0, 0, w, h));//画方框
    CGContextFillRect(context,CGRectMake(0, 0, w, h));//填充框
    //矩形，并填弃颜色
    CGContextSetLineWidth(context, 0.5);//线的宽度
    UIColor * aColor = [UIColor whiteColor];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    aColor = [UIColor bbxThemeColor];
    CGContextSetStrokeColorWithColor(context, aColor.CGColor);//线框颜色
    CGContextAddRect(context,CGRectMake(0, 0, w, h));//画方框
    CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
    
    [imgAudio drawAtPoint:CGPointZero];
    
    float fontSize = 30;
    NSDictionary *dict = @{
                           NSFontAttributeName : [UIFont bbxSystemFont:fontSize],
                           NSForegroundColorAttributeName : [UIColor bbxThemeColor]
                           };

    [titleStr drawAtPoint:CGPointMake(imgAudio.size.width + 5,MAX((h - fontSize)*0.5-3, 0)) withAttributes:dict];
    
    //获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (long long)fileSizeAtPath:(NSString*) filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath])
    {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize]/1024;
    }
    return 0;
}


@end
