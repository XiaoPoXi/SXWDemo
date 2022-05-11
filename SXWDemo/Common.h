//
//  Common.h
//  SXWDemo
//
//  Created by JM001 on 2018/12/24.
//  Copyright © 2018 Xiaopoxi. All rights reserved.
//

#ifndef Common_h
#define Common_h

/** 屏幕宽 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

/** 屏幕高 */
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

/** 屏幕比例 */
#define kScale kScreenWidth / 750

/** RGB颜色 */
#define JMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kRGBA(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]
#define JMCOLOR248 [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]

#define JMCOLOR153 [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]
#define JMCOLOR251 [UIColor colorWithRed:251/255.0 green:251/255.0 blue:251/255.0 alpha:1.0]
#define JMCOLOR51 [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]
#define JMCOLORRed [UIColor colorWithRed:255/255.0 green:75/255.0 blue:91/255.0 alpha:1.0]
#define JMCOLORGreen JMColor(184, 255, 41)


#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

#pragma mark  ------------字体宏----------
// 字体大小缩放
#define FontSizeScale(size)         size //((kMainScreenWidth / 375) * size)
#define FontPFThin(fSize)           [UIFont fontWithName:@"PingFangSC-Thin" size:FontSizeScale(fSize)] ?: [UIFont systemFontOfSize:fSize]
#define FontPFLight(fSize)          [UIFont fontWithName:@"PingFangSC-Light" size:FontSizeScale(fSize)] ?: [UIFont systemFontOfSize:fSize]
#define FontPFMedium(fSize)         [UIFont fontWithName:@"PingFangSC-Medium" size:FontSizeScale(fSize)] ?: [UIFont systemFontOfSize:fSize]
#define FontPFRegular(fSize)        [UIFont fontWithName:@"PingFangSC-Regular" size:FontSizeScale(fSize)] ?: [UIFont systemFontOfSize:fSize]
#define FontPFSCBold(fSize)         [UIFont fontWithName:@"PingFangSC-Semibold" size:FontSizeScale(fSize)] ?: [UIFont systemFontOfSize:fSize]
#define FontPFUltralight(fSize)     [UIFont fontWithName:@"PingFangSC-Ultralight" size:FontSizeScale(fSize)] ?: [UIFont systemFontOfSize:fSize]

/** 自定义Log */

#pragma mark  ------------协助开发----------
//自定义Log
#ifdef DEBUG
#define JMLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define JMLog(...)
#endif
//防止强引用循环
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;
//判断对象是否为空或是[NSNull null]
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) count] == 0))
//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref)isEqualToString:@""]))
//解析  id 转 string
#define __GETSTRING(ID)          [ToolProject getString:ID]

// 创建不带缓存的图片
#define ImageWithFile(named) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:named ofType:nil]]
// 创建带缓存的图片
#define ImageWithName(named) [UIImage imageNamed:named]
#define RCDLocalizedString(key) NSLocalizedStringFromTable(key, @"SealTalk", nil)
#define RCCallKitLocalizedString(key)  NSLocalizedStringFromTableInBundle(key, @"RongCallKit", [RCCallKitUtility callKitBundle], nil)


#define WBAppid @"2706821549";
#define WBAppSecret @"2ef65e2e9a6a08a4bba452543c9e49c4";


#endif /* Common_h */
