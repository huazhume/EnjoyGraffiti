//
//  FLPaintActionSheetView.h
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/8.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FLPaintActionSheetViewCancel = 0,
    FLPaintActionSheetViewOne,
    FLPaintActionSheetViewTwo,
    FLPaintActionSheetViewDelete,
} FLPaintActionSheetViewType;

@protocol FLPaintActionSheetViewDelegate <NSObject>

- (void)sheetToolsActionWithType:(FLPaintActionSheetViewType)type;

@end

@interface FLPaintActionSheetView : UIView

@property (weak, nonatomic) id <FLPaintActionSheetViewDelegate> delegate;

@property (assign, nonatomic) BOOL isShowDelete;

+ (instancetype)loadFromNib;

+ (CGFloat)viewHeight;

- (void)show;

@end
