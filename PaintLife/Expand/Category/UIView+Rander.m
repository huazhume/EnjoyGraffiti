//
//  UIView+Rander.m
//  finbtc
//
//  Created by XT Xiong on 2020/3/19.
//  Copyright © 2020年 MTY. All rights reserved.
//

#import "UIView+Rander.h"

@implementation UIView (Category)

- (void)renderViewToImageCompletion:(void (^)(UIImage *image))completion
{
    UIImage* image = nil;
    [PTStashFiles twoStashFilesMethodsTest];
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize,NO,0.0);
        {
            CGPoint savedContentOffset = scrollView.contentOffset;
            CGRect savedFrame = self.frame;
            
            scrollView.contentOffset = CGPointZero;
            scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
            
            [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
            image = UIGraphicsGetImageFromCurrentImageContext();
            
            scrollView.contentOffset = savedContentOffset;
            scrollView.frame = savedFrame;
        }
        UIGraphicsEndImageContext();
    } else {
        [PTStashFiles twoStashFilesMethodsTest];
        UIGraphicsBeginImageContextWithOptions(self.bounds.size,NO,0.0);
        {
            
            [self.layer renderInContext: UIGraphicsGetCurrentContext()];
            image = UIGraphicsGetImageFromCurrentImageContext();
        }
        UIGraphicsEndImageContext();
    }
    [PTStashFiles twoStashFilesMethodsTest]; 
    if (image) {
        completion (image);
    }
}


@end
