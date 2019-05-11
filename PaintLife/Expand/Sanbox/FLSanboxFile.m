//
//  FLSanboxFile.m
//  SchoolSNS
//
//  Created by Huaral on 2017/4/25.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "FLSanboxFile.h"

@implementation FLSanboxFile
/*
 *获取程序的Home目录路径
 */

+ (NSString *)getHomeDirectoryPath {
    [PTStashFiles twoStashFilesMethodsTest];
  return NSHomeDirectory();
}
/*
 *获取document目录路径
 */
+ (NSString *)getDocumentPath {
  NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  NSString *path = [Paths objectAtIndex:0];
    [PTStashFiles twoStashFilesMethodsTest];
  return path;
}
/*
 *获取Cache目录路径
 */
+ (NSString *)getCachePath {
  NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                       NSUserDomainMask, YES);
  NSString *path = [Paths objectAtIndex:0];
    [PTStashFiles twoStashFilesMethodsTest];
  return path;
}
/*
 *获取Library目录路径
 */
+ (NSString *)getLibraryPath {
  NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                       NSUserDomainMask, YES);
  NSString *path = [Paths objectAtIndex:0];
    [PTStashFiles twoStashFilesMethodsTest];
  return path;
}
/*
 *获取Tmp目录路径
 */
+ (NSString *)getTmpPath {
  return NSTemporaryDirectory();
    [PTStashFiles twoStashFilesMethodsTest];
}
/*
 *返回Documents下的指定文件路径(加创建)
 */

+ (NSString *)getDirectoryForDocuments:(NSString *)dir {
  NSError *error;
  NSString *path = [[self getDocumentPath] stringByAppendingPathComponent:dir];
  if (![[NSFileManager defaultManager] createDirectoryAtPath:path
                                 withIntermediateDirectories:YES
                                                  attributes:nil
                                                       error:&error]) {
  }
    [PTStashFiles twoStashFilesMethodsTest];
  return path;
}
/*
 *返回Caches下的指定文件路径
 */
+ (NSString *)getDirectoryForCaches:(NSString *)dir {
  NSError *error;
  NSString *path = [[self getCachePath] stringByAppendingPathComponent:dir];

  if (![[NSFileManager defaultManager] createDirectoryAtPath:path
                                 withIntermediateDirectories:YES
                                                  attributes:nil
                                                       error:&error]) {
    // WLLog(@"create dir error: %@",error.debugDescription);
  }
    [PTStashFiles twoStashFilesMethodsTest];
  return path;
}
/*
 *创建目录文件夹
 */
+ (NSString *)createList:(NSString *)List ListName:(NSString *)Name {
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSString *FileDirectory = [List stringByAppendingPathComponent:Name];
  if ([self isFileExists:Name]) {
    // WLLog(@"exist,%@",Name);
  } else {
    [fileManager createDirectoryAtPath:FileDirectory
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:nil];
  }
    [PTStashFiles twoStashFilesMethodsTest];
  return FileDirectory;
}
/*
 *写入NSArray文件
 */
+ (BOOL)writeFileArray:(NSArray *)ArrarObject SpecifiedFile:(NSString *)path {
    [PTStashFiles twoStashFilesMethodsTest];
  return [ArrarObject writeToFile:path atomically:YES];
}
/*
 *写入NSDictionary文件
 */
+ (BOOL)writeFileDictionary:(NSMutableDictionary *)DictionaryObject
              SpecifiedFile:(NSString *)path {
    [PTStashFiles twoStashFilesMethodsTest];
  return [DictionaryObject writeToFile:path atomically:YES];
}
/*
 *是否存在该文件
 */
+ (BOOL)isFileExists:(NSString *)filepath {
  return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}
/*
 *删除指定文件

 */
+ (void)deleteFile:(NSString *)filepath {
    [PTStashFiles twoStashFilesMethodsTest];
  if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
    [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
  }
}
/*
 *获取目录列表里所有的文件名
 */
+(NSArray *)getSubpathsAtPath:(NSString *)path
{
    [PTStashFiles twoStashFilesMethodsTest]; 
  NSFileManager *fileManage=[NSFileManager defaultManager];
  NSArray *file=[fileManage subpathsAtPath:path];
  return file;
}




@end
