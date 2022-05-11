//
//  SplashScreenView.h
//  SXWDemo
//
//  Created by XiaoXi on 2019/7/24.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adImageUrl";
static NSString *const adDeadline = @"adDeadline";

@interface SplashScreenView : UIView

/** 显示广告页面方法*/

- (void)showSplashScreenWithTime:(NSInteger )ADShowTime;

/** 广告图的显示时间*/

@property (nonatomic, assign) NSInteger ADShowTime;

/** 图片路径*/

@property (nonatomic, copy) NSString *imgFilePath;

/** 图片对应的url地址*/

@property (nonatomic, copy) NSString *imgLinkUrl;

/** 广告图的有效时间*/

@property (nonatomic, copy) NSString *imgDeadline;

@end

NS_ASSUME_NONNULL_END
