//
//  PTFirstViewController.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/5/11.
//  Copyright © 2020 xiaobai zhang. All rights reserved.
//

#import "PTFirstViewController.h"
#import "FLPaintActivityView.h"

@interface PTFirstViewController ()

@property (weak, nonatomic) IBOutlet FLPaintActivityView *paintView;


@end

@implementation PTFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
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
