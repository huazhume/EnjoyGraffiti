//
//  UIView+Rander.h
//  finbtc
//
//  Created by XT Xiong on 2018/3/19.
//  Copyright © 2018年 MTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

- (void)renderViewToImageCompletion:(void (^)(UIImage *image))completion;

@end
