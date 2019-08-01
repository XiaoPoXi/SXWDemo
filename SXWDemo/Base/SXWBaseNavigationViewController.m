//
//  SXWBaseNavigationViewController.m
//  SXWDemo
//
//  Created by JM001 on 2018/12/24.
//  Copyright © 2018 Xiaopoxi. All rights reserved.
//

#import "SXWBaseNavigationViewController.h"

@interface SXWBaseNavigationViewController ()

@end

@implementation SXWBaseNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //更改导航栏颜色
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationBar.translucent = NO;
    //更改返回按钮图片
    UIImage *backButtonImage = [[UIImage imageNamed:@"Back_Chevron"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationBar setBackIndicatorImage:backButtonImage];
    [self.navigationBar setBackIndicatorTransitionMaskImage:backButtonImage];
    
    //更改导航栏字体颜色和大小
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:JMColor(51, 51, 51),NSFontAttributeName:[UIFont systemFontOfSize:36 * kScale]}];
    
}

#pragma mark - 更改状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleDefault;
    
}

@end
