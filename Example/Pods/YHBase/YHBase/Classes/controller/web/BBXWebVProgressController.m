//
//  BBXWebVProgressController.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/8/7.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "BBXWebVProgressController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "UIColor+BBXApp.h"
#import "SVProgressHUD.h"


@interface BBXWebVProgressController ()<UIWebViewDelegate, NJKWebViewProgressDelegate>
{
    UIWebView * _webView;
    
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@end



@implementation BBXWebVProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!_webView)
    {
        dispatch_async(dispatch_get_main_queue(), ^{

            [SVProgressHUD show];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [self creatWebview];
            
            [self.navigationController.navigationBar addSubview:_progressView];
        });
    }
    else
    {
        [self.navigationController.navigationBar addSubview:_progressView];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_progressView removeFromSuperview];
}


- (void)creatWebview
{
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.autoresizingMask = 0xff;
    _webView.delegate = self;
    
    [self.view addSubview:_webView];
    
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _progressView.progressBarView.backgroundColor = [UIColor colorWithHexString:@"ec1b8d"];
    _progressView.fadeOutDelay = 0.3;
    
    
    if(self.url)
    {
        [self setRightNavigationItemBarWithImg:@"web_refresh"
                                  andSelectImg:@"web_refresh"
                                      andTitle:nil
                                andSelectTitle:nil
                                      andEvent:@selector(refreshEvent)
                                     andTarget:self
                                       andSize:CGSizeMake(40, 30)
                                andFinishBlock:^(UIButton * sender) {
                                    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                }];
        
        [self setRightNavigationItemBarWithImg:@"web_forward"
                                  andSelectImg:@"web_forward"
                                      andTitle:nil
                                andSelectTitle:nil
                                      andEvent:@selector(gaForward)
                                     andTarget:self
                                       andSize:CGSizeMake(40, 30)
                                andFinishBlock:^(UIButton * sender) {
                                    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                }];
        
        
        [self setRightNavigationItemBarWithImg:@"web_back"
                                  andSelectImg:@"web_back"
                                      andTitle:nil
                                andSelectTitle:nil
                                      andEvent:@selector(goBack)
                                     andTarget:self
                                       andSize:CGSizeMake(40, 30)
                                andFinishBlock:^(UIButton * sender) {
                                    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                }];
        
        
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
        [_webView loadRequest:req];
    }
    else if (self.htmlContent)
    {
        [_webView loadHTMLString:self.htmlContent baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    }
    else if (self.filename)
    {
        NSString* path = [[NSBundle mainBundle] pathForResource:self.filename ofType:@"html"];
        if(path)
        {
            NSURL* url = [NSURL fileURLWithPath:path];
            NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
            [_webView loadRequest:request];
        }
    }
}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}



-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
    
    [self moveRefreshActivity];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
    
    [self moveRefreshActivity];
}




#pragma mark - 视图刷新 前进 后退

-(void)refreshEvent
{
    if(!self.navRightBar.selected)
    {
        self.navRightBar.selected = YES;
        
        [self beginAnimation];
        
        CGRect oldRect = _progressView.frame;
        oldRect.size.width = 0;
        _progressView.frame = oldRect;
        [_webView reload];
    }
}

- (void)gaForward
{
    [_webView goForward];
}

- (void)goBack
{
    [_webView goBack];
}


- (void)beginAnimation
{
    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = FLT_MAX;
    rotationAnimation.removedOnCompletion = NO;
    [self.navRightBar.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)moveRefreshActivity
{
    self.navRightBar.selected = NO;
    
    [self.navRightBar.layer removeAllAnimations];
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
