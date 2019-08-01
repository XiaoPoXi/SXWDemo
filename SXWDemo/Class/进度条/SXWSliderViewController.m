//
//  SXWSliderViewController.m
//  SXWDemo
//
//  Created by XiaoXi on 2019/8/1.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//  进度条

#import "SXWSliderViewController.h"
#import "SXWSlider.h"


@interface SXWSliderViewController ()

@property(nonatomic,strong) UILabel *loanMoney ; // 贷款的金额
@property(nonatomic,strong) SXWSlider *slider ; // 贷款的金额
@end

@implementation SXWSliderViewController



-(SXWSlider *)slider
{
    if(!_slider)
    {
        _slider = [[SXWSlider alloc] init] ;
        _slider.minimumValue = 0 ;
        // 最大值要去网络请求 先模拟
        _slider.maximumValue = 3000 ;
        _slider.value  = 0 ;
        _slider.continuous = YES;// 设置可连续变化
        //设置已经滑过一端滑动条颜色
        _slider.minimumTrackTintColor= [UIColor blueColor] ;
        //设置未滑过一端滑动条颜色
        _slider.maximumTrackTintColor=[UIColor grayColor];
        //设置滑块图片背景
        [_slider setThumbImage:[UIImage imageNamed:@"caHuadong"] forState:UIControlStateNormal];
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
    }
    
    return _slider ;
    
    
}



-(UILabel *)loanMoney
{
    if(!_loanMoney)
    {
        _loanMoney = [[UILabel alloc] init] ;
        _loanMoney.font = [UIFont systemFontOfSize:40] ;
        _loanMoney.textColor = [UIColor blueColor] ;
        _loanMoney.text = @"0元" ;
    }
    return _loanMoney ;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loanMoney.frame = CGRectMake(22.5 ,100 *kScale, kScreenWidth-2*22.5,30);
    
    self.slider.frame = CGRectMake(22.5,200 *kScale, kScreenWidth-2 *22.5,30);
    
    [self.view addSubview:self.loanMoney] ;
    [self.view addSubview:self.slider] ;
    
}

-(void)setNewSliderValue:(UISlider *)slider andAccuracy:(float)accuracy
{
    // 滑动条的 宽
    float width = kScreenWidth - 2*2.5 *kScale ;
    // 如： 用户想每滑动一次 增加100的量 每次滑块需要滑动的宽
    float slideWidth = width*accuracy/slider.maximumValue ;
    // 在滑动条中 滑块的位置 是根据 value值 显示在屏幕上的 那么 把目前滑块的宽 加上用户新滑动一次的宽 转换成value值
    // 根据当前value值 求出目前滑块的宽
    float currentSlideWidth =  slider.value/accuracy*slideWidth ;
    // 用户新滑动一次的宽加目前滑动的宽 得到新的 目前滑动的宽
    float newSlideWidth = currentSlideWidth+slideWidth ;
    // 转换成 新的 value值
    float value =  newSlideWidth/width*slider.maximumValue ;
    // 取整
    int d = (int)(value/accuracy) ;
    
    // 因为从0滑到100后在往回滑 即使滑到最左边 还是显示100 应该是算法有点问题 这里就不优化算法了 针对这种特殊情况做些改变
    if(d>2)
    {
        
        slider.value= d*accuracy ;
        self.loanMoney.text =  [NSString stringWithFormat:@"%li元", (long) slider.value] ;
    }
    else
    {
        if(d==0 || slider.value==0)
        {
            slider.value = 0 ;
        }
        else if(d==1)
        {
            slider.value = accuracy ;
        }
        else if(d==2)
        {
            slider.value = 2*accuracy ;
        }
        self.loanMoney.text =  [NSString stringWithFormat:@"%li元", (long) slider.value] ;
    }
}

// slider变动时改变label值
- (void)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    
    [self setNewSliderValue:slider andAccuracy:100] ;
    
    
}


@end
