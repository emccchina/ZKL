//
//  PerformModel.m
//  ZKL
//
//  Created by champagne on 15-3-30.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "PerformModel.h"

@implementation PerformModel

+ (PerformModel *)sharePerform
{
    static PerformModel *performInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        performInstance = [[self alloc] init];
    });
    return performInstance;
}

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{@"performCode":@"performCode",
             @"userCode":@"userCode",
             @"planCode":@"planCode",
             @"performName":@"performName",
             @"planMinute":@"planMinute",
             @"realPlanMinute":@"realPlanMinute",
             @"restMinute":@"restMinute",
             @"realRestMinute":@"realRestMinute",
             @"wasteMinute":@"wasteMinute"
             };
}



@end


