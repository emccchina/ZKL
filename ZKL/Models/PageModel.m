//
//  PageModel.m
//  ZKL
//
//  Created by champagne on 15-3-26.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "PageModel.h"

@implementation PageModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{
             @"currentPage":@"",
             @"pageSize":@"",
             @"total":@"",
             @"rows":@"",
             };
}

@end
