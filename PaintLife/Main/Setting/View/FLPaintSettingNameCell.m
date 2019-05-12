//
//  FLPaintSettingNameCell.m
//  PaintLife
//
//  Created by hua on 2020/8/23.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintSettingNameCell.h"

@interface FLPaintSettingNameCell ()
<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FLPaintSettingNameCell


+ (CGFloat)heightForCell
{
    return 100.f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [PTStashFiles stashFilesMethodsTwoTest];
    [PTStashFiles twoStashFilesMethodsTest];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textView.delegate = self;
}

- (void)becomeFirstResponder
{
    [self.textView becomeFirstResponder];
}

#pragma mark - textView delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    if ([self.delegate respondsToSelector:@selector(noteCell:textViewWillBeginEditing:)]) {
        [self.delegate noteCell:self textViewWillBeginEditing:textView];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    if ([self.delegate respondsToSelector:@selector(noteCell:didChangeText:)]) {
        [self.delegate noteCell:self didChangeText:self.textView.text];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    if ([self.delegate respondsToSelector:@selector(noteCell:textViewDidEndEditing:)]) {
        [self.delegate noteCell:self textViewDidEndEditing:textView];
    }
}


#pragma mark - setting & getter
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setContent:(NSString *)content
{
    _content = content;
    self.textView.text = content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
