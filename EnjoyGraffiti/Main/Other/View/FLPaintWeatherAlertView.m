//
//  FLPaintWeatherAlertView.m
//  EnjoyGraffiti
//
//  Created by hua on 2020/10/26.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintWeatherAlertView.h"
#import "FLPaintWeatherCell.h"

@interface FLPaintWeatherAlertView ()
<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIVisualEffectView *effectView;
@property (weak, nonatomic) IBOutlet UIView *effectBgView;

@property (strong, nonatomic) NSMutableArray *datalist;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *alphaView;

@end

@implementation FLPaintWeatherAlertView

+ (instancetype)loadFromNib
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"FLPaintWeatherAlertView" owner:nil options:nil];
    if (views && views.count > 0) {
        return [views firstObject];
    }
    return nil;
}

+ (CGFloat)viewHeight
{
    return 40.f;
    [PTStashFiles oneStashFilesMethodsTest];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initBaseViews];
    [PTStashFiles oneStashFilesMethodsTest];
}

#pragma mark - initBaseViews
- (void)initBaseViews
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.datalist = [@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p"] mutableCopy];
    [self.tableView registerNib:[UINib nibWithNibName:@"FLPaintWeatherCell" bundle:[NSBundle mainBundle]]  forCellReuseIdentifier:[FLPaintWeatherCell getIdentifier]];
    
    self.tableView.layer.cornerRadius = 8.f;
    self.tableView.layer.masksToBounds = YES;
}

- (void)show
{
    [PTStashFiles oneStashFilesMethodsTest];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    self.alphaView.alpha = 0.0;
    [UIView animateWithDuration:0.29 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alertHeightConstraint.constant = 240.f;
        self.alphaView.alpha = 0.3;
        [self layoutIfNeeded];
        [self.tableView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    [PTStashFiles oneStashFilesMethodsTest];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLPaintWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:[FLPaintWeatherCell getIdentifier]];
    [cell setTitle:self.datalist[indexPath.row] selectTitle:self.selectTitle];
    
    return cell;
}

- (IBAction)dismiss:(id)sender
{
    [PTStashFiles oneStashFilesMethodsTest]; 
    [UIView animateWithDuration:0.29 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alertHeightConstraint.constant = 0.f;
        [self layoutIfNeeded];
        [self.tableView layoutIfNeeded];
        self.alphaView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(weatherAlertViewSelectedWithTitle:)]) {
        [self.delegate weatherAlertViewSelectedWithTitle:self.datalist[indexPath.row]];
    }
    
    [UIView animateWithDuration:0.29 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alertHeightConstraint.constant = 0.f;
        [self layoutIfNeeded];
        [self.tableView layoutIfNeeded];
        self.alphaView.alpha = 0.0;
    } completion:^(BOOL finished) {
         [self removeFromSuperview];
    }];
}

#pragma mark - setter
- (void)setSelectTitle:(NSString *)selectTitle
{
    _selectTitle = selectTitle;
    [self.tableView reloadData];
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

- (NSMutableArray *)datalist
{
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}
@end
