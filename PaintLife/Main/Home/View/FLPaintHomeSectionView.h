//
//  FLPaintHomeSectionView.h
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/7.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FLPaintHomeSectionViewDelegate <NSObject>

- (void)homeNoteAction;

- (void)homeSettingAction;

- (void)homeButtonClickedWithIndex:(NSInteger)index;

@end

@interface FLPaintHomeSectionView : UIView

@property (weak, nonatomic) id <FLPaintHomeSectionViewDelegate> delegate;

@property (copy, nonatomic) NSString *name;

+ (instancetype)loadFromNib;

+ (CGFloat)viewHeight;

- (void)reloadData;

@end
