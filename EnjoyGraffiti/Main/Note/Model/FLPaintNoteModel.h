//
//  FLPaintNoteModel.h
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/8.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MTNoteFontTypeNormal,
    MTNoteFontTypeItalic,
    MTNoteFontTypeBold,
} MTNoteFontType;


@interface FLPaintNoteModel : NSObject

@property (strong, nonatomic) NSArray *contents;
@property (copy, nonatomic) NSString *noteId;
@property (copy, nonatomic) NSString *imagePath;
@property (copy, nonatomic) NSString *text;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) NSInteger indexRow;
@property (strong, nonatomic) UIColor *sectionColor;
@property (assign, nonatomic) CGFloat fontSize;
@property (strong, nonatomic) NSString *fontName;
@property (strong, nonatomic) NSString *weather;

@end

@interface MTNoteBaseVo : NSObject

@property (copy, nonatomic) NSString *noteId;
@property (assign, nonatomic) NSInteger sortIndex;

@end

@interface MTNoteImageVo : MTNoteBaseVo

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (copy, nonatomic) NSString *path;

@end

@interface MTNoteTextVo : MTNoteBaseVo

@property (assign, nonatomic) CGFloat fontSize;
@property (strong, nonatomic) NSString *fontName;
@property (copy, nonatomic) NSString *text;
@property (assign, nonatomic) MTNoteFontType fontType;

@end





