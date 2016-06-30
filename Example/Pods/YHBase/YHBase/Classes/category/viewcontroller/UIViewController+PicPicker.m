//
//  UIViewController+PicPicker.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/2.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "UIViewController+PicPicker.h"
#import "UIViewController+Sheet.h"
#import <objc/runtime.h>
#import "AppDelegateBase.h"
#import "UIView+BBX.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "BBXTool.h"
#import "AHKActionSheet.h"


@implementation UIViewController (PicPicker)


-(void)setPickerFinishBlick:(void (^)(UIImage *, NSString *, BOOL))PickerFinishBlick
{
    objc_setAssociatedObject(self, @selector(PickerFinishBlick), PickerFinishBlick, OBJC_ASSOCIATION_COPY);
}

-(void (^)(UIImage *, NSString *, BOOL))PickerFinishBlick
{
    return objc_getAssociatedObject(self, @selector(PickerFinishBlick));
}



-(void)pickerImageFormAlbumWithFinshBlock:(void (^)(UIImage *, NSString *, BOOL))finshBlock
{
    self.PickerFinishBlick = finshBlock;
    
    __weak typeof(&*self)weakSelf = self;
    
    AHKActionSheet *actionV = [[AHKActionSheet alloc] initWithTitle:@"选择图片或者视频"];

    actionV.cancelButtonTitle = @"取消";
    
    [actionV addButtonWithTitle:@"拍照/录像" type:AHKActionSheetButtonTypeDefault handler:^(AHKActionSheet *actionSheet) {
        
        //拍照上传
        UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            ipc.sourceType=UIImagePickerControllerSourceTypeCamera;
            
            ipc.mediaTypes = @[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie];
            
            //                ipc.mediaTypes = [NSArray arrayWithObjects:@"public.movie", @"public.image", nil];
            
            ipc.videoQuality = UIImagePickerControllerQualityTypeMedium; //录像质量
            ipc.delegate=self;
            ipc.allowsEditing=NO;
            
            if([[[UIDevice
                  currentDevice] systemVersion] floatValue]>=8.0) {
                
                weakSelf.modalPresentationStyle=UIModalPresentationOverCurrentContext;
                
            }
            
            [[[AppDelegateBase shareAppDelegate]rootNavc] presentViewController:ipc animated:YES completion:nil];
        }
        else
        {
            [weakSelf.view showWithText:@"不支持摄像"];
        }
        
    }];
    
    
    [actionV addButtonWithTitle:@"手机相册图库" type:AHKActionSheetButtonTypeDefault handler:^(AHKActionSheet *actionSheet) {
        
        //手机相册
        
        UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
        ipc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            ipc.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        }
        else
        {
            ipc.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        ipc.delegate=self;
        ipc.allowsEditing=NO;
        
        if([[[UIDevice
              currentDevice] systemVersion] floatValue]>=8.0) {
            
            weakSelf.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            
        }
        
        [[[AppDelegateBase shareAppDelegate]rootNavc] presentViewController:ipc animated:YES completion:nil];
    }];
    
    [actionV show];
    
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *) info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *img=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSString * type             = info[@"UIImagePickerControllerMediaType"];
    NSString * fileMediaurl     = info[@"UIImagePickerControllerMediaURL"];
    NSString * filePicurl       = info[@"UIImagePickerControllerReferenceURL"];

    BOOL isMoive = [type isEqualToString:@"public.movie"];
    
    if(isMoive && [fileMediaurl isKindOfClass:[NSURL class]])
    {
        img = [BBXTool getVideoImageConbainLogoWithURL:(NSURL *)fileMediaurl];
    }
    
    if(self.PickerFinishBlick)
    {
        self.PickerFinishBlick(img,isMoive?fileMediaurl:filePicurl,isMoive);
    }
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
