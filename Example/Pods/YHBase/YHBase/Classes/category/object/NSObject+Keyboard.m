//
//  NSObject+Keyboard.m
//  LinTool
//
//  Created by 林宁宁 on 15/11/12.
//  Copyright © 2015年 000. All rights reserved.
//

#import "NSObject+Keyboard.h"
#import <objc/runtime.h>


@implementation NSObject (Keyboard)

-(void (^)(CGRect, NSTimeInterval, BOOL))keyBoardAnimationBlock
{
    return objc_getAssociatedObject(self, @selector(keyBoardAnimationBlock));
}


-(void)setKeyBoardAnimationBlock:(void (^)(CGRect, NSTimeInterval, BOOL))keyBoardAnimationBlock
{
    objc_setAssociatedObject(self, @selector(keyBoardAnimationBlock), keyBoardAnimationBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)registerKeyBoardNotifitionWithBlock:(void (^)(CGRect, NSTimeInterval, BOOL))keyBoardAnimationBlock
{
    self.keyBoardAnimationBlock = keyBoardAnimationBlock;
    
    // subscribe to keyboard animations
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


-(void)registerKeyBoardNotifitionRemove
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark private

// ----------------------------------------------------------------
- (void)keyboardWillShowNotification:(NSNotification *)notification {
    [self keyboardWillShowHide:notification isShowing:YES];
}

// ----------------------------------------------------------------
- (void)keyboardWillHideNotification:(NSNotification *)notification {
    [self keyboardWillShowHide:notification isShowing:NO];
}

- (void)keyboardWillShowHide:(NSNotification *)notification isShowing:(BOOL)isShowing {
    // getting keyboard animation attributes
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [UIView setAnimationCurve:curve];
                         
                         if(self.keyBoardAnimationBlock)
                         {
                             self.keyBoardAnimationBlock(keyboardRect,duration,isShowing);
                         }
                         
                     }
                     completion:nil];
}



@end
