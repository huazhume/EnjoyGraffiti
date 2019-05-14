//
//  FLPaintLanguageController.m
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/30.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintLanguageController.h"
#import "FLPaintNavigationView.h"
#import "FLPaintLanguageViewCell.h"
#import "FLPaintUserInfoDefault.h"


@interface FLPaintLanguageController ()
<UITableViewDelegate,UITableViewDataSource,
FLPaintNavigationViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FLPaintNavigationView *navigationView;

@property (assign, nonatomic) BOOL lanagureStatus;

@end

@implementation FLPaintLanguageController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBaseViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)initBaseViews
{
    [PTStashFiles stashFilesMethodsTwoTest];
    
    [PTStashFiles twoStashFilesMethodsTest];

    [self.view addSubview:self.navigationView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FLPaintLanguageViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[FLPaintLanguageViewCell getIdentifier]];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    self.lanagureStatus = [FLPaintUserInfoDefault getUserDefaultLanguageIsChinese];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLPaintLanguageViewCell *languageCell = [tableView dequeueReusableCellWithIdentifier:[FLPaintLanguageViewCell getIdentifier]];
    NSString *title = indexPath.row ? @"English" : @"中文(简体)";
    languageCell.title = title;
    languageCell.languageStatus = (self.lanagureStatus != indexPath.row);
    return languageCell;
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
    return [FLPaintLanguageViewCell heightForCell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.lanagureStatus = (indexPath.row == 0);
    [FLPaintUserInfoDefault saveDefaultLanguage:self.lanagureStatus];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLanguageNotification object:nil];
    self.navigationView.navigationTitle = Localized(@"language");
}

#pragma mark - FLPaintNavigationViewDelegate
- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - setter & getter
- (FLPaintNavigationView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [FLPaintNavigationView loadFromNib];
        _navigationView.frame = CGRectMake(0, iPhoneTopMargin, SCREEN_WIDTH, 55);
        _navigationView.delegate = self;
        _navigationView.navigationTitle = Localized(@"language");
        _navigationView.rightImageName = @"";
        _navigationView.rightTitle = @"";
    }
    return _navigationView;
}



@end
