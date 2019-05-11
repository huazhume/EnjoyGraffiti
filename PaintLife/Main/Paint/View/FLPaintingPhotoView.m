//
//  FLPaintingPhotoView.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/5/1.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import "FLPaintingPhotoView.h"
#import "FLPaintToastView.h"
#import "FLPaintNoteViewController.h"
#import <UMShare/UMSocialDataManager.h>
#import <UShareUI/UShareUI.h>


@interface FLPaintingPhotoView () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (copy, nonatomic) NSString *fileName;

@end

@implementation FLPaintingPhotoView

+ (instancetype)loadFromNib
{
    [PTStashFiles stashFilesMethodsThree];
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"FLPaintingPhotoView" owner:nil options:nil];
    if (views && views.count > 0) {
        return [views firstObject];
    }
    return nil;
}

+ (void)alertShowPaintingImage:(NSString *)image delegate:(id)delegate
{
    [PTStashFiles stashFilesMethodsThree];
    FLPaintingPhotoView *alertView = [FLPaintingPhotoView loadFromNib];
    alertView.frame = [UIScreen mainScreen].bounds;
    alertView.delegate = delegate;
    [PTStashFiles stashFilesMethodsThree];
    alertView.imageView.image = [UIImage imageNamed:image];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:alertView];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [PTStashFiles stashFilesMethodsThree];
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 10;
    self.scrollView.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.scrollView addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)re
{
    [self removeFromSuperview];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    [PTStashFiles stashFilesMethodsThree];
    CGRect frame = self.imageView.frame;
    frame.origin.y = (self.scrollView.frame.size.height - self.imageView.frame.size.height) > 0 ? (self.scrollView.frame.size.height - self.imageView.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.scrollView.frame.size.width - self.imageView.frame.size.width) > 0 ? (self.scrollView.frame.size.width - self.imageView.frame.size.width) * 0.5 : 0;
    self.imageView.frame = frame;
    self.scrollView.contentSize = CGSizeMake(self.imageView.frame.size.width + 30, self.imageView.frame.size.height + 30);
}

- (IBAction)disMiss:(id)sender {
    

}

- (IBAction)note:(id)sender {
    
    if (!self.fileName.length) {
        [self saveImageUserDefaultWithImage:self.imageView.image];
    }
    [PTStashFiles stashFilesMethodsThree];
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
    FLPaintNoteViewController *vc = [FLPaintNoteViewController new];
    vc.imageUrl = self.fileName;
    vc.hidesBottomBarWhenPushed = YES;
    [[FLNavigationHelp currentNavigation] pushViewController:vc animated:YES];
    [self removeFromSuperview];
}

- (IBAction)downLoad:(id)sender {
    
    [PTStashFiles stashFilesMethodsThree];
    if (self.fileName.length) {
        [UIView showToastInKeyWindow:@"已经保存在相册里"];
        return;
    }
    [PTStashFiles stashFilesMethodsThree];
    __weak typeof(self)welkSelf = self;
    [self.imageView renderViewToImageCompletion:^(UIImage *image) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        FLPaintToastView *toastView = [FLPaintToastView loadFromNib];
        toastView.bounds = CGRectMake(0, 0, 110, 32);
        [toastView show];
        [welkSelf saveImageUserDefaultWithImage:image];
    }];
}

- (IBAction)share:(id)sender {
    
    if (self.delegate) {
        [self.delegate sharedImage:self.imageView.image];
    }
    
}

- (void)saveImageUserDefaultWithImage:(UIImage *)image
{
    [PTStashFiles stashFilesMethodsThree]; 
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1.0);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
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
    
    self.fileName = fileName;
}


@end
