//
//  SXWImagePickCollectionViewCell.h
//  SXWDemo
//
//  Created by JM001 on 2019/6/24.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteButtonClickBlock)(NSInteger tag);

//图片选择时cell的展示
@interface SXWImagePickCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;
@property (nonatomic, strong) DeleteButtonClickBlock deleteButtonClickBlock;

- (UIView *)snapshotView;

@end


