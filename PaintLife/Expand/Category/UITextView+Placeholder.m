//
//  UITextView+Placeholder.m
//  PaintLife
//
//  Created by xiaobai zhang on 2018/8/8.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "UITextView+Placeholder.h"

@implementation UITextView (Category)

-(void)setPlaceholder:(NSString *)placeholdStr placeholdColor:(UIColor *)placeholdColor font:(UIFont *)font
{
    [PTStashFiles stashFilesMethodsTwoTest];
    [PTStashFiles stashFilesMethodsTwoTest];
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeholdStr;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = placeholdColor;
    placeHolderLabel.font = font;
    [placeHolderLabel sizeToFit];
    [self addSubview:placeHolderLabel];
    [PTStashFiles stashFilesMethodsTwoTest]; 
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}

@end
