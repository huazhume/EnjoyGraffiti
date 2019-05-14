//
//  FLHUDPaintToastView.h
//  Meiyu
//
//  Created by QingyunLiao on 2/17/16.
//  Copyright © 2016 jimeiyibao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLHUDPaintToastView : UIView

+ (instancetype)paintToastViewWithAttributedString:(NSAttributedString *)attributedString
                                          inRect:(CGRect)rect;

@end
