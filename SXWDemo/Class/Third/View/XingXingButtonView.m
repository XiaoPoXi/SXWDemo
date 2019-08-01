//
//  XingXingButtonView.m
//  SXWDemo
//
//  Created by JM001 on 2019/3/21.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "XingXingButtonView.h"

@interface XingXingButtonView()

@property (nonatomic,strong) UILabel *leftLabel;

@end

@implementation XingXingButtonView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    self.leftLabel= [UILabel new];
    self.leftLabel.text = @"";
    self.leftLabel.font = [UIFont systemFontOfSize:28 *kScale];
    self.leftLabel.textColor = JMCOLOR51;
    [self addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(30 *kScale);
    }];
    
    
}


@end
