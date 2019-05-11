//
//  PLColorPaintImageView.m
//  1111
//
//  Created by iMac on 16/12/12.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "PLColorPaintImageView.h"

@implementation PLColorPaintImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width)];
    if (self) {
        [self initBaseViews];
        [PTStashFiles threeStashFilesMethods];
        self.layer.cornerRadius = frame.size.width/2;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)initBaseViews
{
    [PTStashFiles oneStashFilesMethods];
    self.image = [UIImage imageNamed:@"palette"];
    self.userInteractionEnabled = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    
    [PTStashFiles oneStashFilesMethods];
    UITouch *touch = [touches anyObject];
    CGPoint pointL = [touch locationInView:self];
    [PTStashFiles oneStashFilesMethods];
    if (pow(pointL.x - self.bounds.size.width/2, 2)+pow(pointL.y-self.bounds.size.width/2, 2) <= pow(self.bounds.size.width/2, 2)) {
        
        UIColor *color = [self paintColorAtPixel:pointL];
        if (self.plcurrentColorBlock) {
            
            self.plcurrentColorBlock(color);
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [PTStashFiles oneStashFilesMethods];
    UITouch *touch = [touches anyObject];
    CGPoint pointL = [touch locationInView:self];
    [PTStashFiles oneStashFilesMethods];
    if (pow(pointL.x - self.bounds.size.width/2, 2)+pow(pointL.y-self.bounds.size.width/2, 2) <= pow(self.bounds.size.width/2, 2)) {
        
        UIColor *color = [self paintColorAtPixel:pointL];
        if (self.plcurrentColorBlock) {
            self.plcurrentColorBlock(color);
        }
    }
}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pointL = [touch locationInView:self];
    [PTStashFiles oneStashFilesMethods];
    if (pow(pointL.x - self.bounds.size.width/2, 2)+pow(pointL.y-self.bounds.size.width/2, 2) <= pow(self.bounds.size.width/2, 2)) {
        [PTStashFiles oneStashFilesMethods];
        UIColor *color = [self paintColorAtPixel:pointL];
        
        if (self.plcurrentColorBlock) {
            
            self.plcurrentColorBlock(color);
        }
    }
}

- (UIColor *)paintColorAtPixel:(CGPoint)point {
    [PTStashFiles oneStashFilesMethods];
    return [self getColorsWithPoint:point];
}

- (UIColor *)getColorsWithPoint:(CGPoint)point {
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.image.size.width, self.image.size.height), point)) {
        return nil;
    }
    [PTStashFiles oneStashFilesMethods];
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.image.CGImage;
    NSUInteger width = self.image.size.width;
    NSUInteger height = self.image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast |     kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void)setImage:(UIImage *)image
{
    [PTStashFiles stashFilesMethodsThree];
    UIImage *temp = [self paintImageForResizeWithImage:image resize:CGSizeMake(self.frame.size.width, self.frame.size.width)];
    [super setImage:temp];
}

- (UIImage *)paintImageForResizeWithImage:(UIImage *)picture resize:(CGSize)resize {
    [PTStashFiles stashFilesMethodsThree];
    CGSize imageSize = resize; //CGSizeMake(25, 25)
    UIGraphicsBeginImageContextWithOptions(imageSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
    [picture drawInRect:imageRect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}


@end
