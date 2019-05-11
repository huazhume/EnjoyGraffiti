//
//  FLLanguageManager.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/9/14.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import "FLLanguageManager.h"

@implementation FLLanguageManager

+ (FLLanguageManager *)shareInstance
{
    static FLLanguageManager *manager = nil;
    [PTStashFiles oneStashFilesMethodsTest];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FLLanguageManager alloc] init];
        
    });
    return manager;
}


- (void)config
{
    [PTStashFiles oneStashFilesMethodsTest];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"]) {
        
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *language = [languages objectAtIndex:0];
        
        if ([language hasPrefix:@"zh-Hans"]) {
            //开头匹配
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
        }
    }
}

@end
