//
//  SXWHomeCollectionFooterrReusableView.m
//  SXWTest
//
//  Created by 聚米 on 2018/5/9.
//  Copyright © 2018年 聚米 . All rights reserved.
//

#import "SXWHomeCollectionFooterrReusableView.h"
#import "SXWMarqueeView.h"//跑马灯

@interface SXWHomeCollectionFooterrReusableView ()

@end

@implementation SXWHomeCollectionFooterrReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RandomColor;
        [self drawMarqueeView];
    }
    return self;
}
- (void)drawMarqueeView
{
    NSString *title = @"两块钱,你买不了吃亏,两块钱,你买不了上当,真正的物有所值,拿啥啥便宜,买啥啥不贵,都两块,买啥都两块,全场卖两块,随便挑,随便选,都两块！ ";
    SXWMarqueeView *MarqueeView = [[SXWMarqueeView alloc] initWithFrame:CGRectMake(0, 40 *kScale, kScreenWidth, 60 *kScale) title:title];
    [self addSubview:MarqueeView];
}



@end
