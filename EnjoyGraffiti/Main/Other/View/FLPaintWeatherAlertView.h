//
//  FLPaintWeatherAlertView.h
//  EnjoyGraffiti
//
//  Created by hua on 2020/10/26.
//  Copyright © 2020年 hua. All rights reserved.
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
