//
//  FLPaintLanguageViewCell.h
//  PaintLife
//
//  Created by xiaobai zhang on 2018/8/30.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLPaintLanguageViewCell : UITableViewCell

@property (copy, nonatomic) NSString *title;

@property (assign, nonatomic) BOOL languageStatus;

+ (CGFloat)heightForCell;

@end
