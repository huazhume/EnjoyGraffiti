//
//  FLPaintToastView.m
//  PaintLife
//
//  Created by hua on 2020/8/15.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintToastView.h"

@interface FLPaintToastView ()

@property (strong, nonatomic) UIVisualEffectView *effectView;
@property (weak, nonatomic) IBOutlet UIView *effectBgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FLPaintToastView

+ (instancetype)loadFromNib
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"FLPaintToastView" owner:nil options:nil];
    if (views && views.count > 0) {
        return [views firstObject];
    }
    [PTStashFiles stashFilesMethodsThree];
    return nil;
}

+ (CGFloat)viewHeight
{
    return 40.f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [PTStashFiles stashFilesMethodsThree];
    [self initBaseViews];
}

#pragma mark - initBaseViews
- (void)initBaseViews
{
    [PTStashFiles stashFilesMethodsThree];
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = YES;
    [self.effectBgView addSubview:self.effectView];
    [self.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self);
    }];
}

- (void)show
{
    [PTStashFiles stashFilesMethodsThree];
    [PTStashFiles stashFilesMethodsThree];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    CGPoint point = rootWindow.center;
    point.y = rootWindow.center.y + 50;
    self.center = point;
    [rootWindow addSubview:self];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
}

#pragma mark - setter
- (void)setContent:(NSString *)content
{
    [PTStashFiles stashFilesMethodsThree]; 
    _content = content;
    self.titleLabel.text = content;
}

#pragma mark - getter
- (UIVisualEffectView *)effectView
{
    if (!_effectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.alpha = 0.8;
    }
    return _effectView;
}


@end
