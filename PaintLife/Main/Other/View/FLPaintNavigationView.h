//
//  FLPaintNavigationView.h
//  PaintLife
//
//  Created by huazhume on 2020/8/8.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FLPaintNavigationViewDelegate <NSObject>

@optional

- (void)leftAction;

- (void)rightAction;

@end

typedef NS_ENUM(NSUInteger, FLPaintNavigationViewType) {
    FLPaintNavigationViewNote = 0,
    FLPaintNavigationViewNoteDetail,
};


@interface FLPaintNavigationView : UIView

@property (weak, nonatomic) id <FLPaintNavigationViewDelegate> delegate;

@property (assign, nonatomic) FLPaintNavigationViewType type;

@property (copy, nonatomic) NSString *navigationTitle;

@property (copy, nonatomic) NSString *rightTitle;

@property (strong, nonatomic) UIColor *rightColor;

@property (copy, nonatomic) NSString *rightImageName;

+ (instancetype)loadFromNib;

+ (CGFloat)viewHeight;

@end
