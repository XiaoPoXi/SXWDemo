//
//  SXWMainViewController.m
//  SXWDemo
//
//  Created by JM001 on 2019/1/2.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "SXWMainViewController.h"
#import "SXWBaseTabBarController.h"

@interface SXWMainViewController ()

@property (nonatomic,strong) SXWBaseTabBarController * tabBarController;

@end

@implementation SXWMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createViewControllers];
}
- (void)createViewControllers
{
    if (!self.tabBarController)
    {
        self.tabBarController = [[SXWBaseTabBarController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = self.tabBarController;
    }
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
