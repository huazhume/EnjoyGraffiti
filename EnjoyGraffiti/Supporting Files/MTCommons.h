//
//  MYCommons.h
//  Meiyu
//
//  Created by QingyunLiao on 15/11/6.
//  Copyright © 2015年 jimeiyibao. All rights reserved.
//

#ifndef MYCommons_h
#define MYCommons_h


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define Localized(key)  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"Language"]

#define IS_iPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneTopMargin (IS_iPHONE_X ? 24.f : 0.f)



#import "UIColor+CHex.h"
#import "UITableViewCell+Identifier.h"
#import "UITextView+Placeholder.h"
#import <Masonry/Masonry.h>
#import "UIView+Rander.h"
#import "FLNavigationHelp.h"
#import "NSDateFormatter+Date.h"
#import "FLLanguageManager.h"
#import "UIFont+Weather.h"
#import "UIView+PaintTost.h"
#import "UIImage+Compress.h"
#import "FLMediaFileManager.h"
#import "FLPaintUserInfoDefault.h"
#import <MJRefresh/MJRefresh.h>
#import "PTStashFiles.h"


#endif /* MYCommons_h */
