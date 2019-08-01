//
//  SXWHomeModel.h
//  SXWTest
//
//  Created by 聚米 on 2018/5/9.
//  Copyright © 2018年 聚米 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXWHomeModel : NSObject

@property (nonatomic,copy) NSString * product_img;//图片地址
@property (nonatomic,copy) NSString * name;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
