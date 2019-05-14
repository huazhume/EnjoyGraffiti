//
//  FLPaintHomeTextViewCell.h
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/7.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLPaintNoteModel;

@interface FLPaintHomeTextViewCell : UITableViewCell

@property (strong, nonatomic) FLPaintNoteModel *model;

+ (CGFloat)heightForCellWithModel:(FLPaintNoteModel *)model;

@end
