//
//  FLPaintNotificationTimeCell.h
//  PaintLife
//
//  Created by hua on 2020/8/27.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FLPaintNotificationTimeCellDelegate <NSObject>

- (void)notificationTime:(NSString *)time withIsHour:(BOOL)isHour;

@end

@interface FLPaintNotificationTimeCell : UITableViewCell

@property (weak, nonatomic) id <FLPaintNotificationTimeCellDelegate> delegate;

+ (CGFloat)heightForCell;

@end
