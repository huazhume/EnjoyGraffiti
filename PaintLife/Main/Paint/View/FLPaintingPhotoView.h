//
//  FLPaintingPhotoView.h
//  PaintLife
//
//  Created by xiaobai zhang on 2020/5/1.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FLPaintingPhotoViewDelegate <NSObject>

- (void)sharedImage:(UIImage *)image;

@end


@interface FLPaintingPhotoView : UIView

@property (weak, nonatomic) id <FLPaintingPhotoViewDelegate>delegate;

+ (void)alertShowPaintingImage:(NSString *)image delegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END
