//
//  ViewController.m
//  Momenting
//
//  Created by xiaobai zhang on 2018/8/7.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "ViewController.h"
#import "MTHomeSectionView.h"
#import "MTHomeTextViewCell.h"
#import "UITableViewCell+Categoty.h"
#import "MTNoteViewController.h"
#import "MTCoreDataDao.h"
#import "MTHomeEmptyView.h"
#import "MTNoteModel.h"
#import <MJRefresh/MJRefresh.h>

@interface ViewController ()
<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,
MTHomeSectionViewDelegate,
MTHomeEmptyViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) MTHomeSectionView *sectionView;
@property (assign, nonatomic) CGPoint scrollViewOldOffset;
@property (strong, nonatomic) NSMutableArray *datalist;
@property (weak, nonatomic) IBOutlet UIView *setView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *setViewLeadingCostraint;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewTopConstraint;

@property (assign, nonatomic) BOOL isAnimationing;
@property (strong, nonatomic) NSDate *lastScrollDate;
@property (assign, nonatomic) BOOL isHeaderHidden;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.datalist = [[[MTCoreDataDao new] getNoteSelf] mutableCopy];
    [self.tableView reloadData];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (BOOL)prefersStatusBarHidden
{
    return self.isHeaderHidden;
}

#pragma mark - Views
- (void)initBaseViews
{
    [self.tableView registerNib:[UINib nibWithNibName:@"MTHomeTextViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MTHomeTextViewCell getIdentifier]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationController.navigationBar.hidden = YES;
    self.logoImageView.layer.cornerRadius = self.logoImageView.bounds.size.height / 2.0;
    self.logoImageView.layer.masksToBounds = YES;
    
    [self.headerView addSubview:self.sectionView];
    
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    NSMutableArray *muImage = [NSMutableArray array];
    for (int i = 1 ; i < 34 ; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%d",i]];
        [muImage addObject:image];
    }
    // 设置普通状态的动画图片
    [header setImages:muImage forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:muImage forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:muImage forState:MJRefreshStateRefreshing];
    // 设置header
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark - ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y - self.scrollViewOldOffset.y > 0) {
        //向下滑动
       [self scrollAnimationIsShow:NO];
    } else if (self.scrollViewOldOffset.y - scrollView.contentOffset.y > 0){
        [self scrollAnimationIsShow:YES];
    }
    self.scrollViewOldOffset = scrollView.contentOffset;
}

- (void)scrollAnimationIsShow:(BOOL)isShow
{
    NSDate *nowDate = [NSDate date];
    
    NSTimeInterval times = [nowDate timeIntervalSinceDate:self.lastScrollDate];
    if (self.isAnimationing || self.tableView.contentOffset.y <= 0 || times < 0.5) {
        return;
    }
    if (isShow && self.headerViewTopConstraint.constant == 0.f) {
        return;
    }
    
    if (!isShow && self.headerViewTopConstraint.constant == -60.f) {
        return;
    }
    self.lastScrollDate = [NSDate date];
    self.isHeaderHidden = !isShow;
    [self setNeedsStatusBarAppearanceUpdate];
    [UIView animateWithDuration:0.29 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.headerViewTopConstraint.constant = isShow ? 0.f : -60.f;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.isAnimationing = NO;
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTHomeTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MTHomeTextViewCell getIdentifier]];
    MTNoteModel *model = self.datalist[indexPath.row];
    model.indexRow = indexPath.row;
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MTHomeEmptyView *footView = [MTHomeEmptyView loadFromNib];
    footView.delegate = self;
    return self.datalist.count > 0 ? [UIView new] : footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.datalist.count > 0 ? 0.f : [MTHomeEmptyView viewHeight];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MTHomeTextViewCell heightForCellWithModel:self.datalist[indexPath.row]];
}

#pragma mark - MTHomeSectionViewDelegate
- (void)homeNoteAction
{
    MTNoteViewController *noteVC = [[MTNoteViewController alloc] init];
    [self.navigationController pushViewController:noteVC animated:YES];
}

- (void)homeSettingAction
{
    [self settingViewIsShow:YES];
}
- (IBAction)setViewDismissAction:(id)sender
{
    [self settingViewIsShow:NO];
}

- (void)settingViewIsShow:(BOOL)isShow
{
    [UIView animateWithDuration:0.29 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.setViewLeadingCostraint.constant = isShow ? 0.f : -CGRectGetWidth(self.view.bounds);
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - MTHomeEmptyViewDelegate
- (void)emptyNoteAction
{
    MTNoteViewController *noteVC = [[MTNoteViewController alloc] init];
    [self.navigationController pushViewController:noteVC animated:YES];
}

#pragma mark - getter
- (UIView *)sectionView
{
    if (!_sectionView) {
        _sectionView = [MTHomeSectionView loadFromNib];
        _sectionView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 40);
        _sectionView.delegate = self;
    }
    return _sectionView;
}

- (NSMutableArray *)datalist
{
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
