//
//  UIViewController+PicPicker.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/2.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PicPicker)<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (copy, nonatomic) void(^PickerFinishBlick)(UIImage * image, NSString * filePath, BOOL isVideo);


- (void)pickerImageFormAlbumWithFinshBlock:(void(^)(UIImage * image, NSString * filePath, BOOL isVideo))finshBlock;


@end
