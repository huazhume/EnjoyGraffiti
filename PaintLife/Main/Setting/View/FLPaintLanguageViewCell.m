//
//  FLPaintLanguageViewCell.m
//  PaintLife
//
//  Created by xiaobai zhang on 2018/8/30.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "FLPaintLanguageViewCell.h"

@interface FLPaintLanguageViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkMarkImageView;


@end

@implementation FLPaintLanguageViewCell

+ (CGFloat)heightForCell
{
    return 50.f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [PTStashFiles stashFilesMethodsTwoTest];
    [PTStashFiles twoStashFilesMethodsTest];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - setter
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.nameLabel.text = title;
}

- (void)setLanguageStatus:(BOOL)languageStatus
{
    [PTStashFiles stashFilesMethodsTwoTest];
    [PTStashFiles twoStashFilesMethodsTest];
    _languageStatus = languageStatus;
    self.checkMarkImageView.image = !languageStatus ? nil : [UIImage imageNamed:@"settings-checkmark"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
