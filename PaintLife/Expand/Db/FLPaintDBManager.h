//
//  FLPaintDBManager.h
//  PaintLife
//
//  Created by xiaobai zhang on 2018/8/9.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MTCoreDataContentTypeNoteSelf,
    MTCoreDataContentTypeNoteContent,
} MTCoreDataContentType;

@interface FLPaintDBManager : NSObject

- (BOOL)insertDatas:(NSArray *)datas withType:(MTCoreDataContentType)type;

- (NSArray *)getPaintNoteSelf;

- (NSArray *)getPaintNoteDetailList:(NSString *)noteId;

- (BOOL)deletePaintNoteWithNoteId:(NSString *)noteId;

- (BOOL)insertPaintNotificationDatas:(NSArray *)datas;

- (NSArray *)getPaintNotifications;

- (BOOL)deletePaintNotificationWithContent:(NSString *)content;


+ (FLPaintDBManager *)shareInstance;

@end
