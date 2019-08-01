//
//  SXWHomeCollectionHeaderReusableView.m
//  SXWTest
//
//  Created by 聚米 on 2018/5/9.
//  Copyright © 2018年 聚米 . All rights reserved.
//

#import "SXWHomeCollectionHeaderReusableView.h"
#import "SDCycleScrollView.h"

@interface SXWHomeCollectionHeaderReusableView ()<SDCycleScrollViewDelegate>


@property(nonatomic,strong)SDCycleScrollView *adScrollView;
@property (nonatomic,strong) UIView *bgview;

@property (nonatomic,strong) NSArray *imageArray;

@end

@implementation SXWHomeCollectionHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RandomColor;
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    self.imageArray = @[
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525859786829&di=31c4dfa4493d00c7605054ddfb66b7eb&imgtype=0&src=http%3A%2F%2Fpic.90sjimg.com%2Fdesign%2F00%2F07%2F10%2F82%2F558923bf3ff6f.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525859881401&di=792c061d5eca3ca7b539af7f47d6fd66&imgtype=0&src=http%3A%2F%2Fimage.tupian114.com%2F20160822%2F1728519763.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525859901029&di=75a610c77771a7e506be01cd07c33085&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0183d25987db0e00000021292e76f3.jpg"
                                  ];
    
    self.adScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 260 *kScale) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.adScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    self.adScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
     // 自定义分页控件小圆标颜色
    self.adScrollView.currentPageDotColor = RandomColor;
    [self addSubview:self.adScrollView];
    
//    self.bgview = [UIView new];
//    self.bgview.backgroundColor = JMColor(245, 245, 245);
//    [self addSubview:self.bgview];
//    [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.adScrollView.mas_bottom);
//        make.left.equalTo(self);
//        make.right.equalTo(self);
//        make.height.mas_equalTo(40 *kScale);
//    }];
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.adScrollView.imageURLStringsGroup = self.imageArray;
    });
    
//     block监听点击方式--轮播图点击
    WeakSelf(weakSelf);
    self.adScrollView.clickItemOperationBlock = ^(NSInteger currentIndex)
    {
        weakSelf.banner_block(currentIndex);
    };
    
}

//#pragma mark - SDCycleScrollViewDelegate 监听点击方式
//
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
//{
//    JMLog(@"---点击了第%ld张图片", (long)index);
//}


@end
