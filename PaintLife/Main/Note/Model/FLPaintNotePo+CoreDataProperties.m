//
//  FLPaintNotePo+CoreDataProperties.m
//
//
//  Created by xiaobai zhang on 2019/3/26.
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
