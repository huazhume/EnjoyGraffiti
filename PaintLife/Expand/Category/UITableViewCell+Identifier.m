//
//  UITableViewCell+Identifier.m
//  PaintLife
//
//  Created by xiaobai zhang on 2018/8/7.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "UITableViewCell+Identifier.h"

@implementation UITableViewCell (Categoty)

+ (NSString *)getIdentifier
{
    return NSStringFromClass([self class]);
}


@end