//
//  FLLanguageManager.h
//  PaintLife
//
//  Created by xiaobai zhang on 2020/9/14.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *kLanguageNotification = @"FLPaintLanguageController";

@interface FLLanguageManager : NSObject

+ (FLLanguageManager *)shareInstance;

- (void)config;

@end
