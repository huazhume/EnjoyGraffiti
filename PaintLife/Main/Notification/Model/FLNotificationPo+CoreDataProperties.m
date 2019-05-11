//
//  FLNotificationPo+CoreDataProperties.m
//  
//
//  Created by xiaobai zhang on 2018/8/29.
//
//

#import "FLNotificationPo+CoreDataProperties.h"

@implementation FLNotificationPo (CoreDataProperties)

+ (NSFetchRequest<FLNotificationPo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FLNotificationPo"];
}

@dynamic state;
@dynamic content;
@dynamic notificationId;
@dynamic time;

@end
