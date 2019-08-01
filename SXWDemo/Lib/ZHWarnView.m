//
//  ZHWarnView.m
//  JuMiWeiShang
//
//  Created by 聚米 on 2017/10/8.
//  Copyright © 2017年 JuMi. All rights reserved.
//  黑色的文字提示框

#import "ZHWarnView.h"

/** 屏幕比例 */
#define kScale kScreenWidth / 750

@interface ZHWarnView()

@property (nonatomic, weak) NSTimer * hideDelayTimer;

@end

@implementation ZHWarnView

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error
{
    [self show:error icon:@"xg_fa"];
}

#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)success
{
    [self show:success icon:@"xg_su"];
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        //黑色背景
        _customView = [[UIView alloc]initWithFrame:CGRectMake((frame.size.width-350*kScale)/2, (frame.size.height-188*kScale)/2, 350*kScale, 188*kScale)];
        _customView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
        _customView.layer.cornerRadius = 15 * kScale;
        _customView.layer.masksToBounds = YES;
        [self addSubview:_customView];
        
        //图片视图
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(153*kScale, 30*kScale, 44*kScale, 44*kScale)];
        _imageView.backgroundColor = [UIColor clearColor];
        [_customView addSubview:_imageView];
        
        //文字label
        _warnLabel = [[UILabel alloc]initWithFrame:CGRectMake(25*kScale, 78*kScale, 300*kScale, 80*kScale)];
        _warnLabel.textColor = [UIColor whiteColor];
        _warnLabel.font = [UIFont systemFontOfSize:28*kScale];
        _warnLabel.textAlignment = NSTextAlignmentCenter;
        _warnLabel.backgroundColor = [UIColor clearColor];
        _warnLabel.numberOfLines = 0;
        [_customView addSubview:_warnLabel];
    }
    return self;
}

#pragma mark 加载
+ (instancetype)showViewAddedAnimated:(BOOL)animated
{
    UIWindow * keyWindow = [[[UIApplication sharedApplication] delegate] window];
    keyWindow.windowLevel = UIWindowLevelNormal;
    ZHWarnView * warnView = [[self alloc]initWithFrame:keyWindow.bounds];
    warnView.center = CGPointMake(keyWindow.bounds.size.width/2.0f, keyWindow.bounds.size.height/2.0f);
    [keyWindow addSubview:warnView];
    [warnView showAnimated:animated];
    return warnView;
}

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon
{
    // 快速显示一个提示信息
    ZHWarnView * warnView = [ZHWarnView showViewAddedAnimated:YES];
    warnView.imageStr = icon;
    warnView.textStr = text;
    
    // 1.2秒之后再消失
    [warnView hideAnimated:YES afterDelay:1.2];
}

#pragma mark 动画显示
- (void)showAnimated:(BOOL)animated
{
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
    }];
}

#pragma mark 消失
- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:delay target:self selector:@selector(handleHideTimer:) userInfo:@(animated) repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.hideDelayTimer = timer;
}

- (void)handleHideTimer:(NSTimer *)timer
{
    [self animatedOut];
}

#pragma mark 消失动画
- (void)animatedOut
{
    self.alpha = 1;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished)
    {
        [self.hideDelayTimer invalidate];
        self.hideDelayTimer = nil;
        [self removeFromSuperview];
    }];
}

#pragma mark 赋值
- (void)setImageStr:(NSString *)imageStr
{
    self.imageView.image = [UIImage imageNamed:imageStr];
}

- (void)setTextStr:(NSString *)textStr
{
    self.warnLabel.text = textStr;
    CGRect rect = [textStr boundingRectWithSize:CGSizeMake(300*kScale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_warnLabel.font} context:nil];
    CGFloat height = rect.size.height;
    CGFloat h = height+78*kScale+30*kScale;
    _customView.frame = CGRectMake((self.frame.size.width-350*kScale)/2, (self.frame.size.height-h)/2, 350*kScale, h);
    _warnLabel.frame = CGRectMake(25*kScale, 78*kScale, 300*kScale, height);
}

@end
