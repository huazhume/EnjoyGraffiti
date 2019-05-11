//
//  PTTabViewController.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/5/11.
//  Copyright © 2020 xiaobai zhang. All rights reserved.
//

#import "PTTabViewController.h"
#import "FLPaintNoteViewController.h"

@interface PTTabViewController () <UITabBarControllerDelegate>

@end

@implementation PTTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.tabBar.tintColor = [UIColor colorWithHex:0x333333];
    
    // Do any additional setup after loading the view.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [tabBar.items indexOfObject:item];
    
    if (index == 2) {
        
        FLPaintNoteViewController *vc = [[FLPaintNoteViewController alloc] init];
        vc.isDisMiss = YES;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == 2) return NO;
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
