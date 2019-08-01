//
//  ProblemCalculateCoinViewController.m
//  SXWDemo
//
//  Created by XiaoXi on 2019/7/22.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//  计算硬币问题

#import "ProblemCalculateCoinViewController.h"

@interface ProblemCalculateCoinViewController ()<UITextFieldDelegate>//代理

@property (nonatomic,strong) UITextField * NTextField;//定义
@property (nonatomic,strong) UITextField * STextField;//定义


@property (nonatomic,copy) NSString * N;//定义
@property (nonatomic,copy) NSString * S;//定义

@property (nonatomic,strong) UILabel * countLabel;//定义


@end

@implementation ProblemCalculateCoinViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self drawUI];
}

- (void)drawUI
{
    UILabel *problemDescribeLabel = [UILabel new];
    problemDescribeLabel.text = @"假设有面值为1、2、3、、、n元的硬币，每种硬币都有无限个，要凑出S元，最少需要多少个硬币？。。。升级版就是你在S输入框输入金额，你就可以知道各种面值的数量了";
    problemDescribeLabel.numberOfLines = 0;
    problemDescribeLabel.textColor = JMCOLOR51;
    problemDescribeLabel.backgroundColor = JMCOLOR251;
    problemDescribeLabel.font = [UIFont systemFontOfSize:28 *kScale];
    [self.view addSubview:problemDescribeLabel];
    [problemDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30 *kScale);
        make.top.equalTo(self.view.mas_top).offset(30 *kScale);
        make.right.equalTo(self.view.mas_right).offset(- 30 *kScale);
    }];
    
    for (int i = 0; i <2; i++)
    {
        NSArray *titleArray = @[@"请输入N",@"请输入S"];
        UILabel *label = [UILabel new];
        label.textColor = JMCOLOR51;
        label.font = [UIFont systemFontOfSize:28 *kScale];
        label.text = titleArray[i];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(30 *kScale);
            make.top.equalTo(self.view.mas_top).offset(200 *kScale +i *250 *kScale);
            make.width.mas_equalTo(160 *kScale);
            make.height.mas_equalTo(40 *kScale);
        }];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypePhonePad;
        textField.tag = i +100;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.textColor = JMCOLOR51;
        textField.font = [UIFont systemFontOfSize:28 * kScale];
        textField.borderStyle = UITextBorderStyleLine;
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = 20 *kScale;
        //添加实时监听
        [textField addTarget:self action:@selector(textFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.view.mas_left).offset(200 *kScale);
             make.height.mas_equalTo(80 * kScale);
             make.width.mas_equalTo(270 * kScale);
             make.top.equalTo(self.view.mas_top).offset(200 *kScale +i *250 *kScale);
         }];
    }
    
    UIButton *sureButton = [UIButton new];
    [sureButton setTitle:@"检查" forState:UIControlStateNormal];
    [sureButton setTitle:@"检查" forState:UIControlStateSelected];
    [sureButton setTintColor:JMCOLOR51];
    [sureButton setBackgroundColor:JMColor(219, 70, 99)];
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 20 *kScale;
    sureButton.layer.borderColor = JMColor(219, 70, 99).CGColor;
    sureButton.layer.borderWidth = 1;
    [sureButton addTarget:self action:@selector(ClickSureButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(- 30 *kScale);
        make.top.equalTo(self.view.mas_top).offset(320 *kScale);
        make.width.mas_equalTo(200 *kScale);
        make.height.mas_equalTo(60 *kScale);
    }];
    
    self.countLabel = [UILabel new];
    self.countLabel.textColor = [UIColor redColor];
    self.countLabel.hidden = YES;
    self.countLabel.numberOfLines = 0;
    self.countLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.countLabel.font = [UIFont systemFontOfSize:30 *kScale];
    [self.view addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(160 *kScale);
        make.bottom.equalTo(self.view.mas_bottom).offset(-200 *kScale);
    }];
    
}

//监听改变方法
- (void)textFieldTextDidChange:(UITextField *)textChange
{
    self.countLabel.hidden = YES;
    if (textChange.tag == 100)
    {
        self.N = textChange.text;
    }
    if (textChange.tag == 101)
    {
        self.S = textChange.text;
    }
    JMLog(@"文字改变：%@",textChange.text);
}

- (void)ClickSureButton:(UIButton *)sender
{
    [self.view endEditing:YES];
    self.countLabel.hidden = NO;

//    if (!self.N || self.N.length == 0)
//    {
//        JMLog(@"输入错误")
//        return;
//    }
    if (!self.S || self.S.length == 0)
    {
        JMLog(@"输入错误")
        return;
    }
    
//    NSInteger NCount = [self.N integerValue];
//    NSInteger SCount = [self.S integerValue];
//
//    NSInteger count = SCount / NCount;
//
//    self.countLabel.text = [NSString stringWithFormat:@"%ld",(count +1)];
    
    //1元 5元 10元 20元 50元 100元
    NSInteger SCount = [self.S integerValue];
    
    NSInteger coins100 = SCount / 100;//100元的数量
//    SCount % coins100;//剩余的钱数  小于100
    
    NSInteger coins50 = (SCount % 100)/50;//50元的数量
//    (SCount % coins100) % 50//剩余的钱数  小于50
    
    NSInteger coins20 = ((SCount % 100) % 50)/20;//20元的数量
//    ((SCount % coins100) % 50)%20 //剩余的钱数  小于20
    
    NSInteger coins10 = (((SCount % 100) % 50)%20)/10;//10元的数量
    //    (((SCount % coins100) % 50)%20)%10 //剩余的钱数  小于10
    
    NSInteger coins5 = ((((SCount % 100) % 50)%20)%10)/5;//5元的数量
    //    ((((SCount % coins100) % 50)%20)%10)%5 //剩余的钱数  小于5
    
    NSInteger coins2 = (((((SCount % 100) % 50)%20)%10)%5)/2;//2元的数量
    //    (((((SCount % coins100) % 50)%20)%10)%5)%2 //剩余的钱数  小于2
    
    NSInteger coins1 = ((((((SCount % 100) % 50)%20)%10)%5)%2)/1;//1元的数量
    
    
    self.countLabel.text = [NSString stringWithFormat:@"100元%ld张 \n50元%ld张 \n20元%ld张 \n10元%ld张 \n5元%ld张 \n2元%ld张 \n1元%ld张",coins100,coins50,coins20,coins10,coins5,coins2,coins1];
    
    
    
}




@end
