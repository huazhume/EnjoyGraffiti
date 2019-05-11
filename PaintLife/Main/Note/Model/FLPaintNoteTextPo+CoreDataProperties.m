//
//  FLPaintNoteTextPo+CoreDataProperties.m
//
//
//  Created by xiaobai zhang on 2020/3/19.
//
//

#import "FLPaintNoteTextPo+CoreDataProperties.h"

@implementation FLPaintNoteTextPo (CoreDataProperties)

+ (NSFetchRequest<FLPaintNoteTextPo *> *)fetchRequest {
    return [NSFetchRequest fetchRequestWithEntityName:@"FLPaintNoteTextPo"];
}

@dynamic fontName;
@dynamic fontSize;
@dynamic noteId;
@dynamic sortIndex;
@dynamic text;
@dynamic fontType;

@end
