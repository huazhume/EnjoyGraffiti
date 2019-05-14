//
//  FLPaintWeatherCell.m
//  EnjoyGraffiti
//
//  Created by hua on 2020/10/26.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintWeatherCell.h"

@interface FLPaintWeatherCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FLPaintWeatherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initBaseViews];
    // Initialization code
}

- (void)initBaseViews
{
    self.titleLabel.font = [UIFont paintWeatherFontWithFontSize:24];
    self.titleLabel.textColor = [UIColor colorWithHex:0x333333];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setTitle:(NSString *)title selectTitle:(NSString *)selectTitle
{
    self.titleLabel.textColor = [title isEqualToString:selectTitle] ? [UIColor colorWithHex:0x039369] : [UIColor colorWithHex:0x333333];
    self.titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
