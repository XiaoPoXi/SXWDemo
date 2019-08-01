//
//  SXWPersonalCenterOrderCollectionViewCell.m
//  SXWDemo
//
//  Created by XiaoXi on 2019/7/25.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "SXWPersonalCenterOrderCollectionViewCell.h"

@interface SXWPersonalCenterOrderCollectionViewCell()

@property (nonatomic,strong) UIImageView *contentImageView;
@property (nonatomic,strong) UILabel *contentLabel;

@end

@implementation SXWPersonalCenterOrderCollectionViewCell

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
    self.contentImageView = [UIImageView new];
    [self addSubview:self.contentImageView];
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(20 *kScale);
        make.width.height.mas_equalTo(44 *kScale);
    }];
    
    self.contentLabel = [UILabel new];
    self.contentLabel.textColor = JMCOLOR51;
    self.contentLabel.font = Font(30);
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(- 20 *kScale);
    }];
    
}

- (void)setObject:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = object;
        self.contentImageView.image = [UIImage imageNamed:dict[@"image"]];
        self.contentLabel.text = dict[@"title"];
    }
}


@end
