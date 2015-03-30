//
//  PerformModel.m
//  ZKL
//
//  Created by champagne on 15-3-30.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "PerformModel.h"

@implementation PerformModel

+(PerformModel *)initWithDict:(NSDictionary *)performDict
{
    PerformModel *perform=[[PerformModel init] alloc];
    perform.performCode = [performDict safeObjectForKey:@"performCode"];
    perform.userCode = [performDict safeObjectForKey:@"userCode"];
    perform.planCode = [performDict safeObjectForKey:@"planCode"];
//    perform.theDay = [[performDict safeObjectForKey:@"theDay"] ];
    perform.planMinute = [[performDict safeObjectForKey:@"planMinute"] integerValue];
    perform.realPlanMinute = [[performDict safeObjectForKey:@"realPlanMinute"] integerValue];
    perform.restMinute = [[performDict safeObjectForKey:@"restMinute"] integerValue];
    perform.realRestMinute = [[performDict safeObjectForKey:@"realRestMinute"] integerValue];
    perform.wasteMinute = [[performDict safeObjectForKey:@"wasteMinute"] integerValue];
    return perform;
}
@end
