//
//  FLPaintNoteToolsView.h
//  PaintLife
//
//  Created by huazhume on 2020/8/8.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FLPaintNoteToolsViewFont = 0,
    FLPaintNoteToolsViewItalic,
    FLPaintNoteToolsViewRank,
    FLPaintNoteToolsViewSement,
    FLPaintNoteToolsViewAt,
    FLPaintNoteToolsViewImage,
    FLPaintNoteToolsViewKeyboardDiss,
} FLPaintNoteToolsViewType;


@protocol FLPaintNoteToolsViewDelegate <NSObject>

- (void)noteToolsFootActionWithFont:(UIFont *)font;

- (void)noteToolsActionWithType:(FLPaintNoteToolsViewType)type;

@end

@interface FLPaintNoteToolsView : UIView

@property (weak, nonatomic) id <FLPaintNoteToolsViewDelegate> delegate;

@property (assign, nonatomic) BOOL keyBoardIsVisiable;

@property (copy, nonatomic) NSString *weatherTitle;

+ (instancetype)loadFromNib;

+ (CGFloat)viewHeight;


@end
