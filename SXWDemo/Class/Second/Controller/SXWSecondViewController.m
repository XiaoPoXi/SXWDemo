//
//  SXWSecondViewController.m
//  SXWDemo
//
//  Created by JM001 on 2018/12/26.
//  Copyright © 2018 Xiaopoxi. All rights reserved.
//

#import "SXWSecondViewController.h"
#import "SXWPersonalNewHeadView.h"
#import "SXWPersonalCenterOrderTableViewCell.h"//我的订单cell
#import "SXWPersonalCenterSectionHeadView.h"//我的订单section head
#import "SXWToolServeTableViewCell.h"//工具服务cell
#import "SXWToolServeSectionHeadView.h"//工具服务headView

#import "SXWPersonalCenterOrderFootView.h"//订单下面物流信息footerView

@interface SXWSecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray * tableArray;
@property (nonatomic,strong) SXWPersonalNewHeadView * headerView;//头部视图

@property (nonatomic,strong) UIView * navigationView;
@property (nonatomic,strong) UIButton * messageButton;//
@property (nonatomic,strong) UIButton * seetingButton;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIButton * moreButton;

@end

@implementation SXWSecondViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的";
    [self addSubViews];
}

- (void)addSubViews
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    if (@available(iOS 11.0, *))
    {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = JMCOLOR248;
    //设置预滑动，防止抖动
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[SXWPersonalCenterOrderTableViewCell class] forCellReuseIdentifier:@"SXWPersonalCenterOrderTableViewCell"];
    [self.tableView registerClass:[SXWToolServeTableViewCell class] forCellReuseIdentifier:@"SXWToolServeTableViewCell"];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.equalTo(self.view);
     }];
    
    self.headerView = [[SXWPersonalNewHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 480 *kScale +158 *kScale +20 *kScale)];
    self.tableView.tableHeaderView = self.headerView;
    [self.headerView setObject:@{}];
    [self.tableView layoutIfNeeded];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRefrsh)];
    
    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height)];
    _navigationView.backgroundColor = kRGBA(255, 255, 255, 0);

    self.messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.messageButton setBackgroundImage:[UIImage imageNamed:@"personal_message"] forState:UIControlStateNormal];
    [self.messageButton setBackgroundImage:[UIImage imageNamed:@"personal_message"] forState:UIControlStateHighlighted];
    [_navigationView addSubview:self.messageButton];
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.and.height.mas_equalTo(44 * kScale);
         make.right.equalTo(self.navigationView.mas_right).offset(- 100 * kScale);
         make.bottom.equalTo(self.navigationView.mas_bottom).offset(-30 * kScale);
     }];
    
    self.seetingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.seetingButton setBackgroundImage:[UIImage imageNamed:@"personal_seeting"] forState:UIControlStateNormal];
    [self.seetingButton setBackgroundImage:[UIImage imageNamed:@"personal_seeting"] forState:UIControlStateHighlighted];
    [_navigationView addSubview:self.seetingButton];
    [self.seetingButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.and.height.mas_equalTo(44 * kScale);
         make.right.equalTo(self.navigationView.mas_right).offset(- 24 * kScale);
         make.centerY.equalTo(self.messageButton.mas_centerY);
     }];

    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"我的";
    self.titleLabel.font = Font(30);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = JMCOLOR51;
    [_navigationView addSubview:self.titleLabel];
    self.titleLabel.alpha = 0;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.and.right.equalTo(self.navigationView);
         make.centerY.equalTo(self.seetingButton.mas_centerY);
     }];
    
    [self.view addSubview:self.navigationView];
}
//下拉刷新
- (void)loadRefrsh
{
    [self.tableView.mj_header endRefreshing];
}

#pragma mark *************************************************TableView协议方法********************************************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        SXWPersonalCenterOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SXWPersonalCenterOrderTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.section == 1)
    {
        SXWToolServeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SXWToolServeTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 200 *kScale;
    }
    if (indexPath.section == 1)
    {
        return 400 *kScale;
    }
    return 0.01;
}
#pragma mark ******* 返回每个Section头部视图UIView *******
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        SXWPersonalCenterSectionHeadView *headView = [[SXWPersonalCenterSectionHeadView alloc] init];
        [headView setObject:@{@"left":@"我的订单"}];
        return headView;
        
    }
    if (section == 1)
    {
        SXWToolServeSectionHeadView *headView = [[SXWToolServeSectionHeadView alloc] init];
        [headView setObject:@{@"left":@"工具服务"}];
        return headView;
    }
    return nil;
}
#pragma mark ******* 返回每个Section尾部视图UIView *******
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        SXWPersonalCenterOrderFootView *headView = [[SXWPersonalCenterOrderFootView alloc] init];
        [headView setObject:@{}];
        return headView;
        
    }
    return nil;
}
#pragma mark ******* 返回每个Section头部视图高度 *********
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 80 *kScale;
    }
    if (section == 1)
    {
        return 80 *kScale;
    }
    return 0.01;
}
#pragma mark ***** 返回每个Section尾部视图UIView的高度 ****
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 140 *kScale +30 *kScale;
    }
    return 0.01;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //初始值-20,往上滑 > -20;
    CGFloat alpha;
    //这里的300意思是滑动300距离的时候完全不透明，可以调节
    CGFloat offsetY = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    CGPoint point = self.tableView.contentOffset;
    alpha =  point.y/offsetY;
    alpha = (alpha <= 0) ? 0 : alpha;
    alpha = (alpha >= 1) ? 1 : alpha;
    if (alpha < 0.5)
    {
        //展示白色的按钮
        [self.seetingButton setBackgroundImage:[UIImage imageNamed:@"personal_seeting"] forState:UIControlStateNormal];
        [self.seetingButton setBackgroundImage:[UIImage imageNamed:@"personal_seeting"] forState:UIControlStateHighlighted];
        [self.messageButton setBackgroundImage:[UIImage imageNamed:@"personal_message"] forState:UIControlStateNormal];
        [self.messageButton setBackgroundImage:[UIImage imageNamed:@"personal_message"] forState:UIControlStateHighlighted];
//        self.navigationView.frame = CGRectMake(0, 20, kScreenWidth, [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height);

    }
    else
    {
        //展示黑色的按钮
        [self.seetingButton setBackgroundImage:[UIImage imageNamed:@"personal_seeting_black"] forState:UIControlStateNormal];
        [self.seetingButton setBackgroundImage:[UIImage imageNamed:@"personal_seeting_black"] forState:UIControlStateHighlighted];
        [self.messageButton setBackgroundImage:[UIImage imageNamed:@"personal_message_black"] forState:UIControlStateNormal];
        [self.messageButton setBackgroundImage:[UIImage imageNamed:@"personal_message_black"] forState:UIControlStateHighlighted];
//        self.navigationView.frame = CGRectMake(0, 0, kScreenWidth, [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height);

    }
    self.navigationView.backgroundColor = kRGBA(255, 255, 255, alpha);
    self.titleLabel.alpha = alpha;

}

@end
