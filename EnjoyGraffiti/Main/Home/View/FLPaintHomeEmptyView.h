//
//  FLPaintHomeEmptyView.h
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/9.
//  Copyright © 2020年 hua. All rights reserved.
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
