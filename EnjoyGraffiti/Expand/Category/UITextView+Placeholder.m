//
//  UITextView+Placeholder.m
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/8.
//  Copyright © 2020年 hua. All rights reserved.
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
