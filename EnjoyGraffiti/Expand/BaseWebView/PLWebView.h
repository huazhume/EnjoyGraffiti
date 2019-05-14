//
//  PLWebView.h
//  FaceLive
//
//  Created by zhangyi on 2017/7/12.
//  Copyright © 2017年 mty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"
#import <WebKit/WebKit.h>

@interface PLWebView : UIView

/**  webView */
@property(nonatomic , strong) WKWebView * webView;
/**  bridge */
@property(nonatomic , strong) WebViewJavascriptBridge * bridge;

@property(nonatomic , strong) UIProgressView * progressView;
/**  是否显示进度条(默认显示) */
@property(nonatomic , assign) BOOL hiddenProgress;

- (instancetype)initWithFrame:(CGRect)frame url:(NSString *)url;

-(void)loadWithUrl:(NSString *)url;


@end
