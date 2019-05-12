//
//  FLPaintingController.m
//  PaintLife
//
//  Created by hua on 2020/5/1.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintingController.h"
#import "UIImage+PaintingFill.h"
#import "FLPaintToastView.h"
#import "FLPaintNoteViewController.h"
#import <UMShare/UMSocialDataManager.h>
#import <UShareUI/UShareUI.h>
#import "PLColorPaintImageView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface FLPaintingController () <UIScrollViewDelegate> {
    UIView *indicatorView;
    NSInteger imageIndex;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageRatioConstraint;
@property (nonatomic, strong) UIColor *color;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;

@property (copy, nonatomic) NSString *fileName;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (strong, nonatomic) UIView *BgView;

@end

@implementation FLPaintingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseViews];
}

- (void)initBaseViews
{
    self.color = [UIColor redColor];
    [PTStashFiles threeStashFilesMethods];
    indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:indicatorView];
    [PTStashFiles threeStashFilesMethods];
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 10;
    self.scrollView.delegate = self;
    
    if (self.imageName) {
        self.imageView.image = [UIImage imageNamed:self.imageName];
    }
    if (self.imageFileName) {
        NSString *path = [[FLMediaFileManager sharedManager] getMediaFilePathWithAndSanBoxType:SANBOX_DOCUMNET_TYPE AndMediaType:FILE_IMAGE_TYPE];
        NSString *beta_path = [NSString stringWithFormat:@"%@/%@",path,self.imageFileName];
        
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:beta_path]];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.scrollView addGestureRecognizer:tap];
    //    self..userInteractionEnabled = YES;
    
    self.colorBtn.layer.cornerRadius = 15.f;
    self.colorBtn.layer.borderWidth  = 0.5;
    self.colorBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.colorBtn.layer.masksToBounds = YES;
    [PTStashFiles threeStashFilesMethods];
}

- (void)savePaintImageUserDefaultWithImage:(UIImage *)image
{
    [PTStashFiles threeStashFilesMethods];
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1.0);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    [PTStashFiles threeStashFilesMethods];
    UIImage *beta_image = [UIImage compressImage:image compressRatio:0.4];
    NSData *beta_data;
    if (UIImagePNGRepresentation(beta_image) == nil) {
        beta_data = UIImageJPEGRepresentation(beta_image, 1.0);
    } else {
        beta_data = UIImagePNGRepresentation(beta_image);
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * path =[[FLMediaFileManager sharedManager] getMediaFilePathWithAndSanBoxType:SANBOX_DOCUMNET_TYPE AndMediaType:FILE_IMAGE_TYPE];
    NSString * beta_path =[[FLMediaFileManager sharedManager] getMediaFilePathWithAndSanBoxType:SANBOX_DOCUMNET_TYPE AndMediaType:FILE_IMAGEBATE_TYPE];
    NSString *fileName = [NSString stringWithFormat:@"%ld.png",(long)[[NSDate date]timeIntervalSince1970]];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",path,fileName];
    NSString *beta_filePath = [NSString stringWithFormat:@"%@/%@",beta_path,fileName];
    [fileManager createFileAtPath:filePath contents:data attributes:nil];
    [fileManager createFileAtPath:beta_filePath contents:beta_data attributes:nil];
    [PTStashFiles threeStashFilesMethods];
    self.fileName = fileName;
}
- (IBAction)colorBtn:(UIButton *)sender {
    
    [PTStashFiles threeStashFilesMethods];
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint frame = indicatorView.center;
        frame.x = sender.center.x;
        indicatorView.center = frame;
    }];
    
    [PTStashFiles threeStashFilesMethods];
    UIButton *buttonBG = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBG.frame = [UIScreen mainScreen].bounds;
    buttonBG.backgroundColor = [UIColor clearColor];
    
    UIView *alphaView = [[UIView alloc] initWithFrame:buttonBG.frame];
    alphaView.backgroundColor = [UIColor colorWithHex:0x000000 andAlpha:0.5];
    [buttonBG addSubview:alphaView];
    alphaView.userInteractionEnabled = NO;
    
    [buttonBG addTarget:self action:@selector(removeVIew) forControlEvents:UIControlEventTouchUpInside];
    PLColorPaintImageView *ws = [[PLColorPaintImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 300, 200, 200)];
    [buttonBG addSubview:ws];
    
    __weak typeof(self) welf = self;
    ws.plcurrentColorBlock = ^(UIColor *color){
        welf.color = color;
        welf.colorView.backgroundColor = color;
    };
    [PTStashFiles threeStashFilesMethods];
    [[UIApplication sharedApplication].keyWindow addSubview:buttonBG];
    self.BgView = buttonBG;
}

- (void)removeVIew
{
    [self.BgView removeFromSuperview];
}

