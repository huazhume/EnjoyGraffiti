//
//  FLPaintActionAlertView.h
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/10.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertBlock)(NSInteger index);

@interface FLPaintActionAlertView : UIView

@property (copy, nonatomic) AlertBlock block;

+ (instancetype)loadFromNib;

+ (CGFloat)viewHeight;

- (void)show;

+ (void)alertShowWithMessage:(NSString *)message leftTitle:(NSString *)leftTitle leftColor:(UIColor *)color rightTitle:(NSString *)rightTitle rightColor:(UIColor *)rightColor callBack:(AlertBlock)block;

@end
