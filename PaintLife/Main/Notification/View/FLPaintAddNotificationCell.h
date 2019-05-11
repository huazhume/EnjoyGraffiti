//
//  FLPaintAddNotificationCell.h
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/27.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FLPaintAddNotificationCellDelegate <NSObject>
@optional

- (void)noteCell:(UITableViewCell *)cell didChangeText:(NSString *)text;

- (void)noteCell:(UITableViewCell *)cell textViewWillBeginEditing:(UITextView *)textView;

- (void)noteCell:(UITableViewCell *)cell textViewDidEndEditing:(UITextView *)textView;

@end

@interface FLPaintAddNotificationCell : UITableViewCell

@property (copy, nonatomic) NSString *title;

@property (weak, nonatomic) id <FLPaintAddNotificationCellDelegate> delegate;

+ (CGFloat)heightForCell;

- (void)becomeFirstResponder;

@end
