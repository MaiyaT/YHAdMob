//
//  UIViewController+Sheet.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/26.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Sheet)<UIActionSheetDelegate>

@property (strong, nonatomic) void(^SheetClickBlick)(NSUInteger buttonIndex, UIActionSheet *sheetView);

- (UIActionSheet *)showActionSheetWithTitle:(NSString *)title
                          cancelButtonTitle:(NSString *)cancelButtonTitle
                     destructiveButtonTitle:(NSString *)destructiveButtonTitle
                            completionBlock:(void (^)(NSUInteger buttonIndex, UIActionSheet *sheetView))block
                          otherButtonTitles:(NSArray *)otherTitles;


@end
