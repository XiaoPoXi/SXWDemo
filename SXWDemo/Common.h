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


#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

/** 自定义Log */
#ifdef DEBUG
#define JMLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define JMLog(...)
#endif

//防止强引用循环
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;

#define WBAppid @"2706821549";
#define WBAppSecret @"2ef65e2e9a6a08a4bba452543c9e49c4";

/** 字体大小 */
#define Font(size) [UIFont systemFontOfSize:size *kScale]


#endif /* Common_h */
