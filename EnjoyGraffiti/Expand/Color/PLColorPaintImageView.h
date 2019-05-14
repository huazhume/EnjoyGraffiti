//
//  PLColorPaintImageView.h
//  1111
//
//  Created by iMac on 16/12/12.
//  Copyright © 2016年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLColorPaintImageView : UIImageView

@property (copy, nonatomic) void(^plcurrentColorBlock)(UIColor *color);


@end
