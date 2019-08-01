//
//  SXWToolServeCollectionViewCell.m
//  SXWDemo
//
//  Created by XiaoXi on 2019/7/25.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "SXWToolServeCollectionViewCell.h"

@interface SXWToolServeCollectionViewCell()

@property (nonatomic,strong) UIImageView *contentImageView;
@property (nonatomic,strong) UILabel *contentLabel;

@end


@implementation SXWToolServeCollectionViewCell

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
    self.contentLabel.font = Font(24);
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.contentImageView.mas_bottom).offset(27 *kScale);
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
