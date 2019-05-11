//
//  FLPaintFeedSectionView.h
//  finbtc
//
//  Created by xiaobai zhang on 2020/1/16.
//  Copyright © 2020 MTY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FLPaintFeedSectionViewDelegate <NSObject>

@optional

//点击说明
- (void)marketSectionInfomationAction;

//电击更多
- (void)marketSectionMoreAction;

@end

@interface FLPaintFeedSectionView : UIView

@property (weak, nonatomic) id <FLPaintFeedSectionViewDelegate> delegate;

//是否显示说明按钮 默认隐藏
@property (assign, nonatomic) BOOL isShowInfomation;

/**
 赋值
 @param title 标题
 @param desc 右侧更多按钮描述
 */
- (void)setTitle:(NSString *)title desc:(NSString *)desc;

@end

NS_ASSUME_NONNULL_END
