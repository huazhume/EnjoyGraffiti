//
//  FLPaintSettingNameCell.h
//  PaintLife
//
//  Created by hua on 2020/8/23.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MTSettingNameCellDelegate <NSObject>
@optional

- (void)noteCell:(UITableViewCell *)cell didChangeText:(NSString *)text;

- (void)noteCell:(UITableViewCell *)cell textViewWillBeginEditing:(UITextView *)textView;

- (void)noteCell:(UITableViewCell *)cell textViewDidEndEditing:(UITextView *)textView;

@end

@interface FLPaintSettingNameCell : UITableViewCell

@property (weak, nonatomic) id <MTSettingNameCellDelegate> delegate;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *content;

+ (CGFloat)heightForCell;

- (void)becomeFirstResponder;

@end
