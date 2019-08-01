//
//  SXWImagePickCollectionViewCell.m
//  SXWDemo
//
//  Created by JM001 on 2019/6/24.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "SXWImagePickCollectionViewCell.h"

@implementation SXWImagePickCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.contentImageView = [[UIImageView alloc] init];
        self.contentImageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        self.contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.contentImageView.userInteractionEnabled = YES;
        self.contentImageView.layer.masksToBounds = YES;
        self.contentImageView.layer.cornerRadius = 8 *kScale;
        [self addSubview:self.contentImageView];
        [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.width.height.mas_equalTo(220 *kScale);
        }];
        
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [self.deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentImageView addSubview:self.deleteBtn];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentImageView.mas_right).offset(- 2 *kScale);
            make.top.equalTo(self.contentImageView.mas_top).offset(2 *kScale);
            make.width.height.mas_equalTo(40 *kScale);
        }];

    }
    return self;
}

- (void)deleteAction:(UIButton *)sender
{
    if (self.deleteButtonClickBlock)
    {
        self.deleteButtonClickBlock(sender.tag);
    }
}


- (void)setAsset:(PHAsset *)asset
{
    _asset = asset;

}

- (void)setRow:(NSInteger)row
{
    _row = row;
    _deleteBtn.tag = row;
}

- (UIView *)snapshotView
{
    UIView *snapshotView = [[UIView alloc]init];
    
    UIView *cellSnapshotView = nil;
    
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)])
    {
        cellSnapshotView = [self snapshotViewAfterScreenUpdates:NO];
    }
    else
    {
        CGSize size = CGSizeMake(self.bounds.size.width + 20, self.bounds.size.height + 20);
        UIGraphicsBeginImageContextWithOptions(size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * cellSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cellSnapshotView = [[UIImageView alloc]initWithImage:cellSnapshotImage];
    }
    
    snapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    cellSnapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    
    [snapshotView addSubview:cellSnapshotView];
    return snapshotView;
}


@end
