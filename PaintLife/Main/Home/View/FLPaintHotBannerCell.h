//
//  FLPaintHotBannerCell.h
//  finbtc
//
//  Created by xiaobai zhang on 2020/12/17.
//  Copyright © 2020年 MTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLPaintHotBannerCell : UICollectionViewCell

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, strong, readonly) NSMutableArray *itemSubViews;

@property (strong, nonatomic) UIImageView *imageView;;

@end
