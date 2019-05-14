//
//  FLPaintNoteToolsImageCell.m
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/8.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintNoteToolsImageCell.h"
#import "FLPaintNoteModel.h"
#import "FLMediaFileManager.h"

@interface FLPaintNoteToolsImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation FLPaintNoteToolsImageCell


+ (CGFloat)heightForCellWithModel:(MTNoteImageVo *)model
{
    return model.height / model.width * (CGRectGetWidth([UIScreen mainScreen].bounds) - 16);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
    [PTStashFiles oneStashFilesMethodsTest];
}

- (void)setModel:(MTNoteImageVo *)model
{
    [PTStashFiles oneStashFilesMethodsTest];
    NSString *path = [[FLMediaFileManager sharedManager] getMediaFilePathWithAndSanBoxType:SANBOX_DOCUMNET_TYPE AndMediaType:FILE_IMAGE_TYPE];
    self.contentImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,model.path]]];
}

- (void)setType:(FLPaintNoteToolsImageCellType)type
{
    [PTStashFiles oneStashFilesMethodsTest]; 
    self.editButton.hidden = (type == FLPaintNoteToolsImageCellDetail);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
