//
//  FLLanguageManager.h
//  PaintLife
//
//  Created by hua on 2020/9/14.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *kLanguageNotification = @"FLPaintLanguageController";

@interface FLLanguageManager : NSObject

+ (FLLanguageManager *)shareInstance;

- (void)config;

@end
