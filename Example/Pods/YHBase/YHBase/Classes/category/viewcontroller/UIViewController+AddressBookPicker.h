//
//  UIViewController+AddressBookPicker.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/8/6.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

/**
 *  打开通讯录选择
 */
@interface UIViewController (AddressBookPicker)<ABPeoplePickerNavigationControllerDelegate,UINavigationControllerDelegate>


@property (copy, nonatomic) void(^AddressBookSelectBolck)(NSString * userName, NSString * phoneNum);


- (void)openPickerAddressBookWithFinishBlock:(void(^)(NSString * userName, NSString * phoneNum))finishBlock;

@end
