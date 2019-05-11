//
//  PLWebView.m
//  FaceLive
//
//  Created by zhangyi on 2017/7/12.
//  Copyright © 2017年 mty. All rights reserved.
//

#import "PLWebView.h"

@interface PLWebView ()<WKUIDelegate,WKNavigationDelegate>


@end

@implementation PLWebView

- (instancetype)initWithFrame:(CGRect)frame url:(NSString *)url
{
    self = [super initWithFrame:frame];
    if (self) {
        WKWebViewConfiguration *webConfig = [[WKWebViewConfiguration alloc] init];
        self.webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:webConfig];
        self.webView.scrollView.bounces = YES;
        self.webView.allowsBackForwardNavigationGestures = YES;
        self.webView.UIDelegate = self;
        self.webView.navigationDelegate = self;
        [self addSubview:self.webView];
        [self setUpBridge];
        [self addSubview:self.progressView];
        [self bringSubviewToFront:self.progressView];
        [self addNotifications];
        
    }
    return self;
}


#pragma mark - Notification
- (void)addNotifications
{
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.1f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    }
}

-(void)setUpBridge{
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [_bridge setWebViewDelegate:self];
}


- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
    
}

//加载webView
-(void)loadWithUrl:(NSString *)url{
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    if ([url hasPrefix:@"http"]) {
        [self.webView loadRequest:request];
    } else {
        
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        NSString * htmlPath = [[NSBundle mainBundle] pathForResource:url
                                                              ofType:@"html"];
        NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                        encoding:NSUTF8StringEncoding
                                                           error:nil];
        [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    }
}

-(void)setHiddenProgress:(BOOL)hiddenProgress{
    _hiddenProgress = hiddenProgress;
    if (hiddenProgress) {
        //隐藏
        [self.progressView removeFromSuperview];
    }else{
        //显示
        self.progressView.hidden = NO;
    }
}

-(void)dealloc{
    if (self.webView) {
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
        self.webView = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - WKNavigationDelegate

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
    NSString *url = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    
    if ([url hasPrefix:@"itms"]) {
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

//开始加载
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
   
}

//加载完成
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}

//加载失败
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{

}

#pragma mark - 懒加载
-(UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _progressView.trackTintColor = [UIColor clearColor];
    
    }
    return _progressView;
}


@end
