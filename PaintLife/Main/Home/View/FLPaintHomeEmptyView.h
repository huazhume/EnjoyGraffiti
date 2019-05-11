//
//  FLPaintHomeEmptyView.h
//  PaintLife
//
//  Created by xiaobai zhang on 2018/8/9.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FLPaintHomeEmptyViewDelegate <NSObject>

- (void)emptyNoteAction;


@end

@interface FLPaintHomeEmptyView : UIView

@property (weak, nonatomic) id <FLPaintHomeEmptyViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)loadFromNib;

+ (CGFloat)viewHeight;

@end
