//
//  FLPaintNoteDetailController.h
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/14.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLPaintNoteDetailController : UIViewController

@property (copy, nonatomic) NSString *noteId;

@property (strong, nonatomic) UIColor *color;

@property (assign, nonatomic) BOOL isStatusBarHidden;

@property (assign, nonatomic) BOOL isJubaoHidden;

@property (copy, nonatomic) NSString *weather;
@property (weak, nonatomic) IBOutlet UIButton *jubaoButton;

@end
