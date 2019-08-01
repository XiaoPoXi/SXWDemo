//
//  SXWHomeCollectionHeaderReusableView.h
//  SXWTest
//
//  Created by 聚米 on 2018/5/9.
//  Copyright © 2018年 聚米 . All rights reserved.
//

//轮播图点击
typedef void(^BannerBlock)(NSInteger index);

#import <UIKit/UIKit.h>

@interface SXWHomeCollectionHeaderReusableView : UICollectionReusableView

@property (nonatomic,strong) BannerBlock banner_block;

@end
