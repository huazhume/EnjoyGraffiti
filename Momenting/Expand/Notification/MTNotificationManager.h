//
//  MTNotificationManager.h
//  Momenting
//
//  Created by xiaobai zhang on 2018/8/17.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTNotificationManager : NSObject

+ (MTNotificationManager *)shareInstance;

- (void)AddMinutesNotification;

@end
