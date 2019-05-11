//
//  FLPaintNotificationManager.h
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/17.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FLPaintNotificationVo;

@interface FLPaintNotificationManager : NSObject

+ (FLPaintNotificationManager *)shareInstance;

- (void)registNotifications;

- (void)addPaintNotificationWithVo:(FLPaintNotificationVo *)vo;

- (void)showPaintPushViewWithUserinfo:(NSDictionary *)userinfo;


@end
