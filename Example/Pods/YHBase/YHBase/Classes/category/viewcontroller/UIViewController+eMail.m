//
//  UIViewController+eMail.m
//  SuoShi
//
//  Created by 林宁宁 on 16/1/26.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "UIViewController+eMail.h"
#import "UIView+BBX.h"



@implementation UIViewController (eMail)


////激活邮件功能
//- (void)sendMailInApp
//{
//    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
//    if (!mailClass) {
//        
//        [self.view showWithText:@"当前系统版本不支持应用内发送邮件功能，您可以使用mailto方法代替"];
//        
//        return;
//    }
//    if (![mailClass canSendMail]) {
//        
//        [self.view showWithText:@"用户没有设置邮件账户"];
//        return;
//    }
//    [self displayMailPicker];
//}
//
////调出邮件发送窗口
//- (void)displayMailPicker
//{
//    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
//    mailPicker.mailComposeDelegate = self;
//    //设置主题
//    [mailPicker setSubject: @"eMail主题"];
//    //添加收件人
//    NSArray *toRecipients = [NSArray arrayWithObject: @"first@example.com"];
//    [mailPicker setToRecipients: toRecipients];
//    //添加抄送
//    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
//    [mailPicker setCcRecipients:ccRecipients];
//    //添加密送
//    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
//    [mailPicker setBccRecipients:bccRecipients];
//    
//    // 添加一张图片
//    UIImage *addPic = [UIImage imageNamed: @"Icon@2x.png"];
//    NSData *imageData = UIImagePNGRepresentation(addPic);
//    
//    // png
//    //关于mimeType：http://www.iana.org/assignments/media-types/index.html
//    [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"Icon.png"];
//    
//    //添加一个pdf附件
//    NSString *file = [self fullBundlePathFromRelativePath:@"高质量C++编程指南.pdf"];
//    NSData *pdf = [NSData dataWithContentsOfFile:file];
//    [mailPicker addAttachmentData: pdf mimeType: @"" fileName: @"高质量C++编程指南.pdf"];
//    
//    //添加一个视频
//    NSString *path=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),@"20121219.avi"];
//    NSData *video = [NSData dataWithContentsOfFile:path];
//    [mailPicker addAttachmentData:video mimeType: @"" fileName:@"20121219.avi"];
//    NSString *emailBody = @"eMail 正文";
//    [mailPicker setMessageBody:emailBody isHTML:YES];
//    [self presentModalViewController: mailPicker animated:YES];
//    [mailPicker release];
//}
//#pragma mark - 实现 MFMailComposeViewControllerDelegate
//- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
//{    //关闭邮件发送窗口
//    [self dismissModalViewControllerAnimated:YES];
//    NSString *msg;
//    switch (result) {
//        case MFMailComposeResultCancelled:
//            msg = @"用户取消编辑邮件";
//            break;
//        case MFMailComposeResultSaved:
//            msg = @"用户成功保存邮件";
//            break;
//        case MFMailComposeResultSent:
//            msg = @"用户点击发送，将邮件放到队列中，还没发送";
//            break;
//        case MFMailComposeResultFailed:
//            msg = @"用户试图保存或者发送邮件失败";
//            break;
//        default:
//            msg = @"";
//            break;
//    }
//    [self alertWithMessage:msg];
//}


@end
