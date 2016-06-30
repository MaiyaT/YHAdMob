//
//  BBXGuideViewController.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/8/5.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "BBXGuideViewController.h"
#import "Masonry.h"
#import "MacroAppInfo.h"
#import "UIColor+BBXApp.h"


@interface BBXGuideViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollV;
    
    UIPageControl * _pageControl;
}
@end

@implementation BBXGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"使用帮助";
    
    if([MacroAppInfo isiPhone6P])
    {
        self.listImageS = @[@"guide_5_5_1",@"guide_5_5_2",@"guide_5_5_3"];
    }
    else if ([MacroAppInfo isiPhone6])
    {
        self.listImageS = @[@"guide_4_7_1",@"guide_4_7_2",@"guide_4_7_3"];
    }
    else if ([MacroAppInfo isiPhone5])
    {
        self.listImageS = @[@"guide_4_1",@"guide_4_2",@"guide_4_3"];
    }
    else
    {
        self.listImageS = @[@"guide_3_5_1",@"guide_3_5_2",@"guide_3_5_3"];
    }
    
    
    _scrollV = [[UIScrollView alloc] init];
    _scrollV.showsHorizontalScrollIndicator = NO;
    _scrollV.delegate = self;
    _scrollV.pagingEnabled = YES;
    [self.view addSubview:_scrollV];
    
    
    __weak typeof(&*self)weakSelf = self;
    __weak typeof(&*_scrollV)weakScrollV = _scrollV;
    
    [_scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    
    __weak UIView * lastV;
    
    for(NSString * imgName in self.listImageS)
    {
        UIImage * img = [UIImage imageNamed:imgName];
        
        UIImageView * imgV = [[UIImageView alloc] initWithImage:img];
        imgV.clipsToBounds = YES;
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollV addSubview:imgV];
        
        BOOL isLastOne = [imgName isEqualToString:[self.listImageS lastObject]];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf.view);
            make.width.equalTo(weakScrollV);

            if(lastV)
            {
                make.left.equalTo(lastV.mas_right);
            }
            else
            {
                make.left.equalTo(weakScrollV);
            }
            
            if(isLastOne)
            {
                make.right.equalTo(weakScrollV);
            }
        }];
        
        lastV = imgV;
    }
    
    
    UIButton * btnEnter = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnEnter setImage:[UIImage imageNamed:@"btn_goo"] forState:UIControlStateNormal];
    [btnEnter addTarget:self action:@selector(enterEvent) forControlEvents:UIControlEventTouchUpInside];
    btnEnter.backgroundColor = [UIColor clearColor];
    lastV.userInteractionEnabled = YES;
    [lastV addSubview:btnEnter];
    
    
    _pageControl = [[UIPageControl alloc] init];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor bbxThemeColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor bbxTextNoteColor]];
    [_pageControl setHidesForSinglePage:YES];
    _pageControl.numberOfPages = self.listImageS.count;
    [self.view addSubview:_pageControl];
    
    
    __weak typeof(&*lastV)weakLastV = lastV;
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(weakSelf.view);
    }];
    
    [btnEnter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakLastV);
        make.size.mas_equalTo(CGSizeMake(116, 40));
        make.bottom.equalTo(weakLastV.mas_bottom).offset(-50);
    }];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)enterEvent
{
    [[MacroAppInfo shareManager] updateGuidState];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    if(self.enterAppBlock)
    {
        self.enterAppBlock();
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%f",scrollView.contentOffset.x);
    
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger index = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    _pageControl.currentPage = index;
    
    float offx = pageWidth * (self.listImageS.count - 1) - scrollView.contentOffset.x;
    NSLog(@"%f",offx);
    
    if(offx < -30)
    {
        [self enterEvent];
    }
    

    
    
//    NSLog(@"%d",(int)index);
    
//    if(_pageContoller.currentPage != index)
//    {
//        _pageContoller.currentPage = index;
//        
//        [self updateOrderContentIndex:index];
//    }
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
