//
//  SXWBaseViewController.m
//  SXWDemo
//
//  Created by JM001 on 2018/12/24.
//  Copyright © 2018 Xiaopoxi. All rights reserved.
//

#import "SXWBaseViewController.h"

@interface SXWBaseViewController ()

@end

@implementation SXWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //导航栏返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
}

#pragma mark - 触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //触摸收回键盘
    [self.view endEditing:YES];
}

@end
