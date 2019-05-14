//
//  FLPaintNotificationCell.h
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/24.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLPaintNotificationVo;

@interface FLPaintNotificationCell : UITableViewCell

@property (copy, nonatomic) NSString *signName;

@property (strong, nonatomic) FLPaintNotificationVo *model;

@property (assign, nonatomic) NSInteger indexRow;

+ (CGFloat)heightForCellWithModel:(FLPaintNotificationVo *)model;

@end
