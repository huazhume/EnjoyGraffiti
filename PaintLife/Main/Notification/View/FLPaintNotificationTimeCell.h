//
//  FLPaintNotificationTimeCell.h
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/27.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FLPaintNotificationTimeCellDelegate <NSObject>

- (void)notificationTime:(NSString *)time withIsHour:(BOOL)isHour;

@end

@interface FLPaintNotificationTimeCell : UITableViewCell

@property (weak, nonatomic) id <FLPaintNotificationTimeCellDelegate> delegate;

+ (CGFloat)heightForCell;

@end
