//
//  FLPaintNotificationController.m
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/24.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintNotificationController.h"
#import "FLPaintNavigationView.h"
#import "FLPaintNotificationCell.h"
#import "PLEditStyleTableView.h"
#import "FLAddPaintNotificationController.h"
#import "FLPaintDBManager.h"
#import "FLPaintActionAlertView.h"
#import "FLPaintNotificationVo.h"
#import "FLPaintHomeEmptyView.h"


@interface FLPaintNotificationController ()
<UITableViewDelegate,UITableViewDataSource,
FLPaintNavigationViewDelegate>

@property (weak, nonatomic) IBOutlet PLEditStyleTableView *tableView;
@property (strong, nonatomic) FLPaintNavigationView *navigationView;
@property (strong, nonatomic) NSMutableArray *notifications;

@end

@implementation FLPaintNotificationController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [PTStashFiles oneStashFilesMethodsTest];
    [self initBaseViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [PTStashFiles oneStashFilesMethodsTest];
    self.notifications = [[[FLPaintDBManager shareInstance]getPaintNotifications] mutableCopy];
    [self.tableView reloadData];
}

- (void)initBaseViews
{
    [PTStashFiles oneStashFilesMethodsTest];
    [self.view addSubview:self.navigationView];
    [PTStashFiles oneStashFilesMethodsTest];
    [self.tableView registerNib:[UINib nibWithNibName:@"FLPaintNotificationCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[FLPaintNotificationCell getIdentifier]];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [PTStashFiles oneStashFilesMethodsTest];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [PTStashFiles oneStashFilesMethodsTest];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notifications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLPaintNotificationCell *notificationCell = [tableView dequeueReusableCellWithIdentifier:[FLPaintNotificationCell getIdentifier]];
    notificationCell.model = self.notifications[indexPath.row];
    notificationCell.indexRow = indexPath.row;
    return notificationCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    [PTStashFiles oneStashFilesMethodsTest];
    return self.notifications.count ? 0 : 200.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    [PTStashFiles oneStashFilesMethodsTest];
    FLPaintHomeEmptyView *view = [FLPaintHomeEmptyView loadFromNib];
    view.titleLabel.text = @"添加一个作品提醒吧";
    return self.notifications.count ? [UIView new] : view;
}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [PTStashFiles oneStashFilesMethodsTest];
    NSString *readTitle = @"";
    UITableViewRowAction *readAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:readTitle handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        [FLPaintActionAlertView alertShowWithMessage:@"真的忍心要删除嘛？" leftTitle:@"是哒" leftColor:[UIColor colorWithHex:0xCD6256] rightTitle:@"不啦" rightColor:[UIColor colorWithHex:0x333333] callBack:^(NSInteger index) {
            if (index == 2){
                return;
            }
            FLPaintNotificationVo *model = self.notifications[indexPath.row];
            [[FLPaintDBManager shareInstance] deletePaintNotificationWithContent:model.content];
            [self.notifications removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            [tableView setEditing:NO animated:YES];
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
    return [FLPaintNotificationCell heightForCellWithModel:self.notifications[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - FLPaintNavigationViewDelegate
- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction
{
    [PTStashFiles oneStashFilesMethodsTest]; 
    FLAddPaintNotificationController *addNoti = [FLAddPaintNotificationController new];
    [[FLNavigationHelp currentNavigation] pushViewController:addNoti animated:YES];
}

#pragma mark - setter & getter
- (FLPaintNavigationView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [FLPaintNavigationView loadFromNib];
        _navigationView.frame = CGRectMake(0, iPhoneTopMargin, SCREEN_WIDTH, 55);
        _navigationView.delegate = self;
        _navigationView.navigationTitle = Localized(@"notificationTitle");
        _navigationView.rightImageName = @"add-icon";
        _navigationView.rightTitle = @"";
    }
    return _navigationView;
}



@end