- (void)tap:(UITapGestureRecognizer *)sender
{
    [PTStashFiles threeStashFilesMethods];
    CGPoint point = [sender locationInView:self.imageView];
    
    if (point.y > self.imageView.frame.size.height || point.x > self.imageView.frame.size.width || point.x < 0 || point.y < 0) return;
    [PTStashFiles threeStashFilesMethods];
    point.x = roundf(_imageView.image.size.width / _imageView.bounds.size.width * point.x);
    point.y = roundf(_imageView.image.size.height / _imageView.bounds.size.height * point.y);
    [self covertImageToBitmapWithPoint:point];
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    [PTStashFiles threeStashFilesMethods];
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [PTStashFiles threeStashFilesMethods];
    CGRect frame = self.imageView.frame;
    [PTStashFiles threeStashFilesMethods];
    frame.origin.y = (self.scrollView.frame.size.height - self.imageView.frame.size.height) > 0 ? (self.scrollView.frame.size.height - self.imageView.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.scrollView.frame.size.width - self.imageView.frame.size.width) > 0 ? (self.scrollView.frame.size.width - self.imageView.frame.size.width) * 0.5 : 0;
    self.imageView.frame = frame;
    self.scrollView.contentSize = CGSizeMake(self.imageView.frame.size.width + 30, self.imageView.frame.size.height + 30);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [PTStashFiles threeStashFilesMethods];
    if (CGRectEqualToRect(indicatorView.frame, CGRectZero)) {
        indicatorView.frame = CGRectMake(0, self.view.frame.size.height -  self.view.safeAreaInsets.bottom - 5, 30, 1);
        CGPoint frame = indicatorView.center;
        frame.x = self.firstBtn.center.x;
        indicatorView.center = frame;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [PTStashFiles threeStashFilesMethods];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_imageView];
    if (![_imageView pointInside:point withEvent:event]) {
        NSLog(@"点远了");
        return;
    }
    [PTStashFiles threeStashFilesMethods];
    point.x = roundf(_imageView.image.size.width / _imageView.bounds.size.width * point.x);
    point.y = roundf(_imageView.image.size.height / _imageView.bounds.size.height * point.y);
    [self covertImageToBitmapWithPoint:point];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeColorAction:(UIButton *)sender {
    [PTStashFiles threeStashFilesMethods];
    self.color = sender.backgroundColor;
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint frame = indicatorView.center;
        frame.x = sender.center.x;
        indicatorView.center = frame;
    }];
}

- (void)covertImageToBitmapWithPoint: (CGPoint)point {
    
    [PTStashFiles threeStashFilesMethods];
    AudioServicesPlaySystemSound(1520);
    UIImage *oldImage = _imageView.image;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [oldImage floodPaintImageFromStartPoint:point newColor:_color tolerance:10 useAntialias:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            _imageView.image = image;
        });
    });
}

- (IBAction)popClicked:(id)sender {
    
    [PTStashFiles threeStashFilesMethods];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveClicked:(id)sender {

    [PTStashFiles threeStashFilesMethods];
     __weak typeof(self)welkSelf = self;
    [self.imageView renderViewToImageCompletion:^(UIImage *image) {
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        [self savePaintImageUserDefaultWithImage:image];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
        [FLPaintUserInfoDefault savePaintString:welkSelf.fileName];
        FLPaintNoteViewController *vc = [FLPaintNoteViewController new];
        vc.imageUrl = self.fileName;
        [[FLNavigationHelp currentNavigation] pushViewController:vc animated:YES];
    }];
    
}
- (IBAction)downloadClicked:(id)sender {
    
    [PTStashFiles threeStashFilesMethods];
    if (self.fileName.length) {
        [UIView showToastInKeyWindow:@"已经保存在相册里"];
        return;
    }
    [PTStashFiles threeStashFilesMethods];
    __weak typeof(self)welkSelf = self;
    [self.imageView renderViewToImageCompletion:^(UIImage *image) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        FLPaintToastView *toastView = [FLPaintToastView loadFromNib];
        toastView.bounds = CGRectMake(0, 0, 110, 32);
        [toastView show];
        
        [welkSelf savePaintImageUserDefaultWithImage:image];
        [FLPaintUserInfoDefault savePaintString:self.fileName];
    }];
}
- (IBAction)sharedClicked:(id)sender {
    
    [PTStashFiles threeStashFilesMethods];
    [PTStashFiles threeStashFilesMethods];
    NSMutableArray *shareTypes = [@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Qzone)] mutableCopy];
    
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
        [shareTypes removeObject:@(UMSocialPlatformType_QQ)];
          [shareTypes removeObject:@(UMSocialPlatformType_Qzone)];
    }
           
    [PTStashFiles threeStashFilesMethods];
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
        shareObject.thumbImage = self.imageView.image;
        [shareObject setShareImage:self.imageView.image];
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

@end

