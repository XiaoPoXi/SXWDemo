//
//  SXWSlider.m
//  SXWDemo
//
//  Created by XiaoXi on 2019/8/1.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "SXWSlider.h"

@implementation SXWSlider

// 控制slider的宽和高，这个方法才是真正的改变slider滑道的高的
- (CGRect)trackRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0,kScreenWidth-2* 22.5 *kScale, 10 *kScale);
}




- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    rect.origin.x = rect.origin.x - 12 ;
    rect.size.width = rect.size.width +20;
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 10 , 10);
}

@end
