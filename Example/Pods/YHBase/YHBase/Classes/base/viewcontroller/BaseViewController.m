//
//  BaseViewController.m
//  LinTool
//
//  Created by 林宁宁 on 15/9/21.
//  Copyright © 2015年 000. All rights reserved.
//

#import "BaseViewController.h"
#import "UIColor+BBXApp.h"

#import <objc/runtime.h>
#import "MacroAppInfo.h"
#import "UIFont+BBX.h"
#import "SVProgressHUD.h"

//#import "GDTMobBannerView.h"
//#import "BannerManager.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>


//@property (retain, nonatomic) GDTMobBannerView * bannerVGDT;



@end

@implementation BaseViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor bbxBackgroundColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setBackBarItem];
    
    if(!self.isCustomBackBtn)
    {
        [self setLeftPopback];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if(self.cannotPanToPop)
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    else
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    if(!_isBuildedWillAppear)
    {
        _isBuildedWillAppear = YES;
        
        [self buildContentViewWillAppear];
    }
    
    if(!_isBuildedWillAppearDealay)
    {
        _isBuildedWillAppearDealay = YES;
        
        [self performSelector:@selector(buildContentViewWillAppearDelay) withObject:nil afterDelay:0.1];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [self.navigationController.view endEditing:YES];
    
    
    [super viewWillDisappear:animated];
    
    //    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
    
    //    if(self.cannotPanToPop)
    //    {
    //        // 禁用 iOS7 返回手势
    //        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //        }
    //    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    
    if(!self.parentViewController)
    {
        [self viewWillDeallocEvent];

        objc_removeAssociatedObjects(self.view);
        objc_removeAssociatedObjects(self);
    }
    
    [SVProgressHUD dismiss];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!_isBuildedDidAppear)
    {
        _isBuildedDidAppear = YES;
        
        [self buildContentViewDidAppear];
    }
    
    
    if(!_isBuildedDidAppearDealay)
    {
        _isBuildedDidAppearDealay = YES;
        
        [self performSelector:@selector(buildContentViewDidAppearDelay) withObject:nil afterDelay:0.5];
    }
}


/**
 *  视图要释放
 */
- (void)viewWillDeallocEvent
{
    
}

/**
 *  创建视图
 */
- (void)buildContentViewWillAppear
{
    
}

-(void)buildContentViewDidAppear
{
    
}

-(void)buildContentViewWillAppearDelay
{
    
}

-(void)buildContentViewDidAppearDelay
{
    
}



/**
 *  设置返回的按钮
 */
- (void)setLeftPopback
{
    [self setLeftNavigationItemBarWithImg:@"btn_back_nor" andSelectImg:@"btn_back_down" andTitle:nil andSelectTitle:nil andEvent:@selector(backEvent) andTarget:self andSize:CGSizeMake(40,30) andFinishBlock:nil];
}

- (void)setLeftNavigationItemBarWithImg:(NSString *)imgURL andSelectImg:(NSString *)imgSelect andTitle:(NSString *)title andSelectTitle:(NSString *)selectTitle andEvent:(SEL)event andTarget:(id)target andSize:(CGSize)size andFinishBlock:(void (^)(UIButton *))barBtnBlock
{
    NSString *imgPath = imgURL?imgURL:@"navc_back";
    NSString *imgPathSelect = imgSelect?imgSelect:@"navc_back";
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0.0f, 0.0f, 25.0f, 25.0f)];
    self.navLeftBar = leftButton;
    [leftButton setImage:[UIImage imageNamed:imgPath] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:imgPathSelect] forState:UIControlStateHighlighted];
    
    leftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton setTitle:selectTitle forState:UIControlStateSelected];
    
    
    [leftButton.titleLabel setFont:[UIFont bbxSystemFont:12]];
    
    if (event)
    {
        [leftButton addTarget:target action:event forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(!CGSizeEqualToSize(size, CGSizeZero))
    {
        CGRect rectNow = leftButton.frame;
        rectNow.size = size;
        leftButton.frame = rectNow;
    }
    
    UIBarButtonItem * itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    itemSpace.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[itemSpace,[[UIBarButtonItem alloc] initWithCustomView:leftButton]];
    
    if(barBtnBlock)
    {
        barBtnBlock(leftButton);
    }
    
    if(!self.cannotPanToPop)
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)setRightNavigationItemBarWithImg:(NSString *)imgURL andSelectImg:(NSString *)imgSelect andTitle:(NSString *)title andSelectTitle:(NSString *)selectTitle andEvent:(SEL)event andTarget:(id)target andSize:(CGSize)size andFinishBlock:(void (^)(UIButton *))barBtnBlock
{
    NSString *imgPath = imgURL?imgURL:@"navc_back";
    NSString *imgPathSelect = imgSelect?imgSelect:@"navc_back";
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    rightButton.titleLabel.font = [UIFont bbxSystemFont:14];
    [rightButton setImage:[UIImage imageNamed:imgPath] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:imgPathSelect] forState:UIControlStateHighlighted];
    
    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitle:selectTitle forState:UIControlStateSelected];
    
    if(!imgURL)     //图片地址是空的 就是显示listmenu的按钮
    {
        //        [listBut addTarget:self action:@selector(listButAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(event)
    {
        [rightButton addTarget:target action:event forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(!CGSizeEqualToSize(size, CGSizeZero))
    {
        CGRect rectNow = rightButton.frame;
        rectNow.size = size;
        rightButton.frame = rectNow;
    }
    
    UIBarButtonItem * itemRight = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    UIBarButtonItem * itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    itemSpace.width = -15;
    
    NSMutableArray * barTtems = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [barTtems addObject:itemSpace];
    [barTtems addObject:itemRight];
    self.navigationItem.rightBarButtonItems = barTtems;
    
    self.navRightBar = (UIButton *)[[self.navigationItem.rightBarButtonItems firstObject] customView];
    
    if(barBtnBlock)
    {
        barBtnBlock(rightButton);
    }
}

- (void)backEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setBackBarItem
{
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



-(BOOL)prefersStatusBarHidden
{
    return [MacroAppInfo shareManager].statusBarIsHidden;
}


-(void)dealloc
{
    
    
    NSLog(@"#########________释放视图%@_________#########",NSStringFromClass([self class]));
}


- (void)didReceiveMemoryWarning {
    
    NSLog(@"收到内存警告%@",NSStringFromClass([self class]));
    
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
