//
//  ZHWarnView.h
//  JuMiWeiShang
//
//  Created by 聚米 on 2017/10/8.
//  Copyright © 2017年 JuMi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHWarnView : UIView

/* 黑色背s景 */
@property (nonatomic, strong) UIView      * customView;
/* 图片View */
@property (nonatomic, strong) UIImageView * imageView;
/* label */
@property (nonatomic, strong) UILabel     * warnLabel;

/* 图片Str */
@property (nonatomic, strong) NSString    * imageStr;
/* text */
@property (nonatomic, strong) NSString    * textStr;

//成功
+ (void)showSuccess:(NSString *)success;
//失败
+ (void)showError:(NSString *)error;


@end
