//
//  SplashScreenDataManager.h
//  SXWDemo
//
//  Created by XiaoXi on 2019/7/24.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SplashScreenDataManager : NSObject

@property(nonatomic, strong)NSArray *resultArray;

@property(nonatomic, strong) NSString *documentPath;

@property(nonatomic, strong) UIImageView *splashImageVeiw;

@property(nonatomic, copy)NSString *imageURL;
/**
 *  下载新的图片
 */
+(void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName imgLinkUrl:(NSString *)imgLinkUrl imgDeadline:(NSString *)imgDeadline;
//判断沙盒中是否存在广告图片
+ (BOOL)isFileExistWithFilePath:(NSString *)filePath;
/**
 *  初始化广告页面
 */
+(void)getAdvertisingImageData;

+ (NSString *)getFilePathWithImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
