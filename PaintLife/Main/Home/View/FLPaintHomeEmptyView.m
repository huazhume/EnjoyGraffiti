//
//  FLPaintHomeEmptyView.m
//  PaintLife
//
//  Created by xiaobai zhang on 2020/8/9.
//  Copyright © 2020年 xiaobai zhang. All rights reserved.
//

#import "FLPaintHomeEmptyView.h"

@interface FLPaintHomeEmptyView ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation FLPaintHomeEmptyView

+ (instancetype)loadFromNib
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"FLPaintHomeEmptyView" owner:nil options:nil];
    if (views && views.count > 0) {
        return [views firstObject];
    }
    return nil;
}

+ (CGFloat)viewHeight
{
    return 200.f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.contentView.layer.cornerRadius = 10.f;
    self.contentView.layer.masksToBounds = YES;
    
    self.contentView.layer.borderColor = [[UIColor colorWithHex:0xC496C5] CGColor];
    self.contentView.layer.borderWidth = 0.5;
}


- (IBAction)noteButtonClicked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emptyNoteAction)]) {
        [self.delegate emptyNoteAction];
    }
}

@end
