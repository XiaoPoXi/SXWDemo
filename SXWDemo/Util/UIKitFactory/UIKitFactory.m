//
//  UIKitFactory.m
//  Uini
//
//  Created by JMMac-W on 2021/3/26.
//  基本控件的工厂类

#import "UIKitFactory.h"
#import <Accelerate/Accelerate.h>

@implementation UIKitFactory

+ (UIView *)viewWithColor:(UIColor *)color
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    return view;
}

+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] init];
    [label setFont:font];
    [label setText:text];
    [label setTextColor:color];
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

+ (UIButton *)buttonWithImage:(NSString *)norImg hltImage:(NSString *)hltImg target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    if (norImg.length > 0)
    {
        [button setImage:[UIImage imageNamed:norImg] forState:UIControlStateNormal];
    }
    
    if (hltImg.length > 0)
    {
        [button setImage:[UIImage imageNamed:hltImg] forState:UIControlStateHighlighted];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithImage:(NSString *)norImg hltImage:(NSString *)hltImg click:(void(^)(BOOL click))click
{
    UIButton *button = [[UIButton alloc] init];
    if (norImg.length > 0)
    {
        [button setImage:[UIImage imageNamed:norImg] forState:UIControlStateNormal];
    }
    
    if (hltImg.length > 0)
    {
        [button setImage:[UIImage imageNamed:hltImg] forState:UIControlStateHighlighted];
    }
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x)
    {
        //点击事件
        click(YES);
    }];
    return button;
}

+ (UIButton *)buttonWithBackImage:(NSString *)norImg hltBackImage:(NSString *)hltImg click:(void(^)(BOOL click))click
{
    UIButton *button = [[UIButton alloc] init];
    if (norImg.length > 0)
    {
        [button setBackgroundImage:[UIImage imageNamed:norImg] forState:UIControlStateNormal];
    }
    
    if (hltImg.length > 0)
    {
        [button setBackgroundImage:[UIImage imageNamed:hltImg] forState:UIControlStateHighlighted];
    }
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x)
    {
        //点击事件
        click(YES);
    }];
    return button;
}


+ (UIButton *)buttonWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button.titleLabel setFont:font];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//点击事件回调按钮
+ (UIButton *)buttonWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font click:(void(^)(BOOL click))click
{
    UIButton *button = [[UIButton alloc] init];
    [button.titleLabel setFont:font];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x)
    {
        //点击事件
        click(YES);
    }];
    return button;
}

+ (UIImageView *)imageViewWithNamed:(NSString *)imgName
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    if (imgName.length > 0)
    {
        UIImage *image = [UIImage imageNamed:imgName];
        imageView.image = image;
    }
    return imageView;
}

+ (UITextField *)textFieldWithColor:(UIColor *)color font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc] init];
    [textField setTextColor:color];
    [textField setTextAlignment:NSTextAlignmentLeft];
    [textField setFont:font];
    [textField setPlaceholder:placeholder];
    [textField setBorderStyle:UITextBorderStyleNone];   // 外框类型
    [textField setBackgroundColor:[UIColor clearColor]];
    [textField setReturnKeyType:UIReturnKeyDefault];    // 设置 return 键
    [textField setKeyboardType:UIKeyboardTypeDefault];  // 键盘显示类型
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing]; // 编辑时出现清除按钮
    [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];  // 编辑内容时垂直对齐方式
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];   // 自动纠错:关闭
    return textField;
}

+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style delegate:(id)delegate dataSource:(id)dataSource
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    [tableView setDelegate:delegate];
    [tableView setDataSource:dataSource];
    [tableView setShowsHorizontalScrollIndicator:NO];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    return tableView;
}

+ (UIBarButtonItem *)itemWithImage:(NSString *)norImg hltImage:(NSString *)hltImage target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    if (norImg.length > 0)
    {
        [button setImage:[UIImage imageNamed:norImg] forState:UIControlStateNormal];
    }
    
    if (hltImage.length > 0)
    {
        [button setImage:[UIImage imageNamed:hltImage] forState:UIControlStateHighlighted];
    }
    
    CGRect rect = {0, 0, button.currentImage.size};
    CGFloat version = [UIDevice currentDevice].systemVersion.floatValue;
    if (version >= 11.0f)
    {
        // iOS11 开始按钮的触摸范围不会被自动放大，必须要指定frame
        CGFloat width = button.currentImage.size.width + 20;
        if (width < 35)
        {
            width = 35;
        }
        rect = CGRectMake(0, 0, width, 40);
    }
    [button setFrame:rect];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setAdjustsImageWhenHighlighted:NO];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *button = [self buttonWithTitle:title color:color font:font target:target action:action];
    NSDictionary *dictAttributes = @{NSFontAttributeName : button.titleLabel.font ?: [UIFont systemFontOfSize:15]};
    CGSize titleSize = [button.titleLabel.text sizeWithAttributes:dictAttributes];
    CGRect rect = {0, 0, titleSize};
    CGFloat version = [UIDevice currentDevice].systemVersion.floatValue;
    if (version >= 11.0f)
    {
        CGFloat width = titleSize.width + 20;
        if (width < 35)
        {
            width = 35;
        }
        rect = CGRectMake(0, 0, width, 40);
    }
    [button setFrame:rect];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark - 富文本设置部分字体颜色
 
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text rangeText:(NSString *)rangeText textColor:(UIColor *)color{
 
    NSRange hightlightTextRange = [text rangeOfString:rangeText];
 
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
 
    if (hightlightTextRange.length > 0) {
 
        [attributeStr addAttribute:NSForegroundColorAttributeName
 
                 value:color
 
                 range:hightlightTextRange];
 
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14.0f] range:hightlightTextRange];
 
        return attributeStr;
 
        }else {
 
            return [rangeText copy];
 
            }
}



@end
