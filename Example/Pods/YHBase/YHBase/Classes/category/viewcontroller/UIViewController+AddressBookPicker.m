//
//  UIViewController+AddressBookPicker.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/8/6.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "UIViewController+AddressBookPicker.h"
#import <objc/runtime.h>


@implementation UIViewController (AddressBookPicker)

-(void (^)(NSString *, NSString *))AddressBookSelectBolck
{
    return objc_getAssociatedObject(self, @selector(AddressBookSelectBolck));
}

-(void)setAddressBookSelectBolck:(void (^)(NSString *, NSString *))AddressBookSelectBolck
{
    objc_setAssociatedObject(self, @selector(AddressBookSelectBolck), AddressBookSelectBolck, OBJC_ASSOCIATION_COPY_NONATOMIC);
}




-(void)openPickerAddressBookWithFinishBlock:(void (^)(NSString *, NSString *))finishBlock
{
    self.AddressBookSelectBolck = finishBlock;
    
    ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    peoplePicker.peoplePickerDelegate = self;
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        peoplePicker.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
    }
    [self presentViewController:peoplePicker animated:YES completion:nil];
}
/*
 Discussion
 该方法在用户选择通讯录一级列表的某一项时被调用,通过person可以获得选中联系人的所有信息,但当选中的联系人有多个号码,而我们又希望用户可以明确的指定一个号码时(如拨打电话),返回YES允许通讯录进入联系人详情界面:
 */
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}


/*
 Discussion
 当用户进入单个联系人信息（二级页面）点击某个字段时,会调用如下方法,返回YES继续进入下一步，点击NO不进入下一步，比如点击电话，返回YES就拨打电话，返回NO不会拨打电话:
 */
- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    
    CFTypeRef firstName, lastName;
    
    //名
    firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    //姓
    lastName  = ABRecordCopyValue(person, kABPersonLastNameProperty);
    //    phoneNum = ABRecordCopyValue(person, <#ABPropertyID property#>)
    
    
    NSMutableString * nickName = [[NSMutableString alloc] init];
    if(lastName)
    {
        [nickName appendFormat:@"%@",lastName];
    }
    if(firstName)
    {
        [nickName appendFormat:@"%@",firstName];
    }
    
    NSString * phoneNum;
    
    ABMultiValueRef phones = (ABMultiValueRef)ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    for (int i = 0; i < ABMultiValueGetCount(phones); i++)
    {
        NSString *phone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i);
        
        phoneNum = phone;

    }
    
    
    
    if(self.AddressBookSelectBolck)
    {
        self.AddressBookSelectBolck(nickName,phoneNum);
    }
    
    
    if(phones)
    {
        CFRelease(phones);
    }
    
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    //虽然使用了ARC模式，但是Core Foundation框架 (CoreFoundation.framework) PS：CF开头的任然需要手动控制内存（CFRELESE）
    
    if(firstName)
    {
        CFRelease(firstName);
    }
    
    if(lastName)
    {
        CFRelease(lastName);
    }
    
    return NO;
    
}


- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    [peoplePicker pushViewController:personViewController animated:YES];
}

// Called after a property has been selected by the user.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    
    @try {
    
        index = (index<0)?0:index;
        
        NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
        
        CFTypeRef firstName, lastName;
        
        //名
        firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        
        //姓
        lastName  = ABRecordCopyValue(person, kABPersonLastNameProperty);
        //    phoneNum = ABRecordCopyValue(person, <#ABPropertyID property#>)
        
        
        NSMutableString * nickName = [[NSMutableString alloc] init];
        if(lastName)
        {
            [nickName appendFormat:@"%@",lastName];
        }
        if(firstName)
        {
            [nickName appendFormat:@"%@",firstName];
        }

        
        if(self.AddressBookSelectBolck)
        {
            self.AddressBookSelectBolck(nickName,phoneNO);
        }
        
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
        
    }
    @catch (NSException *exception) {
        NSAssert(FALSE, [exception description]);
    }
    @finally {
        
    }
    
}


/*
 Discussion
 当用户离开单个联系人信息（二级页面）点击某个字段时调用
 */
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}


@end
