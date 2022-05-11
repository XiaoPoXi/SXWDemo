//
//  SXWGetFishViewController.m
//  SXWDemo
//
//  Created by xiaoxi on 2021/11/29.
//  Copyright © 2021 Xiaopoxi. All rights reserved.
//  摸鱼办 倒计时

#import "SXWGetFishViewController.h"

@interface SXWGetFishViewController ()

@end

@implementation SXWGetFishViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"摸鱼办提醒您";
    [self addViews];
}



- (void)addViews
{
    WeakSelf(weakSelf);
//    @"【摸鱼办】提醒您：11月25日早上好，摸鱼人！工作再累，一定不要忘记摸鱼哦！有事没事起身去茶水间，去厕所，去廊道走走别老在工位上坐着，钱是老板的,但命是自己的。\n距离周末还有：1天 \n 距离元旦还有:37天 \n 距离春节还有:68天 \n 距离清明节还有:131天 \n 距离劳动节还有:157天 \n 距离端午节还有:190天 \n 距离中秋节还有:300天 \n 距离国庆节还有:310天 \n 上班是帮老板赚钱，摸鱼是赚老板的钱！ \n 最后，祝愿天下所有摸鱼人，都能愉快的度过每一天…";

    
    UILabel *currentLabel = [UIKitFactory labelWithText:[NSString stringWithFormat:@"当前时间 %@",[self currentDateStr]] textColor:JMCOLOR51 font:FontPFMedium(32 *kScale)];
    [self.view addSubview:currentLabel];
    [currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(30 *kScale);
        make.top.equalTo(weakSelf.view.mas_top).offset(100 *kScale);
    }];
    
    UITextView *textView = [UITextView new];
    textView.text = [NSString stringWithFormat:@"【摸鱼办】提醒您：%@早上好，摸鱼人！工作再累，一定不要忘记摸鱼哦！有事没事起身去茶水间，去厕所，去廊道走走别老在工位上坐着，钱是老板的,但命是自己的。\n 距离元旦还有:%ld天 \n 距离春节还有:%ld天 \n 距离清明节还有:%ld天 \n 距离劳动节还有:%ld天 \n 距离端午节还有:%ld天 \n 距离中秋节还有:%ld天 \n 距离国庆节还有:%ld天 \n 上班是帮老板赚钱，摸鱼是赚老板的钱！ \n 最后，祝愿天下所有摸鱼人，都能愉快的度过每一天…",[self currentDateStr],[self getDifferenceByDate:@"2022-01-01"],[self getDifferenceByDate:@"2022-01-31"],[self getDifferenceByDate:@"2022-04-03"],[self getDifferenceByDate:@"2022-04-30"],[self getDifferenceByDate:@"2022-06-03"],[self getDifferenceByDate:@"2022-09-10"],[self getDifferenceByDate:@"2022-10-01"]];
    textView.backgroundColor = JMCOLORRed;
    textView.textColor = JMCOLOR51;
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(30 *kScale);
        make.right.equalTo(weakSelf.view.mas_right).offset(- 30 *kScale);
        make.top.equalTo(weakSelf.view.mas_top).offset(200 *kScale);
        make.height.mas_equalTo(600 *kScale);
    }];
    
    UIButton *copysButton = [UIKitFactory buttonWithTitle:@"复制" color:JMCOLOR51 font:FontPFMedium(40 *kScale) click:^(BOOL click) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = textView.text;
    }];
    copysButton.layer.masksToBounds = YES;
    copysButton.layer.cornerRadius = 50 *kScale;
    copysButton.backgroundColor = JMCOLORGreen;
    [self.view addSubview:copysButton];
    [copysButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(690 *kScale);
        make.height.mas_equalTo(100 *kScale);
        make.top.equalTo(textView.mas_bottom).offset(100 *kScale);
    }];
}

// 获取当前时间
- (NSString *)currentDateStr
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    // [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}


- (NSInteger)getDifferenceByDate:(NSString *)date
{
     //获得当前时间
    NSDate *now = [NSDate date];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *oldDate1 = [dateFormatter dateFromString: date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:now  toDate:oldDate1 options:0];
    return [comps day];
}

/*
 2022-01-01 元旦 [self getDifferenceByDate:@"2022-01-01"]
 2022-01-31 春节 [self getDifferenceByDate:@"2022-01-31"]
 2022-04-03 清明节    [self getDifferenceByDate:@"2022-04-03"]
 2022-04-30 劳动节   [self getDifferenceByDate:@"2022-04-30"]
 2022-06-03   端午节  [self getDifferenceByDate:@"2022-06-03"]
 2022-09-10  中秋节   [self getDifferenceByDate:@"2022-09-10"]
 2022-10-01   国庆节  [self getDifferenceByDate:@"2022-10-01"]
 
 一、元旦：2022年1月1日至3日放假，共3天。
 二、春节：1月31日至2月6日放假调休，共7天。1月29日（星期六）、1月30日（星期日）上班。
 三、清明节：4月3日至5日放假调休，共3天。4月2日（星期六）上班。
 四、劳动节：4月30日至5月4日放假调休，共5天。4月24日（星期日）、5月7日（星期六）上班。
 五、端午节：6月3日至5日放假，共3天。
 六、中秋节：9月10日至12日放假，共3天。
 七、国庆节：10月1日至7日放假调休，共7天。10月8日（星期六）、10月9日（星期日）上班。
 
 
 [self getDifferenceByDate:@"2022-01-01"],[self getDifferenceByDate:@"2022-01-31"],[self getDifferenceByDate:@"2022-04-03"],[self getDifferenceByDate:@"2022-04-30"],[self getDifferenceByDate:@"2022-06-03"],[self getDifferenceByDate:@"2022-09-10"],[self getDifferenceByDate:@"2022-10-01"]
 */


@end
