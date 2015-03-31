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

-(PerformModel *)setParams:(PerformModel *)perform parmas:(NSDictionary *)performDict
{
    perform.performCode = [performDict safeObjectForKey:@"performCode"];
    perform.userCode = [performDict safeObjectForKey:@"userCode"];
    perform.planCode = [performDict safeObjectForKey:@"planCode"];
    perform.performName = [performDict safeObjectForKey:@"performName"];
    //    perform.theDay = [[performDict safeObjectForKey:@"theDay"] ];
    perform.planMinute = [[performDict safeObjectForKey:@"planMinute"] integerValue];
    perform.realPlanMinute = [[performDict safeObjectForKey:@"realPlanMinute"] integerValue];
    perform.restMinute = [[performDict safeObjectForKey:@"restMinute"] integerValue];
    perform.realRestMinute = [[performDict safeObjectForKey:@"realRestMinute"] integerValue];
    perform.wasteMinute = [[performDict safeObjectForKey:@"wasteMinute"] integerValue];
    return perform;
}


@end


