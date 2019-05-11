//
//  FLPaintUserInfoDefault.h
//  PaintLife
//
//  Created by xiaobai zhang on 2018/8/28.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FLPaintMeModel;

@interface FLPaintUserInfoDefault : NSObject

+ (void)savePaintDefaultUserInfo:(FLPaintMeModel *)model;

+ (FLPaintMeModel *)getPaintUserDefaultMeModel;

+ (void)saveDefaultLanguage:(BOOL)isChinese;

+ (BOOL)getUserDefaultLanguageIsChinese;

+ (void)saveHomeWebURL:(NSDictionary *)url;

+ (NSDictionary *)getHomeWebURL;

+ (void)savePaintAgreeSecretList;

+ (BOOL)isPaintAgreeSecretList;

+ (void)savePaintString:(NSString *)fileName;

+ (NSArray *)getPaintingArrays;

@end
