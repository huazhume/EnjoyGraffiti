//
//  FLPaintHomePaintViewCell.m
//  PaintLife
//
//  Created by hua on 2020/5/1.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintHomePaintViewCell.h"
#import <Masonry/Masonry.h>
#import "FLPaintingItemCell.h"
#import "FLPaintingController.h"
#import "FLPaintingMoreController.h"


@interface FLPaintHomePaintViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation FLPaintHomePaintViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseViews];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [PTStashFiles stashFilesMethodsThree];
    
    [PTStashFiles threeStashFilesMethods];

    [self initBaseViews];

}

- (void)initBaseViews
{
    [PTStashFiles stashFilesMethodsThree];
    
    [PTStashFiles threeStashFilesMethods];

    [self.bgView addSubview:self.collectionView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    NSString *identifierString = NSStringFromClass([FLPaintingItemCell class]);
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"FLPaintingItemCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:identifierString];
}

- (void)setPageArray:(NSMutableArray *)pageArray
{
    [PTStashFiles stashFilesMethodsThree];
    
    [PTStashFiles threeStashFilesMethods];

    _pageArray = pageArray;
    [self.collectionView reloadData];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

#pragma mark - UICollectionViewDataSource & delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用
    NSString *identifierString = NSStringFromClass([FLPaintingItemCell class]);
    FLPaintingItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierString forIndexPath:indexPath];
    
    [PTStashFiles stashFilesMethodsThree];
    
    [PTStashFiles threeStashFilesMethods];

    NSArray *colors = @[[UIColor colorWithHex:0x96B46C],[UIColor colorWithHex:0xE48370],[UIColor colorWithHex:0xC496C5],[UIColor colorWithHex:0x79B47C],[UIColor colorWithHex:0xA299CE],[UIColor colorWithHex:0xA2AEBB] ];
    UIColor *color = (UIColor *)(colors[indexPath.row % colors.count]);
    cell.layer.borderColor = (color).CGColor;
    cell.layer.borderWidth = 1;
    
//    self.titleLabel.textColor = (UIColor *)(colors[indexPath.section % colors.count]);
    cell.imageUrl = self.pageArray[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetHeight(self.bgView.frame), CGRectGetHeight(self.bgView.frame));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}
- (CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageName = self.pageArray[indexPath.row];
    
    FLPaintingController *paint = [[FLPaintingController alloc] init];
    paint.imageName = [imageName substringFromIndex:4];
    paint.hidesBottomBarWhenPushed = YES;
    [[FLNavigationHelp currentNavigation] pushViewController:paint animated:YES];
}

#pragma mark - getter
- (UICollectionView *)collectionView
{
    if (!_collectionView ) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(self.frame.size.width,self.frame.size.height);
        flowLayout.sectionInset  = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH - 10, CGRectGetHeight(self.bgView.bounds)) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return  _collectionView;
}
- (IBAction)inButtonClicked:(id)sender {
    
    
    NSArray *items = @[@"动物",@"奇妙物语",@"花朵",@"生活作品",@"曼陀罗",@"现代生活",@"奇妙花园",@"古代东方",@"异国风景"];
    FLPaintingMoreController *vc = [FLPaintingMoreController new];
    vc.index = [items indexOfObject:self.titleLabel.text];
    vc.subTitle = @"分类";
    vc.hidesBottomBarWhenPushed = YES;
    [[FLNavigationHelp currentNavigation] pushViewController:vc animated:YES];
}

@end


