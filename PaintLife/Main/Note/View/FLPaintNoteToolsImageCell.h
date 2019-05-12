//
//  FLPaintNoteToolsImageCell.h
//  PaintLife
//
//  Created by hua on 2020/8/8.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTNoteImageVo;


typedef enum : NSUInteger {
    FLPaintNoteToolsImageCellNormal,
    FLPaintNoteToolsImageCellDetail,
} FLPaintNoteToolsImageCellType;

@interface FLPaintNoteToolsImageCell : UITableViewCell

@property (strong, nonatomic) MTNoteImageVo *model;

@property (assign, nonatomic) FLPaintNoteToolsImageCellType type;

+ (CGFloat)heightForCellWithModel:(MTNoteImageVo *)model;


@end
