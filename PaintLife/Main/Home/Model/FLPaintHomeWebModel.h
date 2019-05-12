//
//  FLPaintHomeWebModel.h
//  PaintLife
//
//  Created by hua on 2020/3/18.
//  Copyright © 2020年 hua. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLPaintHomeWebModel : NSObject

@property (copy, nonatomic) NSString *PushKey;

@property (assign, nonatomic) BOOL ShowWeb;

@property (copy, nonatomic) NSString *Url;

@property (assign, nonatomic) BOOL success;

@end

NS_ASSUME_NONNULL_END
