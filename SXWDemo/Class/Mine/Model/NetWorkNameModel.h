//
//  NetWorkNameModel.h
//  SXWDemo
//
//  Created by JM001 on 2019/7/9.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkNameModel : NSObject


@property (nonatomic,copy) NSString * femalename;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
