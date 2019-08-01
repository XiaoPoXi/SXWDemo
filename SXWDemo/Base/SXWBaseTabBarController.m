//
//  SXWBaseTabBarController.m
//  SXWDemo
//
//  Created by JM001 on 2019/1/2.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "SXWBaseTabBarController.h"
#import "SXWBaseNavigationViewController.h"
#import "SXWHomeViewController.h"
#import "SXWSecondViewController.h"
#import "SXWThirdViewController.h"
#import "SXWMineViewController.h"


@interface SXWBaseTabBarController ()

@end

@implementation SXWBaseTabBarController

- (instancetype)init
{
    if (self = [super init])
    {
//        if (kDevice_Is_iPhoneX)
//        {
//            YUBaseTabBar *baseTabBar = [[YUBaseTabBar alloc] init];
//            [self setValue:baseTabBar forKey:@"tabBar"];
//        }
        //创建tabbar
        NSMutableArray * navigationControllers = [[NSMutableArray alloc] init];
        //首页
   
        SXWHomeViewController * homeVc = [[SXWHomeViewController alloc] init];
        SXWBaseNavigationViewController * homeNav = [[SXWBaseNavigationViewController alloc] initWithRootViewController:homeVc];
        homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"ho"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"ho_sele"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [navigationControllers addObject:homeNav];
   
        SXWSecondViewController * secondViewController = [[SXWSecondViewController alloc] init];
        SXWBaseNavigationViewController * secondViewControllerNav = [[SXWBaseNavigationViewController alloc] initWithRootViewController:secondViewController];
        secondViewControllerNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"朋友" image:[[UIImage imageNamed:@"sh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"sh_sele"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [navigationControllers addObject:secondViewControllerNav];
        
        SXWThirdViewController * thirdViewController = [[SXWThirdViewController alloc] init];
        SXWBaseNavigationViewController * thirdViewControllerNav = [[SXWBaseNavigationViewController alloc] initWithRootViewController:thirdViewController];
        thirdViewControllerNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[[UIImage imageNamed:@"sh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"sh_sele"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [navigationControllers addObject:thirdViewControllerNav];
        
        SXWMineViewController * mineViewController = [[SXWMineViewController alloc] init];
        SXWBaseNavigationViewController * mineViewControllerNav = [[SXWBaseNavigationViewController alloc] initWithRootViewController:mineViewController];
        mineViewControllerNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"per"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"per_sele"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [navigationControllers addObject:mineViewControllerNav];
        
        self.viewControllers = navigationControllers;
        
        //设置字体颜色
        //未选中时
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:JMColor(155, 155, 155),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        //选中时
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:JMColor(255, 98, 146),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        self.tabBar.translucent = NO;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
