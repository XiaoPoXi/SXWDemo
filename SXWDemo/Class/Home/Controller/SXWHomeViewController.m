//
//  SXWHomeViewController.m
//  SXWDemo
//
//  Created by JM001 on 2018/12/26.
//  Copyright © 2018 Xiaopoxi. All rights reserved.
//

#import "SXWHomeViewController.h"
#import "SXWHomeCollectionViewCell.h"//collectionCell
#import "SXWHomeCollectionHeaderReusableView.h"//collectionHeader
#import "SXWHomeCollectionFooterrReusableView.h"//collectionFooter
#import "SXWMememeWebViewController.h"
#import "ProblemCalculateCoinViewController.h"//硬币问题
#import "SXWH5ViewController.h"//h5
#import "SXWZipArchiveHTMLViewController.h"//解压zip 加载h5
@interface SXWHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) SXWHomeCollectionHeaderReusableView * collectionHeaderReusableView;//collectionView的头部view
@property (nonatomic,strong) SXWHomeCollectionFooterrReusableView * collectionFooterReusableView;//collectionView的尾部view
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic,strong) NSMutableArray * collectionArray;//collectionView数据源
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation SXWHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    [self initDataSource];
    [self drawCollectionView];
}

- (void)initDataSource
{
    self.dataArray = [NSArray array];
    self.dataArray = @[@"我的微博",@"小荷才露尖尖角",@"蝉噪林逾静",@"连雨不知春去",@"绿树阴浓夏日长",@"一夜雨声凉到梦",@"风蒲猎猎小池塘",@"别院深深夏席清"];
    //    启动页中的广告页的监听事件，当点击了广告页时，跳转到相应的页面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAdVC:) name:@"tapAction" object:nil];
}

- (void)pushToAdVC:(NSNotification *)notification
{
    ProblemCalculateCoinViewController *vc = [ProblemCalculateCoinViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ***************绘制collectionView***************
- (void)drawCollectionView
{
    
    CGFloat kLineSpacing = 20 *kScale;
    
    self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView的header和footer的高度
    self.collectionViewLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 260 * kScale);
    self.collectionViewLayout.footerReferenceSize = CGSizeMake(kScreenWidth, 200 * kScale);
    //设置item的行间距和列间距
    self.collectionViewLayout.minimumLineSpacing = kLineSpacing;
    self.collectionViewLayout.minimumInteritemSpacing = kLineSpacing;
    //itemSize决定了CollectionView布局的里面的cell的大小
    CGFloat itemW = (kScreenWidth-(2+1)*kLineSpacing)/2-0.001;
    self.collectionViewLayout.itemSize = CGSizeMake(itemW, 530 * kScale);
    self.collectionViewLayout.sectionInset = UIEdgeInsetsMake(kLineSpacing, kLineSpacing, kLineSpacing, kLineSpacing);
    //
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    if (@available(iOS 11.0, *))
    {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.collectionView.backgroundColor = JMColor(248, 248, 248);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //设置滚动方向
    self.collectionView.showsVerticalScrollIndicator = NO;
    //注册cell  头部view  尾部view
    [self.collectionView registerClass:[SXWHomeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[SXWHomeCollectionHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[SXWHomeCollectionFooterrReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self.view addSubview:self.collectionView];
    //布局
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0 *kScale);
         make.right.equalTo(self.view.mas_right).offset(0 *kScale);
         make.top.equalTo(self.view.mas_top);
         make.bottom.equalTo(self.view.mas_bottom);
     }];
}

#pragma mark - **********设置collectionView 代理**********
//确定section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//确定每个section对应的item的个数  就是cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SXWHomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setObject:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark -----------------collectionViewCell点击事件--------------------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        SXWMememeWebViewController *vc = [SXWMememeWebViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        ProblemCalculateCoinViewController *vc = [ProblemCalculateCoinViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2)
    {
        SXWH5ViewController *vc = [SXWH5ViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3)
    {
        SXWZipArchiveHTMLViewController *vc = [SXWZipArchiveHTMLViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark -----------------设置collectionView头部尾部视图--------------------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader)
    {
        self.collectionHeaderReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        self.collectionHeaderReusableView.banner_block = ^(NSInteger index) {
            
        };
        return self.collectionHeaderReusableView;
    }
    else
    {
        self.collectionFooterReusableView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        return self.collectionFooterReusableView;
    }
}

@end
