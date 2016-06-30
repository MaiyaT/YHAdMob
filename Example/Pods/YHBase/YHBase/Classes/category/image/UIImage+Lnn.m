//
//  UIImage+Lnn.m
//  SuoShi
//
//  Created by 林宁宁 on 15/12/18.
//  Copyright © 2015年 林宁宁. All rights reserved.
//

#import "UIImage+Lnn.h"

@implementation UIImage (Lnn)


//1.根据给定得图片，从其指定区域截取一张新得图片  截图的区域
-(UIImage *)getImagePointArea:(CGRect)areaFrame
{
    CGImageRef imageRef = self.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, areaFrame);
    CGSize size;
    size.width = areaFrame.size.width;
    size.height = areaFrame.size.height;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, areaFrame, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}

//针对ＵIImage得一些常用缩放得方法：
-(UIImage*)resizedToRect:(CGRect)thumbRect
{
    UIGraphicsBeginImageContext(thumbRect.size);
    [self drawInRect:thumbRect];
    return UIGraphicsGetImageFromCurrentImageContext();
}


-(UIImage*)resizedToRect2:(CGRect)thumbRect
{
    CGImageRef          imageRef = [self CGImage];
    CGImageAlphaInfo    alphaInfo = CGImageGetAlphaInfo(imageRef);

    if (alphaInfo == kCGImageAlphaNone)
        alphaInfo = kCGImageAlphaNoneSkipLast;
    // Build a bitmap context that's the size of the thumbRect
    CGFloat bytesPerRow;
    if( thumbRect.size.width > thumbRect.size.height ) {
        bytesPerRow = 4 * thumbRect.size.width;
    } else {
        bytesPerRow = 4 * thumbRect.size.height;
    }
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                thumbRect.size.width,       // width
                                                thumbRect.size.height,      // height
                                                8, //CGImageGetBitsPerComponent(imageRef),  // really needs to always be 8
                                                bytesPerRow, //4 * thumbRect.size.width,    // rowbytes
                                                CGImageGetColorSpace(imageRef),
                                                alphaInfo
                                                );
    // Draw into the context, this scales the image
    CGContextDrawImage(bitmap, thumbRect, imageRef);
    // Get an image from the context and a UIImage
    CGImageRef  ref = CGBitmapContextCreateImage(bitmap);
    UIImage*    result = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);   // ok if NULL
    CGImageRelease(ref);
    return result;
}


- (UIImage *)scaleMaxWidth:(float) maxWidth maxHeight:(float) maxHeight
{
//    CGImageRef imgRef = self.CGImage;
//    CGFloat width = CGImageGetWidth(imgRef);
//    CGFloat height = CGImageGetHeight(imgRef);
    
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;

    if (width <= maxWidth && height <= maxHeight)
    {
        return self;
    }
    
    CGImageRef imgRef = self.CGImage;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > maxWidth || height > maxHeight)
    {
        CGFloat ratio = width/height;
        if (ratio > 1)
        {
            bounds.size.width = maxWidth;
            bounds.size.height = bounds.size.width / ratio;
        }
        else
        {
            bounds.size.height = maxHeight;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    CGFloat scaleRatio = bounds.size.width / width;
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, scaleRatio, -scaleRatio);
    CGContextTranslateCTM(context, 0, -height);
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}



- (UIImage *)scaleMaxWidth:(float) maxWidth
{
    CGImageRef imgRef = self.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    if (width <= maxWidth)
    {
        return self;
    }
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > maxWidth)
    {
        bounds.size.width = maxWidth;
        bounds.size.height = (int)maxWidth * height /width;
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, scaleRatio, -scaleRatio);
    CGContextTranslateCTM(context, 0, -height);
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}



@end
