//
//  SXWPersonalCenterOrderFootView.m
//  SXWDemo
//
//  Created by XiaoXi on 2019/7/27.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "SXWPersonalCenterOrderFootView.h"

@interface SXWPersonalCenterOrderFootView()

@end

@implementation SXWPersonalCenterOrderFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = JMCOLOR248;
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    UIView *yellowView = [UIView new];
    yellowView.frame = CGRectMake(20 *kScale, 0, kScreenWidth - 40 *kScale, 140 *kScale);
    yellowView.backgroundColor = JMColor(247, 232, 208);
    yellowView.layer.masksToBounds = YES;
//    yellowView.layer.cornerRadius = 8 *kScale;
    [self addSubview:yellowView];
//    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.left.equalTo(self.mas_left).offset(20 *kScale);
//        make.right.equalTo(self.mas_right).offset(- 20 *kScale);
//        make.height.mas_equalTo(140 *kScale);
//    }];
//    [yellowView layoutIfNeeded];
    [self setView:yellowView addCornerRadius:24 *kScale addRectCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];

    
}

/**
 * setCornerRadius   给view设置圆角
 * @param value      圆角大小
 * @param rectCorner 圆角位置
 UIRectCornerTopLeft     = 1 << 0,
 UIRectCornerTopRight    = 1 << 1,
 UIRectCornerBottomLeft  = 1 << 2,
 UIRectCornerBottomRight = 1 << 3,
 **/


- (void)setView:(UIView *)view addCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    view.layer.mask = shapeLayer;
}


- (void)setObject:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = object;
        
    }
}

@end
