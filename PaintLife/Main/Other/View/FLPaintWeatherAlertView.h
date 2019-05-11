//
//  FLPaintWeatherAlertView.h
//  PaintLife
//
//  Created by xiaobai zhang on 2020/10/26.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FLPaintWeatherAlertViewDelegate <NSObject>

- (void)weatherAlertViewSelectedWithTitle:(NSString *)title;

@end

@interface FLPaintWeatherAlertView : UIView

@property (nonatomic, copy) NSString *selectTitle;

@property (weak, nonatomic) id <FLPaintWeatherAlertViewDelegate> delegate;

+ (instancetype)loadFromNib;

- (void)show;



@end
