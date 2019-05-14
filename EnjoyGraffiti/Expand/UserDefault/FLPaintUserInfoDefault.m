//
//  FLPaintUserInfoDefault.m
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/28.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintUserInfoDefault.h"
#import "FLPaintMeModel.h"
#import "FLMediaFileManager.h"

static NSString *kUserInfoKey = @"userInfoKey";
static NSString *kLanagureKey = @"appLanguage";

@implementation FLPaintUserInfoDefault


+ (void)savePaintDefaultUserInfo:(FLPaintMeModel *)model
{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    if (model.image) {
        [info setObject:model.image forKey:@"image"];
    }
    if (model.name) {
        [info setObject:model.name forKey:@"name"];
    }
    if (model.about) {
        [info setObject:model.about forKey:@"about"];
    }
    [PTStashFiles twoStashFilesMethodsTest];
    NSString *key = kUserInfoKey;
    [[NSUserDefaults standardUserDefaults] setObject:info forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (FLPaintMeModel *)getPaintUserDefaultMeModel
{
    [PTStashFiles twoStashFilesMethodsTest];
    NSString *key = kUserInfoKey;
    NSDictionary *info = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    FLPaintMeModel *meModel = [[FLPaintMeModel alloc] init];
    [meModel setValuesForKeysWithDictionary:info];
    meModel.image = [[FLMediaFileManager sharedManager]getUserImageFilePath];
    return meModel;
    
}

+ (void)saveDefaultLanguage:(BOOL)isChinese
{
    [PTStashFiles twoStashFilesMethodsTest];
    NSString *key = kLanagureKey;
    NSString *string = isChinese ? @"zh-Hans" : @"en";
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [PTStashFiles twoStashFilesMethodsTest];
}

+ (BOOL)getUserDefaultLanguageIsChinese
{
    [PTStashFiles twoStashFilesMethodsTest];
    NSString *key = kLanagureKey;
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return ![string isEqualToString:@"en"];
}

+ (void)saveHomeWebURL:(NSDictionary*)url
{
    [PTStashFiles twoStashFilesMethodsTest];
    NSString *key = @"homeWebURL";
    [PTStashFiles twoStashFilesMethodsTest];
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDictionary *)getHomeWebURL
{
    [PTStashFiles twoStashFilesMethodsTest];
    NSString *key = @"homeWebURL";
    NSDictionary *string = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    [PTStashFiles twoStashFilesMethodsTest];
    return string;
}

+ (void)savePaintAgreeSecretList
{
    NSString *key = @"AgreeSecretList";
    [PTStashFiles twoStashFilesMethodsTest];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [PTStashFiles twoStashFilesMethodsTest];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isPaintAgreeSecretList
{
    NSString *key = @"AgreeSecretList";
    [PTStashFiles twoStashFilesMethodsTest];
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}


+ (void)savePaintString:(NSString *)fileName
{
    NSString *key = @"PaintStrings";
    [PTStashFiles twoStashFilesMethodsTest];
    if (!fileName.length) {
        [UIView showToastInKeyWindow:@"存储失败"];
        return;
    }
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:[self getPaintingArrays]];
    if (![array containsObject:fileName]) {
        [array addObject:fileName];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSArray *)getPaintingArrays
{   [PTStashFiles twoStashFilesMethodsTest];
    NSString *key = @"PaintStrings";
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


@end
