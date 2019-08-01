//
//  SXWMarqueeView.h
//  SXWTest
//
//  Created by 聚米 on 2018/7/30.
//  Copyright © 2018年 聚米 . All rights reserved.
//  跑马灯View

#import <UIKit/UIKit.h>

@interface SXWMarqueeView : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title;//构造方法
- (void)start;//开始跑马
- (void)stop;//停止跑马

@end
