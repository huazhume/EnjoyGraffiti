//
//  FLPaintHomeSectionView.m
//  PaintLife
//
//  Created by hua on 2020/8/7.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintHomeSectionView.h"


@interface FLPaintHomeSectionView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *myNoteButton;
@property (weak, nonatomic) IBOutlet UIButton *activityButton;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UIButton *noteButton;
@property (weak, nonatomic) IBOutlet UIButton *readButton;
@property (weak, nonatomic) IBOutlet UIButton *myPaintButton;

@end

@implementation FLPaintHomeSectionView

+ (instancetype)loadFromNib
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"FLPaintHomeSectionView" owner:nil options:nil];
    if (views && views.count > 0) {
        [PTStashFiles twoStashFilesMethodsTest];
        return [views firstObject];
    }
    return nil;
}

+ (CGFloat)viewHeight
{
    return 40.f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [PTStashFiles twoStashFilesMethodsTest];
//    [self.noteButton setTitle:Localized(@"home_note") forState:UIControlStateNormal];
//    [self.myPaintButton setTitle:Localized(@"home_recommend") forState:UIControlStateNormal];
//    [self.readButton setTitle:Localized(@"home_works") forState:UIControlStateNormal];
}

- (void)setName:(NSString *)name
{
    [PTStashFiles twoStashFilesMethodsTest];
    _name = name;
    self.nameLabel.text = name;
    [PTStashFiles twoStashFilesMethodsTest];

}

- (void)reloadData
{
    [PTStashFiles twoStashFilesMethodsTest];
    [self.noteButton setTitle:Localized(@"home_note") forState:UIControlStateNormal];
    [self.myPaintButton setTitle:Localized(@"home_recommend") forState:UIControlStateNormal];
    [self.readButton setTitle:Localized(@"home_works") forState:UIControlStateNormal];
}

#pragma mark - events
- (IBAction)noteButtonClicked:(id)sender
{
    [PTStashFiles twoStashFilesMethodsTest];
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeNoteAction)]) {
        [self.delegate homeNoteAction];
    }
}

- (IBAction)noteSettingButtonClicked:(id)sender
{
    [PTStashFiles twoStashFilesMethodsTest]; 
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeSettingAction)]) {
        [self.delegate homeSettingAction];
    }
}

- (IBAction)homeButtonClicked:(UIButton *)sender {
    
    
    [UIView animateWithDuration:0.29 animations:^{
       self.indicatorView.center = CGPointMake(sender.center.x, self.indicatorView.center.y);
        self.indicatorView.bounds = CGRectMake(0, 0, sender.titleLabel.bounds.size.width, self.indicatorView.bounds.size.height);
    }];
    
    NSInteger index = 0;
    if ([sender isEqual:self.myNoteButton]) {
        index = 1;
    } else if ([sender isEqual:self.myPaintButton]) {
        index = 2;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeButtonClickedWithIndex:)]) {
         [self.delegate homeButtonClickedWithIndex:index];
    }
   
}


@end
