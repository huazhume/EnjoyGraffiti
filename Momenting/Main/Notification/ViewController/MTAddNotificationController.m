//
//  MTAddNotificationController.m
//  Momenting
//
//  Created by xiaobai zhang on 2018/8/24.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "MTAddNotificationController.h"
#import "MTAddNotificationTimeCell.h"
#import "MTNavigationView.h"
#import "MTAddNotificationCell.h"
#import "MTAddNotificationStateCell.h"
#import "MTNotificationVo.h"
#import "MTActionToastView.h"
#import "MTCoreDataDao.h"
#import "MTNotificationManager.h"


@interface MTAddNotificationController ()
<UITableViewDelegate,UITableViewDataSource,
MTNavigationViewDelegate,
MTAddNotificationCellDelegate,
MTAddNotificationTimeCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) MTNavigationView *navigationView;
@property (strong, nonatomic) MTNotificationVo *vo;

@property (copy, nonatomic) NSString *hour;
@property (copy, nonatomic) NSString *minute;
@end

@implementation MTAddNotificationController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBaseViews];
}

- (void)initBaseViews
{
    [self.view addSubview:self.navigationView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MTAddNotificationCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MTAddNotificationCell getIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:@"MTAddNotificationTimeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MTAddNotificationTimeCell getIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:@"MTAddNotificationStateCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MTAddNotificationStateCell getIdentifier]];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView reloadData];
    
    MTAddNotificationCell *nameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [nameCell becomeFirstResponder];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MTAddNotificationCell *descCell = [tableView dequeueReusableCellWithIdentifier:[MTAddNotificationCell getIdentifier]];
        descCell.delegate = self;
        return descCell;
    } else if (indexPath.row == 1){
        MTAddNotificationTimeCell *timeCell = [tableView dequeueReusableCellWithIdentifier:[MTAddNotificationTimeCell getIdentifier]];
        timeCell.delegate = self;
        return timeCell;
    } else {
        MTAddNotificationStateCell *stateCell = [tableView dequeueReusableCellWithIdentifier:[MTAddNotificationStateCell getIdentifier]];
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
        return [MTAddNotificationCell heightForCell];
    } else if (indexPath.row == 1){
        return [MTAddNotificationTimeCell heightForCell];
    } else {
        return [MTAddNotificationStateCell heightForCell];
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

#pragma mark - MTAddNotificationTimeCellDelegate
- (void)notificationTime:(NSString *)time withIsHour:(BOOL)isHour
{
    if (isHour) {
        self.hour = time;
    } else {
        self.minute = time;
    }
}


#pragma mark - MTNavigationViewDelegate
- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction
{
    if (!self.vo.content.length) {
        MTActionToastView *toastView = [MTActionToastView loadFromNib];
        toastView.bounds = CGRectMake(0, 0, 110, 32);
        toastView.content = @"输入通知内容哦";
        [toastView show];
        return;
    }
    
    self.vo.time = [NSString stringWithFormat:@"%@:%@",self.hour,self.minute];
    [[MTCoreDataDao new] insertNotificationDatas:@[self.vo]];
    MTActionToastView *toastView = [MTActionToastView loadFromNib];
    toastView.bounds = CGRectMake(0, 0, 110, 32);
    toastView.content = @"保存成功";
    [toastView show];
    
    [[MTNotificationManager shareInstance] addNotificationWithVo:self.vo];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark - setter & getter
- (MTNavigationView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [MTNavigationView loadFromNib];
        _navigationView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 55);
        _navigationView.delegate = self;
        _navigationView.navigationTitle = @"Add Notification";
        _navigationView.rightTitle = @"save";
    }
    return _navigationView;
}

- (MTNotificationVo *)vo
{
    if (!_vo) {
        _vo = [MTNotificationVo new];
    }
    return _vo;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
