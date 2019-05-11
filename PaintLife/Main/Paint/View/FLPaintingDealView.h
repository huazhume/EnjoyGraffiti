//
//  FLPaintingDealView.h
//  PaintLife
//
//  Created by xiaobai zhang on 2020/5/1.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FLPaintingDealViewDelegate <NSObject>

- (void)sharedImage:(UIImage *)image;

@end

@interface FLPaintingDealView : UIView

+ (instancetype)loadFromNib;

@property (weak, nonatomic) id <FLPaintingDealViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
