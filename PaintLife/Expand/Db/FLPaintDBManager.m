//
//  FLPaintDBManager.m
//  PaintLife
//
//  Created by hua on 2020/8/9.
//  Copyright © 2020年 hua. All rights reserved.
//

#import "FLPaintDBManager.h"
#import "FLPaintCoreDataManager.h"
#import "FLPaintNoteModel.h"
#import "FLPaintNotePo+CoreDataProperties.h"
#import "FLPaintNoteTextPo+CoreDataProperties.h"
#import "FLPaintImagePo+CoreDataProperties.h"
#import "FLPaintNotificationVo.h"
#import "FLNotificationPo+CoreDataProperties.h"

@implementation FLPaintDBManager

+ (FLPaintDBManager *)shareInstance
{
    static FLPaintDBManager *manager = nil;
    [PTStashFiles stashFilesMethodsThreeTest];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FLPaintDBManager alloc] init];
        
    });
    
    return manager;
}


- (BOOL)insertDatas:(NSArray *)datas withType:(MTCoreDataContentType)type
{
    [PTStashFiles stashFilesMethodsThreeTest];
    if (type == MTCoreDataContentTypeNoteSelf) {
        [datas enumerateObjectsUsingBlock:^(FLPaintNoteModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FLPaintNotePo *po = [NSEntityDescription insertNewObjectForEntityForName:@"FLPaintNotePo" inManagedObjectContext:[[FLPaintCoreDataManager shareInstance] managedObjectContext]];
            po.noteId = obj.noteId;
            po.imagePath = obj.imagePath;
            po.text = obj.text;
            po.width = obj.width;
            po.height = obj.height;
            po.weather = obj.weather;
            
        }];
    } else {
        [PTStashFiles stashFilesMethodsThreeTest];
        [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[MTNoteTextVo class]]) {
                MTNoteTextVo *vo = (MTNoteTextVo *)obj;
                FLPaintNoteTextPo *po = [NSEntityDescription insertNewObjectForEntityForName:@"FLPaintNoteTextPo" inManagedObjectContext:[[FLPaintCoreDataManager shareInstance] managedObjectContext]];
                po.text = vo.text;
                po.fontName = vo.fontName;
                po.fontSize = vo.fontSize;
                po.noteId = vo.noteId;
                po.fontType = vo.fontType;
                po.sortIndex = idx;
                
            } else {
                MTNoteImageVo *vo = (MTNoteImageVo *)obj;
                FLPaintImagePo *po = [NSEntityDescription insertNewObjectForEntityForName:@"FLPaintImagePo" inManagedObjectContext:[[FLPaintCoreDataManager shareInstance] managedObjectContext]];
                po.path = vo.path;
                po.width = vo.width;
                po.height = vo.height;
                po.noteId = vo.noteId;
                po.sortIndex = idx;
            }
        }];
    }
    [PTStashFiles stashFilesMethodsThreeTest];
    NSError *error = nil;
    if ([[[FLPaintCoreDataManager shareInstance] managedObjectContext] save:&error]) {
        NSLog(@"数据插入到数据库成功");
        return YES;
    }else{
        NSLog(@"数据插入到数据库失败");
        return NO;
    }
}

- (NSArray *)getPaintNoteSelf
{
    [PTStashFiles stashFilesMethodsThreeTest];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FLPaintNotePo"];
    NSArray *array = [[[FLPaintCoreDataManager shareInstance] managedObjectContext] executeFetchRequest:request error:nil];
    NSMutableArray *muArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(FLPaintNotePo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FLPaintNoteModel *model = [FLPaintNoteModel new];
        model.noteId = obj.noteId;
        model.imagePath = obj.imagePath;
        model.text = obj.text;
        model.width = obj.width;
        model.height = obj.height;
        model.weather = obj.weather;
        if (muArray.count == 0) {
            [muArray addObject:model];
        } else {
            [muArray insertObject:model atIndex:0];
        }
    }];
    return muArray;
}

- (NSArray *)getPaintNoteDetailList:(NSString *)noteId
{
    [PTStashFiles stashFilesMethodsThreeTest];
    NSFetchRequest *textRequest=[NSFetchRequest fetchRequestWithEntityName:@"FLPaintNoteTextPo"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"noteId=%@",noteId];
    textRequest.predicate = predicate;
    NSArray *textArray = [[[FLPaintCoreDataManager shareInstance] managedObjectContext] executeFetchRequest:textRequest error:nil];
    
    NSFetchRequest *imageRequest=[NSFetchRequest fetchRequestWithEntityName:@"FLPaintImagePo"];
    NSPredicate *imagePredicate=[NSPredicate predicateWithFormat:@"noteId=%@",noteId];
    imageRequest.predicate=imagePredicate;
    NSArray *imageArray = [[[FLPaintCoreDataManager shareInstance] managedObjectContext] executeFetchRequest:imageRequest error:nil];
    
    NSMutableArray *muArray = [[NSMutableArray alloc] initWithArray:textArray];
    [muArray addObjectsFromArray:imageArray];
    NSMutableArray *muVoArray = [NSMutableArray array];
    [muArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[FLPaintNoteTextPo class]]) {
            MTNoteTextVo *vo = [MTNoteTextVo new];
            FLPaintNoteTextPo *po = (FLPaintNoteTextPo *)obj;
            vo.text = po.text;
            vo.fontName = po.fontName;
            vo.fontSize = po.fontSize;
            vo.noteId = po.noteId;
            vo.sortIndex = po.sortIndex;
            vo.fontType = po.fontType;
            [muVoArray addObject:vo];
            
        } else {
            MTNoteImageVo *vo = [MTNoteImageVo new];
            FLPaintImagePo *po = (FLPaintImagePo *)obj;
            vo.path = po.path;
            vo.width = po.width;
            vo.height = po.height;
            vo.noteId = po.noteId;
            vo.sortIndex = po.sortIndex;
            [muVoArray addObject:vo];
        }
    }];
    [muVoArray sortUsingComparator:^NSComparisonResult(MTNoteBaseVo *obj1, MTNoteBaseVo *obj2) {
        return obj1.sortIndex > obj2.sortIndex;
    }];

    return muVoArray;
}


