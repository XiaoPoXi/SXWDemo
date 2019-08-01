//
//  SXWMarqueeView.m
//  SXWTest
//
//  Created by 聚米 on 2018/7/30.
//  Copyright © 2018年 聚米 . All rights reserved.
//

#import "SXWMarqueeView.h"

@interface SXWMarqueeView()
{
    CGRect rectMark1;//标记第一个位置
    CGRect rectMark2;//标记第二个位置
    NSMutableArray *labelArr;
    BOOL isStop;//停止
    NSTimeInterval timeInterval;//时间
}


@end

@implementation SXWMarqueeView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //
        title = [NSString stringWithFormat:@"  %@  ",title];//间隔
        
        timeInterval = [self displayDurationForString:title];
        
        self.backgroundColor = [UIColor blackColor];
        self.clipsToBounds = YES;
        //
        UILabel* textLb = [[UILabel alloc] initWithFrame:CGRectZero];
        textLb.textColor = [UIColor redColor];
        textLb.font = [UIFont boldSystemFontOfSize:28 *kScale];
        textLb.text = title;
        
        //计算textLb大小
        CGSize sizeOfText = [textLb sizeThatFits:CGSizeZero];
        
        rectMark1 = CGRectMake(0, 0, sizeOfText.width, self.bounds.size.height);
        rectMark2 = CGRectMake(rectMark1.origin.x+rectMark1.size.width, 0, sizeOfText.width, self.bounds.size.height);
        
        textLb.frame = rectMark1;
        [self addSubview:textLb];
        
        labelArr = [NSMutableArray arrayWithObject:textLb];
        
        
        //判断是否需要reserveTextLb
        BOOL useReserve = sizeOfText.width > frame.size.width ? YES : NO;
        
        if (useReserve) {
            //alloc reserveTextLb ...
            
            UILabel* reserveTextLb = [[UILabel alloc] initWithFrame:rectMark2];
            reserveTextLb.textColor = [UIColor redColor];
            reserveTextLb.font = [UIFont boldSystemFontOfSize:28 *kScale];
            reserveTextLb.text = title;
            [self addSubview:reserveTextLb];
            
            [labelArr addObject:reserveTextLb];
            
            [self paomaAnimate];
        }
        
    }
    return self;
}



- (void)paomaAnimate
{
    if (!isStop)
    {
        //
        UILabel* lbindex0 = labelArr[0];
        UILabel* lbindex1 = labelArr[1];
        
        [UIView transitionWithView:self duration:timeInterval options:UIViewAnimationOptionCurveLinear animations:^
        {
            
            lbindex0.frame = CGRectMake(-rectMark1.size.width, 0, rectMark1.size.width, rectMark1.size.height);
            lbindex1.frame = CGRectMake(lbindex0.frame.origin.x+lbindex0.frame.size.width, 0, lbindex1.frame.size.width, lbindex1.frame.size.height);
            
        } completion:^(BOOL finished) {
            //
            
            lbindex0.frame = rectMark2;
            lbindex1.frame = rectMark1;
            
            [labelArr replaceObjectAtIndex:0 withObject:lbindex1];
            [labelArr replaceObjectAtIndex:1 withObject:lbindex0];
            
            [self paomaAnimate];
        }];
    }
}


- (void)start
{
    isStop = NO;
    UILabel* lbindex0 = labelArr[0];
    UILabel* lbindex1 = labelArr[1];
    lbindex0.frame = rectMark2;
    lbindex1.frame = rectMark1;
    
    [labelArr replaceObjectAtIndex:0 withObject:lbindex1];
    [labelArr replaceObjectAtIndex:1 withObject:lbindex0];
    
    [self paomaAnimate];
    
}
- (void)stop
{
    isStop = YES;
}

- (NSTimeInterval)displayDurationForString:(NSString*)string
{
    return string.length/5;
}


@end
