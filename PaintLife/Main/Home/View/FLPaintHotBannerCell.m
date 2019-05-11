//
//  FLPaintHotBannerCell.m
//  finbtc
//
//  Created by xiaobai zhang on 2020/12/17.
//  Copyright © 2020年 MTY. All rights reserved.
//

#import "FLPaintHotBannerCell.h"
#import <Masonry/Masonry.h>

@interface FLPaintHotBannerCell ()


@end

@implementation FLPaintHotBannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseViews];
    }
    return self;
}

#pragma mark - initBaseViews
- (void)initBaseViews
{

    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self).offset(5);
        make.trailing.bottom.equalTo(self).offset(-5);
    }];
}

#pragma mark - setter

#pragma mark - getter
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor purpleColor];
        _imageView.layer.cornerRadius = 8;
        _imageView.layer.masksToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}


@end
