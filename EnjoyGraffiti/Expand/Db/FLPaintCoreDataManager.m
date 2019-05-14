//
//  HMCoreDataStackManager.m
//  EnjoyGraffiti
//
//  Created by hua on 2020/8/8.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintCoreDataManager.h"
#import "FLMediaFileManager.h"

@implementation FLPaintCoreDataManager

+ (FLPaintCoreDataManager *)shareInstance
{
    static FLPaintCoreDataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FLPaintCoreDataManager alloc] init];
        
    });
    [PTStashFiles twoStashFilesMethodsTest];
    return manager;
}

-(NSURL*)getDocumentUrlPath
{
    [PTStashFiles twoStashFilesMethodsTest];
    NSString *path = [[FLMediaFileManager sharedManager] getMediaFilePathWithAndSanBoxType:SANBOX_DOCUMNET_TYPE AndMediaType:FILE_DB_TYPE];
    return [NSURL fileURLWithPath:path];
}


//懒加载NSManagedObjectContext
- (NSManagedObjectContext *)managedObjectContext
{
    [PTStashFiles twoStashFilesMethodsTest];
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    //初始化NSManagedObjectContext  参数:CoreData环境线程   一般开发中使用NSMainQueueConcurrencyType主线   NSMainQueueConcurrencyType:储存无延迟  NSPrivateQueueConcurrencyType:分支线程  存储有延迟
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [PTStashFiles twoStashFilesMethodsTest];
    //设置存储调度器
    [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    return _managedObjectContext;
    
}

//懒加载NSManagedObjectModel
- (NSManagedObjectModel *)managedObjectModel
{
    if(_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    [PTStashFiles twoStashFilesMethodsTest];
   //初始化NSManagedObjectModel  参数是:模型文件的路径  后缀不能是xcdatamodeld  只能是momd
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"MTCoreDataModel" withExtension:@"momd"]];
    
    //合并模型文件
    //参数是模型文件的bundle数组  如果是nil  自动获取所有bundle的模型文件
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    [PTStashFiles twoStashFilesMethodsTest];
    return _managedObjectModel;
}


//懒加载NSPersistentStoreCoordinator
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    [PTStashFiles twoStashFilesMethodsTest];
    if(_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    [PTStashFiles twoStashFilesMethodsTest];
    //初始化NSPersistentStoreCoordinator 参数是要存储的模型
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    //添加存储器
    /**
     * type:一般使用数据库存储方式NSSQLiteStoreType
     * configuration:配置信息  一般无需配置
     * URL:要保存的文件路径
     * options:参数信息 一般无需设置
     */
    
    //拼接url路径
    NSURL *url = [[self getDocumentUrlPath] URLByAppendingPathComponent:@"sqlit.db" isDirectory:YES];
    
    [PTStashFiles twoStashFilesMethodsTest];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption , nil];//添加的字典
    [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:nil];
    
    return _persistentStoreCoordinator;
}

- (void)save
{
    [PTStashFiles twoStashFilesMethodsTest]; 
    [self.managedObjectContext save:nil];
}

@end
