//
//  FLPaintProfileSetController.m
//  PaintLife
//
//  Created by hua on 2020/8/23.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintProfileSetController.h"
#import "FLPaintNavigationView.h"
#import "FLPaintSettingProfileCell.h"
#import "FLPaintSettingNameCell.h"
#import "FLPaintActionSheetView.h"
#import "FLPaintMeModel.h"
#import "FLMediaFileManager.h"
#import "FLPaintUserInfoDefault.h"


@interface FLPaintProfileSetController ()
<UITableViewDelegate,UITableViewDataSource,
FLPaintNavigationViewDelegate,
MTSettingNameCellDelegate,
UINavigationControllerDelegate,UIImagePickerControllerDelegate,
FLPaintActionSheetViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FLPaintNavigationView *navigationView;
@property (strong, nonatomic) FLPaintMeModel *meModel;

@end

@implementation FLPaintProfileSetController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [PTStashFiles stashFilesMethodsThreeTest];
    
    [PTStashFiles threeStashFilesMethodsTest];

    [self initBaseViews];
}

- (void)initBaseViews
{
    [PTStashFiles stashFilesMethodsThreeTest];
    
    [PTStashFiles threeStashFilesMethodsTest];

    [PTStashFiles stashFilesMethodsThreeTest];
    
    [PTStashFiles threeStashFilesMethodsTest];

    self.meModel = [FLPaintUserInfoDefault getPaintUserDefaultMeModel];
    
    [self.view addSubview:self.navigationView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FLPaintSettingProfileCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[FLPaintSettingProfileCell getIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:@"FLPaintSettingNameCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[FLPaintSettingNameCell getIdentifier]];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [PTStashFiles stashFilesMethodsThreeTest];
    
    [PTStashFiles threeStashFilesMethodsTest];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView reloadData];
    
    FLPaintSettingNameCell *nameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
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
        FLPaintSettingProfileCell *profileCell = [tableView dequeueReusableCellWithIdentifier:[FLPaintSettingProfileCell getIdentifier]];
        [profileCell refreshCell];
        return profileCell;
    } else if (indexPath.row == 1) {
        FLPaintSettingNameCell *nameCell = [tableView dequeueReusableCellWithIdentifier:[FLPaintSettingNameCell getIdentifier]];
        
        nameCell.title = Localized(@"profileEditName");
        nameCell.content = self.meModel.name;
        nameCell.delegate = self;
        return nameCell;
    } else {
        FLPaintSettingNameCell *descCell = [tableView dequeueReusableCellWithIdentifier:[FLPaintSettingNameCell getIdentifier]];
        descCell.title = Localized(@"profileEditAbout");
        descCell.content = self.meModel.about;
        descCell.delegate = self;
        return descCell;
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

#pragma mark - MTSettingNameCellDelegate
- (void)noteCell:(UITableViewCell *)cell didChangeText:(NSString *)text
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 1) { //name
        self.meModel.name = text;
    } else { //about
        self.meModel.about = text;
    }
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [FLPaintSettingProfileCell heightForCell];
    } else if (indexPath.row == 1) {
        return [FLPaintSettingNameCell heightForCell];
    } else {
        return [FLPaintSettingNameCell heightForCell] + 40.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self.view endEditing:YES];
        FLPaintActionSheetView *sheetView = [FLPaintActionSheetView loadFromNib];
        sheetView.frame = [UIScreen mainScreen].bounds;
        sheetView.delegate = self;
        [sheetView show];
    }
}

#pragma mark - FLPaintActionSheetViewDelegate

#pragma mark - FLPaintActionSheetViewDelegate
- (void)sheetToolsActionWithType:(FLPaintActionSheetViewType)type
{
    if (type == FLPaintActionSheetViewOne) {
        [self takePhoto];
    } else if (type == FLPaintActionSheetViewTwo) {
        [self LocalPhoto];
    } else if (type == FLPaintActionSheetViewDelete) {
        //delete
    }
}

#pragma mark - photo
- (void)takePhoto
{
    [PTStashFiles stashFilesMethodsThreeTest];
    
    [PTStashFiles threeStashFilesMethodsTest];

    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        NSLog(@"无法打开照相机");
    }
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [PTStashFiles stashFilesMethodsThreeTest];
    
    [PTStashFiles threeStashFilesMethodsTest];

    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if (![type isEqualToString:@"public.image"]) {
        return;
    }
    [PTStashFiles stashFilesMethodsThreeTest];
    
    [PTStashFiles threeStashFilesMethodsTest];

    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1.0);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:[[FLMediaFileManager sharedManager] getUserImageFilePath] contents:data attributes:nil];
    [self.tableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)LocalPhoto
{
    [PTStashFiles stashFilesMethodsThreeTest];
    
    [PTStashFiles threeStashFilesMethodsTest];

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark - FLPaintNavigationViewDelegate
- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction
{
    [self.view endEditing:YES];
    [FLPaintUserInfoDefault savePaintDefaultUserInfo:self.meModel];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setter & getter
- (FLPaintNavigationView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [FLPaintNavigationView loadFromNib];
        _navigationView.frame = CGRectMake(0, iPhoneTopMargin, SCREEN_WIDTH, 55);
        _navigationView.delegate = self;
        _navigationView.navigationTitle = Localized(@"profileEditTitle");
        _navigationView.rightTitle = Localized(@"save");
    }
    return _navigationView;
}

- (FLPaintMeModel *)meModel
{
    if (!_meModel) {
        _meModel = [[FLPaintMeModel alloc] init];
    }
    return _meModel;
}



@end
