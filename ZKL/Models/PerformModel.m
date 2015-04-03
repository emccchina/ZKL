//
//  PerformModel.m
//  ZKL
//
//  Created by champagne on 15-3-30.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "PerformModel.h"

@implementation PerformModel

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
             @"wasteMinute":@"wasteMinute",
             @"theDay":@"theDay",
             @"timeLine":@"timeLine",
             @"timeSwitch":@"timeSwitch",
             @"performID":@"id",
             @"createTime":@"createTime",
             @"lastUpdateTime":@"lastUpdateTime",
             @"viewState":@"viewState"
             };
}

@end


