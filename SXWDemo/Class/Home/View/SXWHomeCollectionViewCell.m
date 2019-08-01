//
//  SXWHomeCollectionViewCell.m
//  SXWTest
//
//  Created by 聚米 on 2018/5/9.
//  Copyright © 2018年 聚米 . All rights reserved.
//

#import "SXWHomeCollectionViewCell.h"
#import "SXWHomeModel.h"

@interface SXWHomeCollectionViewCell ()


@property (nonatomic,strong) UIView * absview;//
@property (nonatomic,strong) UILabel * numbersLabel;//


@end

@implementation SXWHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 12 *kScale;
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    self.absview = [UIView new];
    [self.absview setBackgroundColor:RandomColor];
    [self.contentView addSubview:self.absview];
    [self.absview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width,self.frame.size.width));
    }];
    
    self.numbersLabel = [UILabel new];
    self.numbersLabel.textAlignment = NSTextAlignmentCenter;
    self.numbersLabel.textColor = RandomColor;
    self.numbersLabel.font = [UIFont systemFontOfSize:28 *kScale];
    [self.contentView addSubview:self.numbersLabel];
    [self.numbersLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(self.absview.mas_centerX);
        make.top.equalTo(self.absview.mas_bottom).offset(20 *kScale);
        make.height.mas_equalTo(30 *kScale);
    }];
    

    
    
}



- (void)setObject:(id)object
{
    
    if ([object isKindOfClass:[NSString class]])
    {
        NSString *name = object;
        self.numbersLabel.text = name;
    }
}


@end
