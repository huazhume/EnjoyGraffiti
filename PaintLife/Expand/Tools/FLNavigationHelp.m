//
//  FLNavigationHelp.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/23.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import "FLNavigationHelp.h"

@implementation FLNavigationHelp

+ (UINavigationController *)currentNavigation
{
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *navigation;
    if([rootController isKindOfClass:[UITabBarController class]]){
        
        UITabBarController *tab = (UITabBarController *)rootController;
        navigation = tab.selectedViewController;
        
    }
    return navigation;
}

@end
