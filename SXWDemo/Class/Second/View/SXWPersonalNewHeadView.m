//
//  SXWPersonalNewHeadView.m
//  SXWDemo
//
//  Created by XiaoXi on 2019/7/24.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "SXWPersonalNewHeadView.h"
#import "UIImageView+LBBlurredImage.h"
#import "SXWPersonalNewHeadCollectionViewCell.h"


#define kLineSpacing 10

@interface SXWPersonalNewHeadView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIImageView *headImageView;

@property (nonatomic,strong) UIImageView *bgImgView;//高斯模糊背景

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *collectionArray;

@property (nonatomic,strong) UIImageView *memberImageView;//会员图片
@end

@implementation SXWPersonalNewHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = JMCOLOR248;
        self.collectionArray = [NSMutableArray array];
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    //高斯模糊背景
    self.bgImgView = [[UIImageView alloc] init];
    [self.bgImgView setUserInteractionEnabled:YES];
    /*
     1.这里设置会导致毛玻璃效果超出范围
     2.但是这样设置图片不会变形
     3.建议在底部添加一层View遮挡超出的部分 huba.jpeg
    */
    [self.bgImgView setContentMode:UIViewContentModeScaleAspectFill];
    [self.bgImgView setImageToBlur:[UIImage imageNamed:@"huba.jpeg"] blurRadius:35 completionBlock:nil];
    [self addSubview:self.bgImgView];
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(342 *kScale +246 *kScale);
    }];
    //头像
    self.headImageView = [UIImageView new];
    [self.headImageView setImage:[UIImage imageNamed:@"huba.jpeg"]];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 8 *kScale;
    self.headImageView.layer.borderColor = JMCOLOR153.CGColor;
    self.headImageView.layer.borderWidth = 1;
    [self addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20 *kScale);
        make.top.equalTo(self.mas_top).offset(168 *kScale);
        make.width.height.mas_equalTo(116 *kScale);
    }];
    //昵称 等...
    
    
    //添加一层遮罩View
    UIView *shadeView = [UIView new];
    [shadeView setBackgroundColor:kRGBA(0, 0, 0, 0.05)];
    [self addSubview:shadeView];
    [shadeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.headImageView.mas_bottom).offset(40 *kScale);
        make.bottom.equalTo(self.bgImgView.mas_bottom);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[SXWPersonalNewHeadCollectionViewCell class] forCellWithReuseIdentifier:@"SXWPersonalNewHeadCollectionViewCell"];
    [shadeView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(shadeView);
        make.bottom.equalTo(shadeView.mas_bottom).offset(- 90 *kScale);
    }];
    
    UIView *shadeBottomView = [UIView new];
    shadeBottomView.backgroundColor = JMCOLOR248;
    [self addSubview:shadeBottomView];
    [shadeBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(shadeView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    self.memberImageView = [UIImageView new];
    self.memberImageView.image = [UIImage imageNamed:@"huiyuan"];
    [self addSubview:self.memberImageView];
    [self.memberImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shadeView.mas_left).offset(20 *kScale);
        make.right.equalTo(shadeView.mas_right).offset(- 20 *kScale);
        make.top.equalTo(shadeView.mas_bottom).offset(- 90 *kScale);
        make.height.mas_equalTo(158 *kScale);
    }];
    
    
    
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
/**
 分区个数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
/**
 每个分区item的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SXWPersonalNewHeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SXWPersonalNewHeadCollectionViewCell" forIndexPath:indexPath];
    [cell setObject:self.collectionArray[indexPath.row]];
    return cell;
}
/**
 点击某个cell
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JMLog(@"点击了第%ld分item",(long)indexPath.item);
}

/**
 cell的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = (kScreenWidth - 5 *kLineSpacing)/4 ;
    return CGSizeMake(itemWidth, itemWidth);
}

/**
 每个分区的内边距（上左下右）
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, kLineSpacing, kLineSpacing, 0);
}
/**
 分区内cell之间的最小行间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kLineSpacing;
}
/**
 分区内cell之间的最小列间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kLineSpacing;
}

- (void)setObject:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = object;
        NSArray *array = @[
                           @{@"number":@"123",@"content":@"积分商城"},
                           @{@"number":@"345",@"content":@"收藏关注"},
                           @{@"number":@"456",@"content":@"我的足迹"},
                           @{@"number":@"567",@"content":@"优惠卡券"},
                           ];
        [self.collectionArray addObjectsFromArray:array];
        [self.collectionView reloadData];
        
    }
}

@end
