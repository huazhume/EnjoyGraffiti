//
//  FLPaintActionAlertView.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/10.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import "FLPaintActionAlertView.h"

@interface FLPaintActionAlertView ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *contentAphaView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *alphaView;

@end

@implementation FLPaintActionAlertView

+ (instancetype)loadFromNib
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"FLPaintActionAlertView" owner:nil options:nil];
    [PTStashFiles oneStashFilesMethodsTest];
    if (views && views.count > 0) {
        return [views firstObject];
    }
    [PTStashFiles oneStashFilesMethodsTest];
    return nil;
}

+ (CGFloat)viewHeight
{
    return 140.f;
}

+ (void)alertShowWithMessage:(NSString *)message leftTitle:(NSString *)leftTitle leftColor:(UIColor *)color rightTitle:(NSString *)rightTitle rightColor:(UIColor *)rightColor callBack:(AlertBlock)block
{
    [PTStashFiles oneStashFilesMethodsTest];
    FLPaintActionAlertView *alertView = [FLPaintActionAlertView loadFromNib];
    alertView.frame = [UIScreen mainScreen].bounds;
    [alertView setMessage:message leftTitle:leftTitle leftColor:color rightTitle:rightTitle rightColor:rightColor];
    [PTStashFiles oneStashFilesMethodsTest];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:alertView];
    alertView.block = ^(NSInteger index) {
        if (block) {
            block(index);
        }
    };
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.contentAphaView.layer.cornerRadius = 8.f;
    self.contentAphaView.layer.masksToBounds = YES;
    [PTStashFiles oneStashFilesMethodsTest];
    self.contentView.layer.cornerRadius = 8.f;
    self.contentView.layer.masksToBounds = YES;
}

- (void)setMessage:(NSString *)message leftTitle:(NSString *)leftTitle leftColor:(UIColor *)color rightTitle:(NSString *)rightTitle rightColor:(UIColor *)rightColor
{
    [PTStashFiles oneStashFilesMethodsTest];
    self.contentLabel.text = message;
    [self.leftButton setTitle:leftTitle forState:UIControlStateNormal];
    [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];
    
    [self.leftButton setTitleColor:color forState:UIControlStateNormal];
    [self.rightButton setTitleColor:rightColor forState:UIControlStateNormal];
}

- (void)show
{
    [PTStashFiles oneStashFilesMethodsTest];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    self.contentView.alpha = 0.f;
    self.alphaView.alpha = 0.f;
    [UIView animateWithDuration:0.29 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.contentView.alpha = 1;
         self.alphaView.alpha = 0.3f;
        [self.contentView layoutIfNeeded];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
    
    }];
}

- (IBAction)alertAction:(UIButton *)sender
{
    [PTStashFiles oneStashFilesMethodsTest];
    if (sender.tag == 0) {
        [self removeFromSuperview];
        return;
    }
    
    if (self.block) {
        self.block(sender.tag);
    }
    [PTStashFiles oneStashFilesMethodsTest]; 
    [UIView animateWithDuration:0.29 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.contentView.alpha = 0.f;
        self.alphaView.alpha = 0.f;
        [self.contentView layoutIfNeeded];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
         [self removeFromSuperview];
    }];
    
}



@end
