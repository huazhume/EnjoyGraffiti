//
//  FLPaintNoteToolsTextCell.m
//  PaintLife
//
//  Created by hua on 2020/8/8.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintNoteToolsTextCell.h"
#import "FLPaintNoteModel.h"

@interface FLPaintNoteToolsTextCell ()
<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) UILabel *descLabel;

@end

@implementation FLPaintNoteToolsTextCell

+ (CGFloat)heightForCell
{
    return 150.f;
}

+ (CGFloat)heightForCellWithModel:(MTNoteTextVo *)model
{
    [PTStashFiles oneStashFilesMethodsTest];
    CGFloat textHeight = 0.f;
    if (model.text.length > 0) {
        CGSize textLabelSize = [model.text boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        textHeight = textLabelSize.height + 16.f;
    }
    return textHeight;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initBaseViews];
}

- (void)initBaseViews
{
    [PTStashFiles twoStashFilesMethodsTest];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textView.delegate = self;
    
    [self.textView setPlaceholder:Localized(@"noteContentPlaceholder") placeholdColor:[UIColor colorWithHex:0x666666] font:[UIFont fontWithName:@"AvenirNext-UltraLightItalic" size:14]];
    
    [self.contentView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(8);
        make.trailing.equalTo(self).offset(-8);
        make.top.equalTo(self).offset(3);
        make.bottom.equalTo(self).offset(-3);
    }];
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
    [PTStashFiles twoStashFilesMethodsTest];
    if ([self.delegate respondsToSelector:@selector(noteCell:didChangeText:)]) {
        [self.delegate noteCell:self didChangeText:self.textView.text];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [PTStashFiles twoStashFilesMethodsTest]; 
    if ([self.delegate respondsToSelector:@selector(noteCell:textViewDidEndEditing:)]) {
        [self.delegate noteCell:self textViewDidEndEditing:textView];
    }
}


#pragma mark - setter
- (void)setFont:(UIFont *)font
{
    _font = font;
    self.textView.font = font;
    self.descLabel.font = font;
}

- (void)becomeKeyboardFirstResponder
{
    [self.textView becomeFirstResponder];
}

- (void)setModel:(MTNoteTextVo *)model
{
    if (self.type == FLPaintNoteToolsTextCellDetail) {
        self.descLabel.text = model.text;
    } else {
        self.textView.text = model.text;
    }
}

- (void)setType:(FLPaintNoteToolsTextCellType)type
{
    _type = type;
    self.descLabel.hidden = type != FLPaintNoteToolsTextCellDetail;
    self.textView.hidden = type == FLPaintNoteToolsTextCellDetail;
}

- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = self.textView.font;
        _descLabel.textColor = self.textView.textColor;
        _descLabel.hidden = YES;
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
