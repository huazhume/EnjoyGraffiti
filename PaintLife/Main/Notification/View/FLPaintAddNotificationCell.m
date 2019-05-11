//
//  FLPaintAddNotificationCell.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/27.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import "FLPaintAddNotificationCell.h"

@interface FLPaintAddNotificationCell ()
<UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FLPaintAddNotificationCell

+ (CGFloat)heightForCell
{
    return 120.f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initBaseViews];
}

- (void)initBaseViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textView.delegate = self;
    self.titleLabel.text = Localized(@"addNotificationContent");
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

@end
