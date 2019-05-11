//
//  ViewController.m
//  PaintLife
//
//  Created by xiaobai zhang on 2018/8/7.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "ViewController.h"
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

@interface ViewController ()
<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,
FLPaintHomeSectionViewDelegate,
FLPaintHomeEmptyViewDelegate,
FLPaintingDealViewDelegate>

@property (weak, nonatomic) IBOutlet PLEditStyleTableView *tableView;
@property (strong, nonatomic) FLPaintHomeSectionView *sectionView;
@property (assign, nonatomic) CGPoint scrollViewOldOffset;
@property (strong, nonatomic) NSMutableArray *datalist;
@property (weak, nonatomic) IBOutlet FLPaintNoteSettingView *setView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *setViewLeadingCostraint;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewTopConstraint;

@property (assign, nonatomic) BOOL isAnimationing;
@property (strong, nonatomic) NSDate *lastScrollDate;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *setViewLeadingConstraint;

@property (strong, nonatomic) FLPaintHomeWebModel *webModel;
@property (weak, nonatomic) IBOutlet FLPaintActivityView *activityView;
@property (strong, nonatomic) FLPaintingDealView *paintView;
@property (weak, nonatomic) IBOutlet UIView *paintBgView;

@property (strong, nonatomic) NSMutableArray *myPatingArray;


@property (nonatomic, strong) NSTimer *marketTimer;
@property (nonatomic, assign) NSInteger totalTimes;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![FLPaintUserInfoDefault isPaintAgreeSecretList]) {
       [self presentViewController:[FLPaintLaunchController new] animated:NO completion:nil];
    }
    [self initBaseViews];
    [self registNotifications];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.datalist = [[[FLPaintDBManager shareInstance] getPaintNoteSelf] mutableCopy];
    
    
    NSString * path =[[FLMediaFileManager sharedManager] getMediaFilePathWithAndSanBoxType:SANBOX_DOCUMNET_TYPE AndMediaType:FILE_IMAGE_TYPE];
    NSString *fileName = @"homeStyle";
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",path,fileName];
    self.bgImageView.image = [UIImage imageWithContentsOfFile:filePath];
    
    FLPaintMeModel *meModel = [FLPaintUserInfoDefault getPaintUserDefaultMeModel];
    self.sectionView.name = meModel.name;
    [self.setView refreshData];
    
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
    
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(settingViewIsShow:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.setView addGestureRecognizer:recognizer];
    
    self.tableView.hidden = YES;
    self.activityView.hidden = NO;
    
//    self.setViewLeadingCostraint.constant = -SCREEN_WIDTH;
    [self.paintBgView addSubview:self.paintView];
    [self addTimer];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)registNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:)name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChangeAction) name:kLanguageNotification object:nil];
    
}

- (void)languageChangeAction
{
    [self.sectionView reloadData];
}

- (void)orientChange:(NSNotification *)noti
{
//    self.setViewLeadingCostraint.constant = -SCREEN_WIDTH;

    UIDeviceOrientation  orient = [UIDevice currentDevice].orientation;
    switch (orient)
    {
        case UIDeviceOrientationPortrait:
            [self.setView changeDeviceOrienationIsV:YES];
            
            break;
        case UIDeviceOrientationLandscapeLeft:
            [self.setView changeDeviceOrienationIsV:NO];
            
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            [self.setView changeDeviceOrienationIsV:YES];
            
            break;
        case UIDeviceOrientationLandscapeRight:
            [self.setView changeDeviceOrienationIsV:NO];
            
            break;
            
        default:
            break;
    }
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
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - FLPaintHomeSectionViewDelegate
- (void)homeNoteAction
{
    FLPaintNoteViewController *noteVC = [[FLPaintNoteViewController alloc] init];
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
        self.setViewLeadingCostraint.constant = isShow ? 0.f : -SCREEN_WIDTH;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)homeButtonClickedWithIndex:(NSInteger)index
{
    self.activityView.hidden = (index != 1);
    self.tableView.hidden =  (index != 2);
    self.paintView.hidden = (index != 0);
    self.paintBgView.hidden = (index != 0);
}

#pragma mark - FLPaintHomeEmptyViewDelegate
- (void)emptyNoteAction
{
    FLPaintNoteViewController *noteVC = [[FLPaintNoteViewController alloc] init];
    [self.navigationController pushViewController:noteVC animated:YES];
}

#pragma mark - getter
- (UIView *)sectionView
{
    if (!_sectionView) {
        _sectionView = [FLPaintHomeSectionView loadFromNib];
        _sectionView.frame = CGRectMake(0, 20, self.tableView.frame.size.width, 40);
        _sectionView.backgroundColor = [UIColor clearColor];
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

- (FLPaintingDealView *)paintView
{
    if (!_paintView) {
        _paintView = [FLPaintingDealView loadFromNib];
        _paintView.hidden = YES;
        _paintView.frame = self.tableView.bounds;
        _paintView.delegate = self;
    }
    return _paintView;
}

- (void)sharedImage:(UIImage *)image
{
    
    NSMutableArray *shareTypes = [@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Qzone)] mutableCopy];
    
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
        [shareTypes removeObject:@(UMSocialPlatformType_QQ)];
        [shareTypes removeObject:@(UMSocialPlatformType_Qzone)];
    }
    
    
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        [shareTypes removeObject:@(UMSocialPlatformType_WechatSession)];
        [shareTypes removeObject:@(UMSocialPlatformType_WechatTimeLine)];
    }
    [UMSocialUIManager setPreDefinePlatforms:shareTypes];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        shareObject.thumbImage = image;
        [shareObject setShareImage:image];
        messageObject.shareObject = shareObject;
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
            }
        }];
    }];
}


- (NSTimer *)marketTimer
{
    if (!_marketTimer) {
        _marketTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }
    return _marketTimer;
}



#pragma mark - Timer
//添加定时器
-(void)addTimer{
    [[NSRunLoop currentRunLoop] addTimer:self.marketTimer forMode:NSRunLoopCommonModes];
}

- (void)timerAction:(id)sender
{
    self.totalTimes ++;
    [self.activityView.hotView switchCurrentBanner];
}

//删除定时器
-(void)cleanTimer{
    
    if (_marketTimer) {
        [_marketTimer invalidate];
        _marketTimer = nil;
    }
}

-(void)pauseTimer{
    
    if (_marketTimer) {
        _marketTimer.fireDate = [NSDate distantFuture];
    }
}
//继续定时器
- (void)continueTimer {
    if (_marketTimer) {
        _marketTimer.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.5];
    }
}


@end
