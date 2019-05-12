//
//  FLPaintLanguageViewCell.h
//  PaintLife
//
//  Created by hua on 2020/8/30.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLPaintLanguageViewCell : UITableViewCell

@property (copy, nonatomic) NSString *title;

@property (assign, nonatomic) BOOL languageStatus;

+ (CGFloat)heightForCell;

@end
