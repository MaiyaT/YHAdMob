//
//  BBXBaseNAVController.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/25.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "BBXBaseNAVController.h"
//#import <UINavigationController+FDFullscreenPopGesture.h>
#import "UIColor+BBXApp.h"
#import "MacroAppInfo.h"
#import "UIFont+BBX.h"

@interface BBXBaseNAVController ()

@end

@implementation BBXBaseNAVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置NavigationBar背景颜色
    [[UINavigationBar appearance] setBackgroundImage:[[self getThemeColor] drawImageWithColor] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //@{}代表Dictionary
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont bbxSystemFont:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (BOOL)shouldAutorotate
{
    if([self canAutorotate])
    {
        return YES;
    }
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if([self canAutorotate])
    {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if([self canAutorotate])
    {
        return YES;
    }
    return NO;
}



- (BOOL)canAutorotate
{
    return YES;
}

- (UIColor *)getThemeColor
{
    return [UIColor bbxThemeColor];
}

- (void)didReceiveMemoryWarning {
    
    
    NSLog(@"ASDASDASDAS");
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
