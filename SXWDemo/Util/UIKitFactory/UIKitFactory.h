//
//  UIKitFactory.h
//  Uini
//
//  Created by JMMac-W on 2021/3/26.
//  

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIKitFactory : NSObject

/**
 快速创建view

 @param  color 背景颜色
 @return UIView
 */
+ (UIView *)viewWithColor:(UIColor *)color;

/**
 *  @brief 创建标签控件
 *
 *  @param text     文本内容
 *  @param color    字体颜色
 *  @param font     字体
 *
 *  @return UILabel
 */
+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font;

/**
 创建按钮(图片)控件

 @param norImg 正常图片
 @param hltImg 高亮图片
 @param target 响应者
 @param action 响应方法
 @return UIButton
 */
+ (UIButton *)buttonWithImage:(NSString *)norImg hltImage:(NSString *)hltImg
                       target:(id)target action:(SEL)action;
+ (UIButton *)buttonWithImage:(NSString *)norImg hltImage:(NSString *)hltImg click:(void(^)(BOOL click))click;
+ (UIButton *)buttonWithBackImage:(NSString *)norImg hltBackImage:(NSString *)hltImg click:(void(^)(BOOL click))click;

/**
 创建按钮(文字)控件
 
 @param title   按钮标题
 @param color   文字颜色
 @param font    标题字体
 @param target  响应者
 @param action  响应方法
 @return UIButton
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                        color:(UIColor *)color
                         font:(UIFont *)font
                       target:(id)target action:(SEL)action;
//链式button
+ (UIButton *)buttonWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font click:(void(^)(BOOL click))click;

/**
 *  @brief 创建图片控件
 *
 *  @param imgName  图片名称
 *
 *  @return UIImageView
 */
+ (UIImageView *)imageViewWithNamed:(NSString *)imgName;

/**
 *  @brief 快速创建输入框
 *
 *  @param color        字体颜色
 *  @param font         字体大小
 *  @param placeholder  占位内容
 *
 *  @return UITextField
 */
+ (UITextField *)textFieldWithColor:(UIColor *)color font:(UIFont *)font
                        placeholder:(NSString *)placeholder;

/**
 *  @brief 创建表视图控件
 *
 *  @param style            风格类型
 *  @param delegate         代理
 *  @param dataSource       数据源
 *
 *  @return UITableView
 */
+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style
                           delegate:(id)delegate
                         dataSource:(id)dataSource;

/**
 *  @brief 创建图片类型的UIBarButtonItem
 *
 *  @param norImg   正常图片
 *  @param hltImage 高亮图片
 *  @param target   事件响应对象
 *  @param action   事件响应方法
 *
 *  @return UIBarButtonItem对象
 */
+ (UIBarButtonItem *)itemWithImage:(NSString *)norImg
                          hltImage:(NSString *)hltImage
                            target:(id)target action:(SEL)action;

/**
 *  @brief 创建文字类型的UIBarButtonItem
 *
 *  @param title        按钮标题
 *  @param color        文字颜色
 *  @param font         字体
 *  @param target       事件响应对象
 *  @param action       事件响应方法
 *
 *  @return UIBarButtonItem对象
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                             color:(UIColor *)color
                              font:(UIFont *)font
                            target:(id)target action:(SEL)action;


+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text rangeText:(NSString *)rangeText textColor:(UIColor *)color;



@end

NS_ASSUME_NONNULL_END
