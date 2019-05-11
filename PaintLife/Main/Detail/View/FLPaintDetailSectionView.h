//
//  FLPaintDetailSectionView.h
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/15.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLPaintDetailSectionView : UIView

@property (strong, nonatomic) UIColor *color;

+ (instancetype)loadFromNib;

+ (CGFloat)viewHeight;

@end
