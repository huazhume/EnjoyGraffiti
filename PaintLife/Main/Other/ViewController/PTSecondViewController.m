//
//  PTSecondViewController.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/5/11.
//  Copyright © 2020 xiaobai zhang. All rights reserved.
//

#import "PTSecondViewController.h"
#import "FLPaintingDealView.h"
#import <UMShare/UMSocialDataManager.h>
#import <UShareUI/UShareUI.h>

@interface PTSecondViewController () <FLPaintingDealViewDelegate>

@property (strong, nonatomic) FLPaintingDealView *paintView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation PTSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bgView addSubview:self.paintView];
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
}

- (FLPaintingDealView *)paintView
{
    if (!_paintView) {
        _paintView = [FLPaintingDealView loadFromNib];
        _paintView.frame = self.bgView.bounds;
        _paintView.delegate = self;
    }
    return _paintView;
}

- (void)sharedImage:(UIImage *)image
{
    
    NSMutableArray *shareTypes = [@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Qzone)] mutableCopy];
    
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
        [shareTypes removeObject:@(UMSocialPlatformType_QQ)];
        [shareTypes removeObject:@(UMSocialPlatformType_Qzone)];
    }
    
    
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        [shareTypes removeObject:@(UMSocialPlatformType_WechatSession)];
        [shareTypes removeObject:@(UMSocialPlatformType_WechatTimeLine)];
    }
    [UMSocialUIManager setPreDefinePlatforms:shareTypes];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        shareObject.thumbImage = image;
        [shareObject setShareImage:image];
        messageObject.shareObject = shareObject;
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
            }
        }];
    }];
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
