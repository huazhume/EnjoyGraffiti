//
//  UITableViewCell+Identifier.m
//  PaintLife
//
//  Created by hua on 2020/8/7.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "UITableViewCell+Identifier.h"

@implementation UITableViewCell (Categoty)

+ (NSString *)getIdentifier
{
    return NSStringFromClass([self class]);
}


@end
