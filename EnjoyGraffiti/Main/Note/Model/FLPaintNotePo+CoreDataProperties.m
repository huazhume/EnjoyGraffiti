//
//  FLPaintNotePo+CoreDataProperties.m
//
//
//  Created by hua on 2020/3/26.
//
//

#import "FLPaintNotePo+CoreDataProperties.h"

@implementation FLPaintNotePo (CoreDataProperties)

+ (NSFetchRequest<FLPaintNotePo *> *)fetchRequest {
    return [NSFetchRequest fetchRequestWithEntityName:@"FLPaintNotePo"];
}

@dynamic height;
@dynamic imagePath;
@dynamic noteId;
@dynamic text;
@dynamic width;
@dynamic weather;

@end
