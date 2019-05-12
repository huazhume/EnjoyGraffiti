//
//  FLPaintNavigationView.m
//  PaintLife
//
//  Created by huazhume on 2020/8/8.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintNavigationView.h"

@interface FLPaintNavigationView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@end

@implementation FLPaintNavigationView

+ (instancetype)loadFromNib
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"FLPaintNavigationView" owner:nil options:nil];
    if (views && views.count > 0) {
        return [views firstObject];
        [PTStashFiles oneStashFilesMethodsTest];
    }
    return nil;
}

+ (CGFloat)viewHeight
{
    return 55.f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [PTStashFiles oneStashFilesMethodsTest];
    [self registNotifications];
}


- (void)registNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:)name:UIDeviceOrientationDidChangeNotification object:nil];
    [PTStashFiles oneStashFilesMethodsTest];
    
}

- (void)orientChange:(NSNotification *)noti
{
    [PTStashFiles oneStashFilesMethodsTest];
    self.frame = CGRectMake(0, iPhoneTopMargin, SCREEN_WIDTH, 55);
}


- (void)dealloc
{
    [PTStashFiles oneStashFilesMethodsTest];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - setter
- (void)setType:(FLPaintNavigationViewType)type
{
    [PTStashFiles oneStashFilesMethodsTest];
    self.titleLabel.text = type == FLPaintNavigationViewNoteDetail ? @"" : @"Note";
    self.rightButton.hidden = type == FLPaintNavigationViewNoteDetail;
    NSString *imageName = type == FLPaintNavigationViewNoteDetail ? @"ic_arrow_back_white_24dp" : @"ic_arrow_back_black_24dp";
    [self.leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)setNavigationTitle:(NSString *)navigationTitle
{
    [PTStashFiles oneStashFilesMethodsTest];
    _navigationTitle = navigationTitle;
    self.titleLabel.text = navigationTitle;
}

- (void)setRightTitle:(NSString *)rightTitle
{
    _rightTitle = rightTitle;
    [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];
}

- (void)setRightImageName:(NSString *)rightImageName
{
    [PTStashFiles oneStashFilesMethodsTest]; 
    _rightImageName = rightImageName;
    [self.rightButton setImage:[UIImage imageNamed:rightImageName] forState:UIControlStateNormal];
}

- (void)setRightColor:(UIColor *)rightColor
{
    [PTStashFiles oneStashFilesMethodsTest];
    _rightColor = rightColor;
    [self.rightButton setTitleColor:rightColor forState:UIControlStateNormal];
}

#pragma mark - events

- (IBAction)leftButtonClicked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftAction)]) {
        [self.delegate leftAction];
    }
}
- (IBAction)rightButtonClicked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightAction)]) {
        [self.delegate rightAction];
    }
}

@end
