//
//  TransverseImageView.h
//  SXWDemo
//
//  Created by JM001 on 2019/6/27.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//  横向图片选择View

#import <UIKit/UIKit.h>

@protocol ImagePickerViewDelegatesss <NSObject>

@optional

- (void)imagePickerView:(UIView *)view didFinishPickPhoto:(NSArray<UIImage *> *)photos;

@end

@interface TransverseImagesPickView : UIView

@property (nonatomic, weak)id<ImagePickerViewDelegatesss>delegate;

/*
 count 最大可选图片数量
 num   每行展示的图片数量
 */
- (instancetype)initWithFrame:(CGRect)frame andMaxImages:(NSInteger )count imagesNumPerRow:(NSInteger )num;

@end


//获取视图所在控制器的扩展
@interface UIView (Extend)

- (UIViewController *)viewController;

@end

