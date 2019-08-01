//
//  SXWPersonalNewHeadCollectionViewCell.m
//  SXWDemo
//
//  Created by XiaoXi on 2019/7/24.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "SXWPersonalNewHeadCollectionViewCell.h"

@interface SXWPersonalNewHeadCollectionViewCell()

@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,strong) UILabel *contentLabel;

@end

@implementation SXWPersonalNewHeadCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    self.numberLabel = [UILabel new];
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.font = Font(32);
    [self addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(20 *kScale);
    }];
    
    self.contentLabel = [UILabel new];
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.font = Font(24);
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.numberLabel.mas_bottom).offset(25 *kScale);
    }];
    
}

- (void)setObject:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = object;
        
        self.numberLabel.text = dict[@"number"];
        self.contentLabel.text = dict[@"content"];
    }
}

@end
