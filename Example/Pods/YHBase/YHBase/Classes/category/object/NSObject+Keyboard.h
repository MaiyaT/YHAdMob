//
//  NSObject+Keyboard.h
//  LinTool
//
//  Created by 林宁宁 on 15/11/12.
//  Copyright © 2015年 000. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Keyboard)

/**
 *  事件回调
 */
@property (copy, nonatomic) void(^keyBoardAnimationBlock)(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing);

- (void)registerKeyBoardNotifitionWithBlock:(void(^)(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing))keyBoardAnimationBlock;

- (void)registerKeyBoardNotifitionRemove;

@end
