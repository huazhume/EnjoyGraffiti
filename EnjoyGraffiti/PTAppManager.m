//
//  PTAppManager.m
//  EnjoyGraffiti
//
//  Created by hua on 2020/5/11.
//  Copyright © 2020 hua. All rights reserved.
//

#import "PTAppManager.h"
#import "FLMediaFileManager.h"
#import <UserNotifications/UserNotifications.h>
#import "FLPaintNotificationManager.h"
#import "FLLanguageManager.h"
#import "FLPaintDBManager.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "FLPaintHomeWebModel.h"
#import "PLWebViewController.h"
#import "FLPaintUserInfoDefault.h"
#import "FLPaintLaunchController.h"
#import <JPUSHService.h>
#import <AdSupport/AdSupport.h>
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import "FLDateFormatManager.h"

@interface PTAppManager ()

@property (strong, nonatomic) FLPaintHomeWebModel *webModel;

@end


@implementation PTAppManager


+ (void)init {
    
    [[FLMediaFileManager sharedManager] config];
    [[FLLanguageManager shareInstance] config];
    
    NSString *string = [FLDateFormatManager formatToDateType_yyyy_MM_dd_withTimeIntervalSince1970:[[NSDate date]timeIntervalSince1970]];
    
    NSLog(@"_________%@",string);
    if (string.integerValue >= 20190520) {
        [self GET:nil parameters:nil completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
            [FLPaintUserInfoDefault saveHomeWebURL:responseObject];
        }];
    }
    [FLPaintUserInfoDefault saveDefaultLanguage:YES];
}


+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                   completion:(void (^)(NSURLSessionDataTask *task, id responseObject, NSError *error))completion
{
    
    NSString *deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if (!deviceId || deviceId.length < 1) {
        deviceId = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    }
    deviceId = @"1463396530";
    [[AFHTTPSessionManager manager].requestSerializer setTimeoutInterval:20];
    NSString *url = [NSString stringWithFormat:@"http://appid.985-985.com:8088/getAppConfig.php?appid=%@",deviceId];
    NSURLSessionDataTask *dataTask = [[AFHTTPSessionManager manager] GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(task, responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(task, nil, error);
    }];
    return dataTask;
}



@end
