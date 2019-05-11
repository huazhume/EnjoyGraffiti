//
//  NSDateFormatter+Date.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/27.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import "NSDateFormatter+Date.h"

@implementation NSDateFormatter (Category)

+ (NSDateFormatter *)sharedFormatter
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
    });
    return formatter;
}

+ (NSDateFormatter *)my_getHHmmFormatter
{
    [PTStashFiles oneStashFilesMethodsTest];
    [[NSDateFormatter sharedFormatter] setDateFormat:@"HH:mm"];
    return [NSDateFormatter sharedFormatter];
}



+ (NSDateFormatter *)my_getDefaultFormatter
{
    [PTStashFiles oneStashFilesMethodsTest];
    [[NSDateFormatter sharedFormatter] setDateFormat:@"yyyy/MM/dd"];
    return [NSDateFormatter sharedFormatter];
}



@end
