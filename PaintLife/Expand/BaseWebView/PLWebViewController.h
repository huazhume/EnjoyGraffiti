//
//  PLWebViewController.h
//  FaceLive
//
//  Created by zhangyi on 2017/7/12.
//  Copyright © 2017年 mty. All rights reserved.
//

#import "FLBaseViewController.h"
#import "PLWebView.h"


typedef void(^DissmissBlock)(void);

@interface PLWebViewController :FLBaseViewController


@property(nonatomic , copy) DissmissBlock dismissBlock;

@property(nonatomic , strong) PLWebView *webView;
@property(nonatomic , copy) NSString * url;

//@property(nonatomic , copy) NSString * customTitle;

@property(nonatomic , assign) BOOL isDisMiss;

@property(nonatomic , copy) NSString * navigationTitle;

@property(nonatomic , assign) BOOL isShowNavigation;

-(instancetype)initWithUrl:(NSString *)url;



@end