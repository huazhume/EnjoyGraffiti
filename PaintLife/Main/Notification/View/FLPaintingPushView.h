//
//  FLPaintingPushView.h
//  finbtc
//
//  Created by hua on 2020/7/31.
//  Copyright © 2020年 MTY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EBCustomBannerView;
@class FLPaintNotificationVo;

typedef void(^Callback)(void);

@interface FLPaintingPushView : UIView

@property (nonatomic, weak) EBCustomBannerView *customView;

@property (nonatomic, copy) Callback callback;

@property (nonatomic, strong) FLPaintNotificationVo *model;

+ (CGFloat)heightForViewWithContent:(NSString *)content;



@end
