//
//  FLPaintNotificationCell.h
//  PaintLife
//
//  Created by xiaobai zhang on 2018/8/24.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLPaintNotificationVo;

@interface FLPaintNotificationCell : UITableViewCell

@property (copy, nonatomic) NSString *signName;

@property (strong, nonatomic) FLPaintNotificationVo *model;

@property (assign, nonatomic) NSInteger indexRow;

+ (CGFloat)heightForCellWithModel:(FLPaintNotificationVo *)model;

@end
