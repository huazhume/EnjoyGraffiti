//
//  FLPaintingItemCell.m
//  EnjoyGraffiti
//
//  Created by hua on 2020/5/1.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintingItemCell.h"
#import "UIImage+Compress.h"
#import "FLMediaFileManager.h"
#import <UIImageView+WebCache.h>

@interface FLPaintingItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FLPaintingItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    [PTStashFiles stashFilesMethodsThree];
    
    [PTStashFiles threeStashFilesMethods];

    // Initialization code
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [PTStashFiles stashFilesMethodsThree];
    
    [PTStashFiles threeStashFilesMethods];

    if (![imageUrl containsString:@"min_"]) {
        return;
    }
    NSString *path = [[FLMediaFileManager sharedManager] getMediaFilePathWithAndSanBoxType:SANBOX_DOCUMNET_TYPE AndMediaType:FILE_IMAGEBATE_TYPE];
    NSString *beta_path = [NSString stringWithFormat:@"%@/%@",path,imageUrl];
    
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:beta_path]];
    
}

- (void)setWebUrl:(NSString *)webUrl
{
    _webUrl = webUrl;
    [PTStashFiles stashFilesMethodsThree];
    
    [PTStashFiles threeStashFilesMethods];

    self.imageView.image = [UIImage imageNamed:webUrl];
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:webUrl]];
    
}


- (void)setFileName:(NSString *)fileName
{
    _fileName = fileName;
    NSString *path = [[FLMediaFileManager sharedManager] getMediaFilePathWithAndSanBoxType:SANBOX_DOCUMNET_TYPE AndMediaType:FILE_IMAGE_TYPE];
    NSString *beta_path = [NSString stringWithFormat:@"%@/%@",path,fileName];
    
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:beta_path]];
}
@end