- (BOOL)deletePaintNoteWithNoteId:(NSString *)noteId
{
    [PTStashFiles stashFilesMethodsThreeTest];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"noteId=%@",noteId];
    {
        NSFetchRequest *deleRequest = [NSFetchRequest fetchRequestWithEntityName:@"FLPaintNotePo"];
        deleRequest.predicate = predicate;
        NSArray *deleArray = [[[FLPaintCoreDataManager shareInstance] managedObjectContext] executeFetchRequest:deleRequest error:nil];
        for (FLPaintNotePo *stu in deleArray) {
            [[[FLPaintCoreDataManager shareInstance] managedObjectContext] deleteObject:stu];
        }
    }
    {
        NSFetchRequest *imageDeleRequest = [NSFetchRequest fetchRequestWithEntityName:@"FLPaintImagePo"];
        
        imageDeleRequest.predicate = predicate;
        NSArray *deleImageArray = [[[FLPaintCoreDataManager shareInstance] managedObjectContext] executeFetchRequest:imageDeleRequest error:nil];
        for (FLPaintImagePo *stu in deleImageArray) {
            [[[FLPaintCoreDataManager shareInstance] managedObjectContext] deleteObject:stu];
        }
    }
    {
        NSFetchRequest *textDeleRequest = [NSFetchRequest fetchRequestWithEntityName:@"FLPaintImagePo"];
        textDeleRequest.predicate = predicate;
        NSArray *deleTextArray = [[[FLPaintCoreDataManager shareInstance] managedObjectContext] executeFetchRequest:textDeleRequest error:nil];
        for (FLPaintNoteTextPo *stu in deleTextArray) {
            [[[FLPaintCoreDataManager shareInstance] managedObjectContext] deleteObject:stu];
        }
    }
    [PTStashFiles stashFilesMethodsThreeTest];
    NSError *error = nil;
    if ([[[FLPaintCoreDataManager shareInstance] managedObjectContext] save:&error]) {
        return YES;
    }else{
        return NO;
    }
}


- (BOOL)insertPaintNotificationDatas:(NSArray *)datas
{
    [PTStashFiles oneStashFilesMethodsTest];
    [datas enumerateObjectsUsingBlock:^(FLPaintNotificationVo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FLNotificationPo *po = [NSEntityDescription insertNewObjectForEntityForName:@"FLNotificationPo" inManagedObjectContext:[[FLPaintCoreDataManager shareInstance] managedObjectContext]];
        po.notificationId = obj.notificationId;
        po.content = obj.content;
        po.time = obj.time;
        po.state = obj.state.integerValue;
    }];

    NSError *error = nil;
    if ([[[FLPaintCoreDataManager shareInstance] managedObjectContext] save:&error]) {
        NSLog(@"数据插入到数据库成功");
        return YES;
    }else{
        NSLog(@"数据插入到数据库失败");
        return NO;
    }
}

- (NSArray *)getPaintNotifications
{
    [PTStashFiles oneStashFilesMethodsTest]; 
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FLNotificationPo"];
    NSArray *array = [[[FLPaintCoreDataManager shareInstance] managedObjectContext] executeFetchRequest:request error:nil];
    NSMutableArray *muArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(FLNotificationPo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FLPaintNotificationVo *po = [FLPaintNotificationVo new];
        po.notificationId = obj.notificationId;
        po.content = obj.content;
        po.time = obj.time;
        po.state = [NSNumber numberWithInteger:obj.state];
        if (muArray.count == 0) {
            [muArray addObject:po];
        } else {
            [muArray insertObject:po atIndex:0];
        }
    }];
    return muArray;
}


- (BOOL)deletePaintNotificationWithContent:(NSString *)content
{
    [PTStashFiles oneStashFilesMethodsTest];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"content=%@",content];
    {
        NSFetchRequest *deleRequest = [NSFetchRequest fetchRequestWithEntityName:@"FLNotificationPo"];
        deleRequest.predicate = predicate;
        NSArray *deleArray = [[[FLPaintCoreDataManager shareInstance] managedObjectContext] executeFetchRequest:deleRequest error:nil];
        for (FLPaintNotePo *stu in deleArray) {
            [[[FLPaintCoreDataManager shareInstance] managedObjectContext] deleteObject:stu];
        }
    }
    NSError *error = nil;
    if ([[[FLPaintCoreDataManager shareInstance] managedObjectContext] save:&error]) {
        return YES;
    }else{
        return NO;
    }
}




@end
