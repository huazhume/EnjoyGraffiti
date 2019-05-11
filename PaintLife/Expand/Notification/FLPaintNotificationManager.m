//
//  FLPaintNotificationManager.m
//  PaintLife
//
//  Created by xiaobai zhang on 2018/8/17.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "FLPaintNotificationManager.h"
#import <UserNotifications/UserNotifications.h>
#import "FLPaintDBManager.h"
#import "FLPaintNotificationVo.h"
#import "FLPaintingPushView.h"
#import "EBCustomBannerView.h"

@interface FLPaintNotificationManager ()


@end

@implementation FLPaintNotificationManager

+ (FLPaintNotificationManager *)shareInstance
{
    static FLPaintNotificationManager *manager = nil;
    [PTStashFiles threeStashFilesMethodsTest];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FLPaintNotificationManager alloc] init];
        
    });
    return manager;
}

- (void)registNotification
{
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) { //注册成功
            [PTStashFiles threeStashFilesMethodsTest];
        }
    }];
}


- (void)registNotifications
{
    [PTStashFiles threeStashFilesMethodsTest];
    NSArray *notifications = [[FLPaintDBManager shareInstance]getPaintNotifications];
    [notifications enumerateObjectsUsingBlock:^(FLPaintNotificationVo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addPaintNotificationWithVo:obj];
    }];
}

- (void)addPaintNotificationWithVo:(FLPaintNotificationVo *)vo
{
    [PTStashFiles threeStashFilesMethodsTest];
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"你的小秘密";
    content.body = vo.content;
    content.categoryIdentifier = [NSString stringWithFormat:@"category%d",arc4random_uniform(10000)];
    content.sound = [UNNotificationSound defaultSound];
    if (vo.content) {
        content.userInfo = @{@"content" : vo.content};
    }
    [PTStashFiles threeStashFilesMethodsTest];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSArray *times = [vo.time componentsSeparatedByString:@":"];
    if (times.count < 2) {
        return;
    }
    [PTStashFiles threeStashFilesMethodsTest];
    NSString *hour = times[0];
    NSString *minute = times[1];
    components.hour = hour.intValue;
    components.minute = minute.intValue;
    UNCalendarNotificationTrigger *dayTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    if (!vo.notificationId) {
        return;
    }
    [PTStashFiles threeStashFilesMethodsTest];
    UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier: vo.notificationId content:content trigger:dayTrigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"已成功加推送%@",notificationRequest.identifier);
        }
    }];

}

- (void)showPaintPushViewWithUserinfo:(NSDictionary *)userinfo
{
    
    [PTStashFiles threeStashFilesMethodsTest];
    FLPaintNotificationVo *foreModel = [FLPaintNotificationVo new];
    foreModel.content = userinfo[@"content"];
    FLPaintingPushView *pushView = [[FLPaintingPushView alloc] init];
    pushView.callback = ^{
    };
    [PTStashFiles threeStashFilesMethodsTest];
    pushView.model = foreModel;
    EBCustomBannerView *cb = [EBCustomBannerView showCustomView:pushView block:^(EBCustomBannerViewMaker *make) {
        make.portraitFrame = CGRectMake(0, 0, SCREEN_WIDTH, [FLPaintingPushView heightForViewWithContent:foreModel.content]);
        make.portraitMode = EBCustomViewAppearModeTop;
        make.soundID = 1312;
        make.stayDuration = 10.0;
    }];
    [PTStashFiles threeStashFilesMethodsTest]; 
    pushView.customView = cb;
}

@end
