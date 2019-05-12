//
//  FLPaintSettingProfileCell.m
//  PaintLife
//
//  Created by hua on 2020/8/23.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintSettingProfileCell.h"
#import "FLMediaFileManager.h"

@interface FLPaintSettingProfileCell ()

@property (weak, nonatomic) IBOutlet UILabel *editProfileLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@end


@implementation FLPaintSettingProfileCell

+ (CGFloat)heightForCell
{
    return 80.f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [PTStashFiles stashFilesMethodsTwoTest];
    [PTStashFiles twoStashFilesMethodsTest];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.coverImageView.layer.cornerRadius = self.coverImageView.bounds.size.height / 2.0;
    self.coverImageView.layer.masksToBounds = YES;
    self.editProfileLabel.text = Localized(@"profileEditPicture");
    
}

- (void)refreshCell
{
    [PTStashFiles stashFilesMethodsTwoTest];
    [PTStashFiles twoStashFilesMethodsTest];

     self.coverImageView.image = [UIImage imageWithContentsOfFile:[[FLMediaFileManager sharedManager] getUserImageFilePath]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
