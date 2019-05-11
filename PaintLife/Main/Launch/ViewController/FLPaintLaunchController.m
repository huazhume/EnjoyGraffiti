//
//  FLPaintLaunchController.m
//  PaintLife
//
//  Created by xiaobai zhang on 2019/3/26.
//  Copyright © 2019 xiaobai zhang. All rights reserved.
//

#import "FLPaintLaunchController.h"
#import "ViewController.h"
#import "PLWebViewController.h"
#import "FLPaintUserInfoDefault.h"


@interface FLPaintLaunchController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textLabel;

@end

@implementation FLPaintLaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseViews];
    [PTStashFiles stashFilesMethodsTwoTest];
}

- (void)initBaseViews
{
    [PTStashFiles stashFilesMethodsTwoTest];
    NSString *text =  @"感谢您使用PaintLife\n\n"
    
    "我们依据最新法律规定更新了《用户协议》，请查阅。\n\n"
    
    "同时，为向您提供您所期待的服务，您同意我们根据《隐私政策》对您的个人信息进行采集、使用和共享。保护您的隐私对我们至关重要，我们将军收适用法律规定的要求对您的信息予以充分保护，并使您能够更好的行使个人权利。根据您的选择，本软件在使用过程中可能需要申请联网，定位等权限。\n\n"
    "请您务必审慎、仔细阅读《用户协议》和《隐私政策》相关条款，特别是免除或者限制责任的条款、法律适用和争议解决条款，您可以点击上述链接完整阅读隐私政策文本。\n\n";
    [PTStashFiles stashFilesMethodsTwoTest];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:0x999999], NSFontAttributeName: self.textLabel.font}];
    NSDictionary *protocAttributes = @{NSForegroundColorAttributeName: [UIColor redColor],
                                       NSFontAttributeName: self.textLabel.font};
    NSMutableAttributedString *lastAttributedString = [[NSMutableAttributedString alloc] initWithString:@"【特别提示】当您点击“同意”即表示您已充分阅读、理解并接受《用户协议》及《隐私政策》。\n\n\n\n" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:0x999999], NSFontAttributeName: self.textLabel.font}];
    NSRange range1 = [lastAttributedString.string rangeOfString:@"《用户协议》"];
    NSRange range2 = [lastAttributedString.string rangeOfString:@"《隐私政策》"];
    [lastAttributedString setAttributes:protocAttributes range:range1];
    [lastAttributedString setAttributes:protocAttributes range:range2];
    
    [lastAttributedString addAttribute:NSLinkAttributeName
                                 value:@"protocol1://"
                                 range:[[lastAttributedString string] rangeOfString:@"《用户协议》"]];
    [lastAttributedString addAttribute:NSLinkAttributeName
                                 value:@"protocol2://"
                                 range:[[lastAttributedString string] rangeOfString:@"《隐私政策》"]];
    
    [attributedString appendAttributedString:lastAttributedString];
    self.textLabel.attributedText = attributedString;
    self.textLabel.delegate = self;
    [PTStashFiles stashFilesMethodsTwoTest];
}

- (IBAction)notAgreeButtonClicked:(id)sender
{   
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您需同意相关协议方可使用本软件" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)agreeButtonClicked:(id)sender
{
    [FLPaintUserInfoDefault savePaintAgreeSecretList];
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {

    NSString *urlString = nil;
    NSString *title = nil;
    if ([[URL scheme] isEqualToString:@"protocol1"]) {
        title = @"用户协议";
        urlString = @"http://139.196.45.126/UserAgreement.html";
    } else if ([[URL scheme] isEqualToString:@"protocol2"]) {
        title = @"隐私条款";
        urlString = @"http://139.196.45.126/PrivacyClause.html";
    }
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (urlString != nil) {
        PLWebViewController *web = [[PLWebViewController alloc] initWithUrl:urlString];
        web.isShowNavigation = YES;
        web.isDisMiss = YES;
        web.navigationTitle = title;
        [self presentViewController:web animated:YES completion:nil];
        return YES;
    }
    return YES;
}

@end
