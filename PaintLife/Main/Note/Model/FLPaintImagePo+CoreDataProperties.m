//
//  FLPaintImagePo+CoreDataProperties.m
//  
//
//  Created by xiaobai zhang on 2020/8/9.
//
//

#import "FLPaintImagePo+CoreDataProperties.h"

@implementation FLPaintImagePo (CoreDataProperties)

+ (NSFetchRequest<FLPaintImagePo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FLPaintImagePo"];
}

@dynamic width;
@dynamic height;
@dynamic path;
@dynamic sortIndex;
@dynamic noteId;

@end
