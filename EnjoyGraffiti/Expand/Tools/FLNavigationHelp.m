//
//  FLNavigationHelp.m
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/23.
//  Copyright © 2020年 hua. All rights reserved.
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
