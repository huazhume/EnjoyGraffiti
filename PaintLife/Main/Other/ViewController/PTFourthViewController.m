//
//  PTFourthViewController.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/5/11.
//  Copyright © 2020 xiaobai zhang. All rights reserved.
//

#import "PTFourthViewController.h"
#import "FLPaintHomeSectionView.h"
#import "FLPaintHomeTextViewCell.h"
#import "UITableViewCell+Identifier.h"
#import "FLPaintNoteViewController.h"
#import "FLPaintDBManager.h"
#import "FLPaintHomeEmptyView.h"
#import "FLPaintNoteModel.h"
#import <MJRefresh/MJRefresh.h>
#import "PLEditStyleTableView.h"
#import "FLPaintNoteDetailController.h"
#import "FLPaintActionAlertView.h"
#import "FLPaintDBManager.h"
#import "FLMediaFileManager.h"
#import "FLPaintNoteSettingView.h"
#import "FLPaintMeModel.h"
#import "FLPaintUserInfoDefault.h"
#import "AppDelegate.h"
#import "FLPaintHomeWebModel.h"
#import "PLWebViewController.h"
#import "FLPaintLaunchController.h"
#import "FLPaintActivityView.h"
#import "FLPaintingSectionView.h"
#import "FLPaintingDealView.h"
#import "FLMyPaintViewCell.h"
#import <UMShare/UMSocialDataManager.h>
#import <UShareUI/UShareUI.h>

@interface PTFourthViewController ()
<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,
FLPaintHomeSectionViewDelegate,
FLPaintHomeEmptyViewDelegate,
FLPaintingDealViewDelegate>


@property (weak, nonatomic) IBOutlet PLEditStyleTableView *tableView;
@property (strong, nonatomic) NSMutableArray *datalist;

@property (strong, nonatomic) NSMutableArray *myPatingArray;


@end

@implementation PTFourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initDatas];
}

- (void)initDatas {
    self.datalist = [[[FLPaintDBManager shareInstance] getPaintNoteSelf] mutableCopy];
    self.myPatingArray = [[FLPaintUserInfoDefault getPaintingArrays] mutableCopy];
    [self.tableView reloadData];
}
#pragma mark - Views
- (void)initBaseViews
{
    [self.tableView registerNib:[UINib nibWithNibName:@"FLPaintHomeTextViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[FLPaintHomeTextViewCell getIdentifier]];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FLMyPaintViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[FLMyPaintViewCell getIdentifier]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationController.navigationBar.hidden = YES;
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


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return section == 0 ? (self.myPatingArray.count ? 1 : 0) : self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section) {
        FLPaintHomeTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[FLPaintHomeTextViewCell getIdentifier]];
        FLPaintNoteModel *model = self.datalist[indexPath.row];
        model.indexRow = indexPath.row;
        cell.model = model;
        return cell;
    } else {
        FLMyPaintViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[FLMyPaintViewCell getIdentifier]];
        [cell setPageArray:self.myPatingArray];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FLPaintingSectionView *view = [FLPaintingSectionView loadFromNib];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 35);
    view.titleLabel.text = section ? @"涂鸦作品" : @"涂鸦照片";
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    FLPaintHomeEmptyView *footView = [FLPaintHomeEmptyView loadFromNib];
    footView.delegate = self;
    
    if (section == 0) {
        footView.titleLabel.text = @"你还没有任何涂鸦照片哦，赶快在素材里涂鸦吧";
        return self.myPatingArray.count > 0 ? [UIView new] : footView;
    }
    
    footView.titleLabel.text = @"你还制作任何涂鸦卡片哦";
    return self.datalist.count > 0 ? [UIView new] : footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return self.myPatingArray.count > 0 ? 0 : ([FLPaintHomeEmptyView viewHeight] + 20);
    }
    
    return self.datalist.count > 0 ? 0.f : ([FLPaintHomeEmptyView viewHeight] + 20);
}

//先要设Cell可编辑
- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    NSString *readTitle = @"";
    UITableViewRowAction *readAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:readTitle handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                        {
                                            
                                            [FLPaintActionAlertView alertShowWithMessage:@"真的忍心要删除嘛？" leftTitle:@"是哒" leftColor:[UIColor colorWithHex:0xCD6256] rightTitle:@"不啦" rightColor:[UIColor colorWithHex:0x333333] callBack:^(NSInteger index) {
                                                if (index == 2){
                                                    return;
                                                }
                                                
                                                if (indexPath.section == 0) {
                                                    
                                                    
                                                } else {
                                                    FLPaintNoteModel *model = self.datalist[indexPath.row];
                                                    [[FLPaintDBManager shareInstance]deletePaintNoteWithNoteId:model.noteId];
                                                    [self.datalist removeObjectAtIndex:indexPath.row];
                                                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                                                    [tableView setEditing:NO animated:YES];
                                                }
                                                
                                                [self.tableView reloadData];
                                            }];
                                            
                                        }];
    readAction.backgroundColor = [UIColor whiteColor];
    return @[readAction];
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView.editingIndexPath = indexPath;
    [self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView.editingIndexPath = nil;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section) {
        return [FLPaintHomeTextViewCell heightForCellWithModel:self.datalist[indexPath.row]];
    } else {
        return 160;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLPaintNoteDetailController *detailVC = [[FLPaintNoteDetailController alloc] init];
    FLPaintNoteModel *model = self.datalist[indexPath.row];
    detailVC.noteId = model.noteId;
    detailVC.color = model.sectionColor;
    detailVC.weather = model.weather;
    detailVC.isStatusBarHidden = [UIApplication sharedApplication].isStatusBarHidden;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (NSMutableArray *)datalist
{
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}


@end

