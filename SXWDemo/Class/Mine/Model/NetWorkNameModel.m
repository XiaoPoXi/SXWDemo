//
//  NetWorkNameModel.m
//  SXWDemo
//
//  Created by JM001 on 2019/7/9.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "NetWorkNameModel.h"

@implementation NetWorkNameModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.femalename = dict[@"femalename"];
    }
    return self;
}


@end
