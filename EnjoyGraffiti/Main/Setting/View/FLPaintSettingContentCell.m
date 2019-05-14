//
//  FLPaintSettingContentCell.m
//  EnjoyGraffiti
//
//  Created by huanamee on 2020/8/18.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintSettingContentCell.h"

@interface FLPaintSettingContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FLPaintSettingContentCell


+ (CGFloat)heightForCell
{
    return 50.f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [PTStashFiles stashFilesMethodsTwoTest];
    [PTStashFiles twoStashFilesMethodsTest];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
