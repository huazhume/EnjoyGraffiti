//
//  FLPaintNoteToolsTextCell.h
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/8.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTNoteTextVo;

@protocol FLPaintNoteToolsTextCellDelegate <NSObject>
@optional

- (void)noteCell:(UITableViewCell *)cell didChangeText:(NSString *)text;

- (void)noteCell:(UITableViewCell *)cell textViewWillBeginEditing:(UITextView *)textView;

- (void)noteCell:(UITableViewCell *)cell textViewDidEndEditing:(UITextView *)textView;

@end

typedef enum : NSUInteger {
    FLPaintNoteToolsTextCellNormal,
    FLPaintNoteToolsTextCellDetail,
} FLPaintNoteToolsTextCellType;


@interface FLPaintNoteToolsTextCell : UITableViewCell

@property (strong, nonatomic) UIFont *font;

@property (weak, nonatomic) id <FLPaintNoteToolsTextCellDelegate> delegate;

@property (strong, nonatomic) MTNoteTextVo *model;

@property (assign, nonatomic) FLPaintNoteToolsTextCellType type;

+ (CGFloat)heightForCell;

+ (CGFloat)heightForCellWithModel:(MTNoteTextVo *)model;

- (void)becomeKeyboardFirstResponder;

@end
