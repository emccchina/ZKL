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

- (void)setPerformDict:(NSDictionary *)dict
{
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithJSONDictionary:dict modelClass:self.class error:nil];
    [self mergeValuesForKeysFromModel:adapter.model];
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


