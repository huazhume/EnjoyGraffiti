//
//  FLPaintingSectionView.h
//  EnjoyGraffiti
//
//  Created by hua on 2020/5/1.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLPaintingSectionView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)loadFromNib;

+ (CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END
