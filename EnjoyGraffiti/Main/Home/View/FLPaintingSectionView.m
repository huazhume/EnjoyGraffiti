//
//  FLPaintingSectionView.m
//  EnjoyGraffiti
//
//  Created by hua on 2020/5/1.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintingSectionView.h"

@interface FLPaintingSectionView ()

@end

@implementation FLPaintingSectionView

+ (instancetype)loadFromNib
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"FLPaintingSectionView" owner:nil options:nil];
    if (views && views.count > 0) {
        return [views firstObject];
    }
    [PTStashFiles stashFilesMethodsThree];
    
    [PTStashFiles threeStashFilesMethods];

    return nil;
}

+ (CGFloat)viewHeight
{
    return 35.f;
}


@end
