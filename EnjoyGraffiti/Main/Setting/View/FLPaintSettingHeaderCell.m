//
//  FLPaintSettingHeaderCell.m
//  EnjoyGraffiti
//
//  Created by huanamee on 2020/8/18.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintSettingHeaderCell.h"
#import "FLPaintMeModel.h"
#import "FLPaintUserInfoDefault.h"

@interface FLPaintSettingHeaderCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;

@end

@implementation FLPaintSettingHeaderCell

+ (CGFloat)heightForCell
{
    return 120.f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [PTStashFiles stashFilesMethodsTwoTest];
    [PTStashFiles twoStashFilesMethodsTest];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.coverImageView.layer.cornerRadius = self.coverImageView.bounds.size.height / 2.0;
    self.coverImageView.layer.masksToBounds = YES;
}

- (void)refreshCell
{
    FLPaintMeModel *meModel = [FLPaintUserInfoDefault getPaintUserDefaultMeModel];
    self.coverImageView.image = [UIImage imageWithContentsOfFile:meModel.image];
    self.nameLabel.text = meModel.name ?: Localized(@"username");;
    self.aboutLabel.text = meModel.about ?: Localized(@"userDescription");
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
