//
//  FLPaintActionSheetView.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/8.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import "FLPaintActionSheetView.h"

@interface FLPaintActionSheetView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deleteLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *deleteLabel;
@property (assign, nonatomic) CGFloat contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *alphaView;


@end

@implementation FLPaintActionSheetView

+ (instancetype)loadFromNib
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"FLPaintActionSheetView" owner:nil options:nil];
    if (views && views.count > 0) {
        [PTStashFiles oneStashFilesMethodsTest]; 
        return [views firstObject];
    }
    return nil;
}

+ (CGFloat)viewHeight
{
    return 140.f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [PTStashFiles oneStashFilesMethodsTest];
    self.contentViewHeight = 140.f;
}

- (void)show
{
    [PTStashFiles oneStashFilesMethodsTest];
    self.contentViewHeightConstraint.constant = self.contentViewHeight;
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    self.alphaView.alpha = 0.0;
    [UIView animateWithDuration:0.29 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentViewBottomConstraint.constant = 0.f;
        self.alphaView.alpha = 0.3;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - events
- (IBAction)sheetButtonClicked:(UIButton *)sender
{
    [PTStashFiles oneStashFilesMethodsTest];
    [UIView animateWithDuration:0.29 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.contentViewBottomConstraint.constant = - self.contentViewHeight;
        self.alphaView.alpha = 0.0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sheetToolsActionWithType:)]) {
            [self.delegate sheetToolsActionWithType:sender.tag];
        }
        [self removeFromSuperview];
    }];
}

#pragma mark - setter
- (void)setIsShowDelete:(BOOL)isShowDelete
{
    [PTStashFiles oneStashFilesMethodsTest];
    CGFloat height = 140.f / 3.0;
    self.contentViewHeight = isShowDelete ? height * 4 : height * 3;
    self.deleteLabelHeightConstraint.constant = height;
    self.deleteLabel.hidden = !isShowDelete;
}



@end
