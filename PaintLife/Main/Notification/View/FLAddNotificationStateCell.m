//
//  FLAddNotificationStateCell.m
//  PaintLife
//
//  Created by xiaobai zhang on 2018/8/27.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "FLAddNotificationStateCell.h"

@interface FLAddNotificationStateCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation FLAddNotificationStateCell

+ (CGFloat)heightForCell
{
    return 40.f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initBaseViews];
    // Initialization code
}

#pragma mark - initBaseViews
- (void)initBaseViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.text = Localized(@"addNotificationState");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
