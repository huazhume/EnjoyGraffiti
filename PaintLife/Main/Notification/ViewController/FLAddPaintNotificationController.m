//
//  FLAddPaintNotificationController.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/24.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import "FLAddPaintNotificationController.h"
#import "FLPaintNotificationTimeCell.h"
#import "FLPaintNavigationView.h"
#import "FLPaintAddNotificationCell.h"
#import "FLAddNotificationStateCell.h"
#import "FLPaintNotificationVo.h"
#import "FLPaintToastView.h"
#import "FLPaintDBManager.h"
#import "FLPaintNotificationManager.h"
#import "FLDateFormatManager.h"


@interface FLAddPaintNotificationController ()
<UITableViewDelegate,UITableViewDataSource,
FLPaintNavigationViewDelegate,
FLPaintAddNotificationCellDelegate,
FLPaintNotificationTimeCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FLPaintNavigationView *navigationView;
@property (strong, nonatomic) FLPaintNotificationVo *vo;

@property (copy, nonatomic) NSString *hour;
@property (copy, nonatomic) NSString *minute;
@end

@implementation FLAddPaintNotificationController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBaseViews];
}

- (void)initBaseViews
{
    
    NSString *time = [[NSDateFormatter my_getHHmmFormatter] stringFromDate:[NSDate date]];
    NSArray *times = [time componentsSeparatedByString:@":"];
    if (times.count < 2) {
        return;
    }
    [PTStashFiles threeStashFilesMethods];
    self.hour = ((NSString *)times[0]);
    self.minute = ((NSString *)times[1]);
    [PTStashFiles threeStashFilesMethods];
    [self.view addSubview:self.navigationView];
    [PTStashFiles threeStashFilesMethods];
    [self.tableView registerNib:[UINib nibWithNibName:@"FLPaintAddNotificationCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[FLPaintAddNotificationCell getIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:@"FLPaintNotificationTimeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[FLPaintNotificationTimeCell getIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:@"FLAddNotificationStateCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[FLAddNotificationStateCell getIdentifier]];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [PTStashFiles stashFilesMethodsThree]; 
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView reloadData];
    [PTStashFiles threeStashFilesMethods];
    FLPaintAddNotificationCell *nameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [nameCell becomeFirstResponder];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FLPaintAddNotificationCell *descCell = [tableView dequeueReusableCellWithIdentifier:[FLPaintAddNotificationCell getIdentifier]];
        descCell.delegate = self;
        return descCell;
    } else if (indexPath.row == 1){
        FLPaintNotificationTimeCell *timeCell = [tableView dequeueReusableCellWithIdentifier:[FLPaintNotificationTimeCell getIdentifier]];
        timeCell.delegate = self;
        return timeCell;
    } else {
        FLAddNotificationStateCell *stateCell = [tableView dequeueReusableCellWithIdentifier:[FLAddNotificationStateCell getIdentifier]];
        return stateCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [FLPaintAddNotificationCell heightForCell];
    } else if (indexPath.row == 1){
        return [FLPaintNotificationTimeCell heightForCell];
    } else {
        return [FLAddNotificationStateCell heightForCell];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - MTSettingNameCellDelegate
- (void)noteCell:(UITableViewCell *)cell didChangeText:(NSString *)text
{
    self.vo.content = text;
}

#pragma mark - FLPaintNotificationTimeCellDelegate
- (void)notificationTime:(NSString *)time withIsHour:(BOOL)isHour
{
    if (isHour) {
        self.hour = time;
    } else {
        self.minute = time;
    }
}


#pragma mark - FLPaintNavigationViewDelegate
- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction
{
    [PTStashFiles threeStashFilesMethods];
    if (!self.vo.content.length) {
        FLPaintToastView *toastView = [FLPaintToastView loadFromNib];
        toastView.bounds = CGRectMake(0, 0, 110, 32);
        toastView.content = Localized(@"addNotificationToast");
        [toastView show];
        return;
    }
    [PTStashFiles threeStashFilesMethods];
    self.vo.time = [NSString stringWithFormat:@"%@:%@",self.hour,self.minute];
    self.vo.notificationId = [NSString stringWithFormat:@"%ld",(NSInteger)[[NSDate date] timeIntervalSince1970]];
    [[FLPaintDBManager shareInstance] insertPaintNotificationDatas:@[self.vo]];
    FLPaintToastView *toastView = [FLPaintToastView loadFromNib];
    toastView.bounds = CGRectMake(0, 0, 110, 32);
    toastView.content = Localized(@"addNotificationSaveSuccess");
    [toastView show];
    [[FLPaintNotificationManager shareInstance] addPaintNotificationWithVo:self.vo];
    [self.navigationController popViewControllerAnimated:YES];
    [PTStashFiles stashFilesMethodsThree];
}

#pragma mark - setter & getter
- (FLPaintNavigationView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [FLPaintNavigationView loadFromNib];
        _navigationView.frame = CGRectMake(0, iPhoneTopMargin, SCREEN_WIDTH, 55);
        _navigationView.delegate = self;
        _navigationView.navigationTitle = Localized(@"addNotificationTitle");
        _navigationView.rightTitle = Localized(@"save");
    }
    return _navigationView;
}

- (FLPaintNotificationVo *)vo
{
    if (!_vo) {
        _vo = [FLPaintNotificationVo new];
    }
    return _vo;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
