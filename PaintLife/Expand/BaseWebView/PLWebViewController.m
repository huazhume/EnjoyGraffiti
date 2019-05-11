//
//  PLWebViewController.m
//  FaceLive
//
//  Created by zhangyi on 2017/7/12.
//  Copyright © 2017年 mty. All rights reserved.
//

#import "PLWebViewController.h"
#import "FLPaintNavigationView.h"


@interface PLWebViewController () <FLPaintNavigationViewDelegate>

/**  closeButton */
@property(nonatomic , strong) UIButton * closeButton;
@property(nonatomic , strong) UIButton * backButton;

@property(nonatomic, assign) NSInteger extraType;
@property(nonatomic, strong) FLPaintNavigationView *navigationView;


@end

@implementation PLWebViewController

-(instancetype)initWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)setNavigationTitle:(NSString *)navigationTitle
{
    _navigationTitle = navigationTitle;
    self.navigationView.navigationTitle = navigationTitle;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.navigationView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[PLWebView alloc] initWithFrame:CGRectMake(0, self.isShowNavigation ? 55 + iPhoneTopMargin : 0, SCREEN_WIDTH , SCREEN_HEIGHT - (self.isShowNavigation ? 55 + iPhoneTopMargin : 0) ) url:self.url];
    [self.webView loadWithUrl:_url];

    [self.view addSubview:_webView];
    [self registNotification];
    self.navigationView.hidden = !self.isShowNavigation;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)reloadData{
    [self.webView loadWithUrl:_url];
}

-(void)leftBarButtonClick{
    if (_webView.webView.canGoBack) {
        [_webView.webView goBack];
    }else{
        if (self.dismissBlock) {
            self.dismissBlock();
        }
        if (self.isDisMiss) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - FLPaintNavigationViewDelegate
- (void)leftAction
{
    if (self.isDisMiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - notification
- (void)registNotification
{
    [self.webView.webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    self.url = self.webView.webView.URL.absoluteString;
}

-(void)closeCurrentPage{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [self.webView.webView removeObserver:self forKeyPath:@"URL"];
    if (_webView) {
        _webView.bridge = nil;
        _webView = nil;
    }
}

#pragma mark - invokeMethod
- (void)dismissWebView
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - PLWebViewDelegate
-(void)backActionCallBack:(BOOL)backRoot{
    if (backRoot) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self leftBarButtonClick];
    }
}

#pragma mark - 懒加载
- (FLPaintNavigationView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [FLPaintNavigationView loadFromNib];
        _navigationView.frame = CGRectMake(0, iPhoneTopMargin, SCREEN_WIDTH, 55);
        _navigationView.delegate = self;
        _navigationView.rightTitle = @"";
        _navigationView.navigationTitle = @"";
    }
    return _navigationView;
}

@end
