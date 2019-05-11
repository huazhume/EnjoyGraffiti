//
//  FLPaintNoteDetailController.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/14.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import "FLPaintNoteDetailController.h"
#import "FLPaintNavigationView.h"
#import "FLPaintNoteToolsTextCell.h"
#import "FLPaintNoteToolsImageCell.h"
#import "FLPaintNoteModel.h"
#import "FLPaintDBManager.h"
#import "FLPaintToastView.h"
#import <UMShare/UMSocialDataManager.h>
#import <UShareUI/UShareUI.h>
#import "FLPaintDetailSectionView.h"

@interface FLPaintNoteDetailController ()
<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,
FLPaintNavigationViewDelegate>

@property (strong, nonatomic) FLPaintNavigationView *navigationView;
@property (weak, nonatomic) IBOutlet UIView *navigationBgView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *toolsBgView;
@property (strong, nonatomic) NSMutableArray *datalist;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navigationBarTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolsViewBottomConstraint;

@property (assign, nonatomic) BOOL isAnimationing;
@property (strong, nonatomic) NSDate *lastScrollDate;
@property (assign, nonatomic) CGPoint scrollViewOldOffset;

@property (assign, nonatomic) BOOL isDownloading;
@property (weak, nonatomic) IBOutlet UIButton *weatherButton;

@end

@implementation FLPaintNoteDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseViews];
    [self loadData];
    [PTStashFiles stashFilesMethodsTwoTest];
}

- (void)loadData
{
    self.datalist = [[[FLPaintDBManager shareInstance] getPaintNoteDetailList:self.noteId] mutableCopy];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   [UIApplication sharedApplication].statusBarHidden = YES;
//    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = self.isStatusBarHidden;
//    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
}

- (void)initBaseViews
{
    [PTStashFiles stashFilesMethodsTwoTest];
//    [self.navigationBgView addSubview:self.navigationView];
    [self.tableView registerNib:[UINib nibWithNibName:@"FLPaintNoteToolsTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[FLPaintNoteToolsTextCell getIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:@"FLPaintNoteToolsImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[FLPaintNoteToolsImageCell getIdentifier]];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layer.borderColor = self.color.CGColor;
    self.tableView.layer.masksToBounds = YES;
    self.weather = self.weather.length ? self.weather : @"A";
    [self.weatherButton setTitle:[NSString stringWithFormat:@" %@",self.weather] forState:UIControlStateNormal];
    self.weatherButton.titleLabel.font = [UIFont paintWeatherFontWithFontSize:22];
    NSArray *colors = @[[UIColor colorWithHex:0x96B46C],[UIColor colorWithHex:0xE48370],[UIColor colorWithHex:0xC496C5],[UIColor colorWithHex:0x79B47C],[UIColor colorWithHex:0xA299CE],[UIColor colorWithHex:0xA2AEBB] ];
    [self.weatherButton setTitleColor:colors[(int)arc4random_uniform(colors.count)] forState:UIControlStateNormal];
    [PTStashFiles stashFilesMethodsTwoTest];
    self.jubaoButton.hidden = !self.isJubaoHidden;
}

#pragma mark - ScrollView
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 获取开始拖拽时tableview偏移量
    self.scrollViewOldOffset = scrollView.contentOffset;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.datalist[indexPath.row];
    UITableViewCell *cell = nil;
    if ([model isKindOfClass:[MTNoteTextVo class]]) {
        
        MTNoteTextVo *vo = model;
        FLPaintNoteToolsTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:[FLPaintNoteToolsTextCell getIdentifier]];
        [textCell setType:FLPaintNoteToolsTextCellDetail];
        textCell.model = model;
        if (vo.fontSize == 0) {
            textCell.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        } else {
            textCell.font = [UIFont fontWithName:vo.fontName size:vo.fontSize];
        }

        cell = textCell;
        
    } else {
        FLPaintNoteToolsImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:[FLPaintNoteToolsImageCell getIdentifier]];
        imageCell.model = model;
        [imageCell setType:FLPaintNoteToolsImageCellDetail];
        cell = imageCell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.isDownloading ? [FLPaintDetailSectionView viewHeight] : 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FLPaintDetailSectionView *sectionView = [FLPaintDetailSectionView loadFromNib];
    sectionView.color = self.color;
    return self.isDownloading ? sectionView : [UIView new];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.datalist[indexPath.row];
    if ([model isKindOfClass:[MTNoteTextVo class]]) {
        return [FLPaintNoteToolsTextCell heightForCellWithModel:model];
    } else {
        return [FLPaintNoteToolsImageCell heightForCellWithModel:model];
    }
}

#pragma mark - events
- (IBAction)dismissButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)downloadButtonClicked:(id)sender
{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.85f, 0.85f);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 delay:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        } completion:^(BOOL finished) {
            [self.tableView renderViewToImageCompletion:^(UIImage *image) {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
                FLPaintToastView *toastView = [FLPaintToastView loadFromNib];
                toastView.bounds = CGRectMake(0, 0, 110, 32);
                [toastView show];
                
            }];
        }];
    }];
    
}

#pragma mark - getter
- (FLPaintNavigationView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [FLPaintNavigationView loadFromNib];
        _navigationView.frame = CGRectMake(0, iPhoneTopMargin, SCREEN_WIDTH, 55);
        _navigationView.delegate = self;
        _navigationView.backgroundColor = self.color;
        _navigationView.type = FLPaintNavigationViewNoteDetail;
    }
    return _navigationView;
}

- (NSMutableArray *)datalist
{
    if (!_datalist) {
        _datalist = [NSMutableArray array];
        MTNoteTextVo *textModel = [[MTNoteTextVo alloc] init];
        [_datalist addObject:textModel];
    }
    return _datalist;
}



- (IBAction)jubaoButtonClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定要举报此内容吗？" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)shared:(id)sender {
    
    __weak typeof(self) welkSelf = self;
    [self.tableView renderViewToImageCompletion:^(UIImage *image) {
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
    }];
}


@end
