//
//  UIViewController+Sheet.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/26.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "UIViewController+Sheet.h"
#import <objc/runtime.h>


@implementation UIViewController (Sheet)

-(void)setSheetClickBlick:(void (^)(NSUInteger, UIActionSheet *))SheetClickBlick
{
    objc_setAssociatedObject(self, @selector(SheetClickBlick), SheetClickBlick, OBJC_ASSOCIATION_RETAIN);
}

-(void (^)(NSUInteger, UIActionSheet *))SheetClickBlick
{
    return objc_getAssociatedObject(self, @selector(SheetClickBlick));
}


-(UIActionSheet *)showActionSheetWithTitle:(NSString *)title
                         cancelButtonTitle:(NSString *)cancelButtonTitle
                    destructiveButtonTitle:(NSString *)destructiveButtonTitle
                           completionBlock:(void (^)(NSUInteger, UIActionSheet *))block
                         otherButtonTitles:(NSArray *)otherTitles
{
    self.SheetClickBlick = block;
    
    UIActionSheet * actionSheetV = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    
    [otherTitles enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
       
        [actionSheetV addButtonWithTitle:obj];
        
    }];
    
    [actionSheetV addButtonWithTitle:cancelButtonTitle];
    
    actionSheetV.cancelButtonIndex = actionSheetV.numberOfButtons -1;
    
    return actionSheetV;
}




-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.SheetClickBlick)
    {
        self.SheetClickBlick(buttonIndex,actionSheet);
    }
    
    self.SheetClickBlick = nil;
}


@end
