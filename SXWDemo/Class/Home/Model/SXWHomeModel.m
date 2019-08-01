
//
//  SXWHomeModel.m
//  SXWTest
//
//  Created by 聚米 on 2018/5/9.
//  Copyright © 2018年 聚米 . All rights reserved.
//

#import "SXWHomeModel.h"

@implementation SXWHomeModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.product_img = dictionary[@"product_img"];
        self.name = dictionary[@"name"];

    }
    return self;
}


@end
