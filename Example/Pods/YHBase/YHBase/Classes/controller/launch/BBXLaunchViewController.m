//
//  BBXLaunchViewController.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/16.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "BBXLaunchViewController.h"
#import "MacroAppInfo.h"

@interface BBXLaunchViewController ()

@end

@implementation BBXLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView * bgImg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImg.autoresizingMask = 0xff;
    
    if([MacroAppInfo isiPhone6P])
    {
        bgImg.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h"];
    }
    else if ([MacroAppInfo isiPhone6])
    {
        bgImg.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }
    else if ([MacroAppInfo isiPhone5])
    {
        bgImg.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    }
    else
    {
        bgImg.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    
    
    [self.view addSubview:bgImg];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"###_### viewDidAppear");
    
    if(self.launchShowBlock)
    {
        self.launchShowBlock();
    }
}

- (void)didReceiveMemoryWarning {
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
