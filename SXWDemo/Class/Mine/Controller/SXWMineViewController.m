//
//  SXWMineViewController.m
//  SXWDemo
//
//  Created by JM001 on 2018/12/26.
//  Copyright © 2018 Xiaopoxi. All rights reserved.
//

#import "SXWMineViewController.h"
#import "NetWorkNameModel.h"

@interface SXWMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , assign) NSInteger page;//分页
@property (nonatomic , strong)NSMutableArray *tableArray;

@end

@implementation SXWMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.page = 1;
    [self getDataSource];
    self.tableArray = [NSMutableArray array];
    [self drawTableView];
}

- (void)getDataSource
{
    /*
     {"code":200,"msg":"成功!","data":[{"femalename":"你的战场我养猪丶"},{"femalename":"以后不再亏欠你丶"},{"femalename":"把勇气留在家里"},{"femalename":"少年如夢夢如他"},{"femalename":"世间少有痴情女"},{"femalename":"海是倒過來的天//"},{"femalename":"没有温顺的温顺\u0026#;"},{"femalename":"谁都不是谁的错"},{"femalename":"我的兜里木有糖?"},{"femalename":"我的眼里只要你"},{"femalename":"﹏听风唱着╰小情歌∞"},{"femalename":"南风烈酒痴人梦"},{"femalename":"犯二菇涼不憂傷-"},{"femalename":"碎了一地的↘日光"},{"femalename":"半夏微凉"},{"femalename":"半城烟火半城殇″"},{"femalename":"阴天里的向日葵"},{"femalename":"清歌留欢の月竹挽风"},{"femalename":"花开凌乱了他的侧脸ヾ"},{"femalename":"花悦人已憔悴"}]}
     */
    NSString *url = [NSString stringWithFormat:@"https://www.apiopen.top/femaleNameApi?page=%ld",(long)self.page];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [self endRefresh];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"data"];
        NSMutableArray *muArray = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            NetWorkNameModel *model = [[NetWorkNameModel alloc] initWithDict:obj];
            [muArray addObject:model];
        }];
        if (muArray.count < 10)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else
        {
            [self.tableView.mj_footer resetNoMoreData];
        }
        if (self.page == 1)
        {
            [self.tableArray removeAllObjects];
        }
        [self.tableArray addObjectsFromArray:muArray];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        JMLog(@"error %@",error.localizedFailureReason);
    }];
}

- (void)drawTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    if (@available(iOS 11.0, *))
    {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    //设置预滑动，防止抖动
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = NO;//隐藏cell分割线
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left);
         make.top.equalTo(self.view.mas_top);
         make.right.equalTo(self.view.mas_right);
         make.bottom.equalTo(self.view.mas_bottom);
     }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRefrsh)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

/* 下拉刷新 */
- (void)loadRefrsh
{
    self.page = 1;
    [self getDataSource];
}

/* 上拉加载 */
- (void)loadMore
{
    self.page ++;
    [self getDataSource];
}
/* 停止刷新 */
- (void)endRefresh
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

//iphone X 适配
- (void)viewDidLayoutSubviews
{
    if (@available(iOS 11.0, *))
    {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.safeAreaInsets.bottom)];
        view.backgroundColor = [UIColor whiteColor];
        self.tableView.tableFooterView = view;
    }
}
#pragma mark *************************************************TableView协议方法********************************************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NetWorkNameModel *model = self.tableArray[indexPath.section];
    cell.textLabel.text = model.femalename;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60 *kScale;
}

#pragma mark ******* 返回每个Section头部视图UIView *******
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

#pragma mark ******* 返回每个Section尾部视图UIView *******
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark ******* 返回每个Section头部视图高度 *********
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark ***** 返回每个Section尾部视图UIView的高度 ****
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}



@end
