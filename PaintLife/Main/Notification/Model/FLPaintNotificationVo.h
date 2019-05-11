//
//  FLPaintNotificationVo.h
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/29.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLPaintNotificationVo : NSObject

@property (copy, nonatomic) NSString *notificationId;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *time;

@property (strong, nonatomic) NSNumber *state;

@end
