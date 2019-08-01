//
//  SXWToolServeSectionHeadView.m
//  SXWDemo
//
//  Created by XiaoXi on 2019/7/27.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "SXWToolServeSectionHeadView.h"

@interface SXWToolServeSectionHeadView()

@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic, strong) UIView *whiteView;

@end

@implementation SXWToolServeSectionHeadView

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
    self.whiteView = [UIView new];
    self.whiteView.frame = CGRectMake(20 *kScale, 0, kScreenWidth - 40 *kScale, 80 *kScale);
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.whiteView];
//    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(20 *kScale);
//        make.right.equalTo(self.mas_right).offset(- 20 *kScale);
//        make.top.bottom.equalTo(self);
//    }];
    [self setView:self.whiteView addCornerRadius:24 *kScale addRectCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
    
    self.leftLabel = [UILabel new];
    [self.whiteView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView.mas_left).offset(30 *kScale);
        make.bottom.equalTo(self.whiteView.mas_bottom);
    }];
    
    self.rightButton = [UIButton new];
    [self.rightButton setTitle:@"查看全部 >" forState:UIControlStateNormal];
    [self.rightButton setTitle:@"查看全部 >" forState:UIControlStateSelected];
    [self.rightButton setTitleColor:JMColor(119, 119, 119) forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = Font(26);
    [self.rightButton addTarget:self action:@selector(ClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteView addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView.mas_right).offset(- 30*kScale);
        make.centerY.equalTo(self.leftLabel.mas_centerY);
        make.width.mas_equalTo(150 *kScale);
    }];
}

/**
 * setCornerRadius   给view设置圆角
 * @param value      圆角大小
 * @param rectCorner 圆角位置
 **/
- (void)setView:(UIView *)view addCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner{
    
    [view layoutIfNeeded];//这句代码很重要，不能忘了
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    view.layer.mask = shapeLayer;
}

- (void)ClickRightButton:(UIButton *)sender
{
    
}

- (void)setObject:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = object;
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:dict[@"left"] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        
        self.leftLabel.attributedText = string;
    }
}


@end
