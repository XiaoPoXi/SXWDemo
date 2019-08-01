//
//  SXWToolServeTableViewCell.m
//  SXWDemo
//
//  Created by XiaoXi on 2019/7/25.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//  工具服务cell

#import "SXWToolServeTableViewCell.h"
#import "SXWToolServeCollectionViewCell.h"

#define kLineSpacing 10

@interface SXWToolServeTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectionArray;
@property (nonatomic, strong) UIView *whiteView;
@end

@implementation SXWToolServeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = JMCOLOR248;
        self.collectionArray = [NSMutableArray array];
        NSArray *array = @[
                           @{@"image":@"woxiangyaoicon",@"title":@"我想要"},
                           @{@"image":@"qiandaoicon",@"title":@"签到"},
                           @{@"image":@"miaoshaicon",@"title":@"秒杀"},
                           @{@"image":@"tuangouicon",@"title":@"团购"},
                           @{@"image":@"kanjiaicon",@"title":@"砍价"},
                           @{@"image":@"remaiicon",@"title":@"热卖"},
                           @{@"image":@"shiyongicon",@"title":@"试用"},
                           @{@"image":@"yushouicon",@"title":@"预售"},

                           
                           ];
        [self.collectionArray addObjectsFromArray:array];
        [self addSubViews];
        
    }
    return self;
}

- (void)addSubViews
{
    self.whiteView = [UIView new];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.whiteView];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20 *kScale);
        make.right.equalTo(self.contentView.mas_right).offset(- 20 *kScale);
        make.top.bottom.equalTo(self);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[SXWToolServeCollectionViewCell class] forCellWithReuseIdentifier:@"SXWToolServeCollectionViewCell"];
    [self.whiteView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.whiteView);
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
    return self.collectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SXWToolServeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SXWToolServeCollectionViewCell" forIndexPath:indexPath];
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
    CGFloat itemWidth = (self.whiteView.frame.size.width  - 5 *kLineSpacing)/4 ;
    return CGSizeMake(itemWidth, itemWidth);
}

/**
 每个分区的内边距（上左下右）
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kLineSpacing, kLineSpacing, kLineSpacing, kLineSpacing);
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




- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


@end
