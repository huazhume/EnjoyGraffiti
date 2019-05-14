//
//  FLPaintToastView.h
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/15.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLPaintToastView : UIView

@property (copy, nonatomic) NSString *content;

+ (instancetype)loadFromNib;

- (void)show;

@end
