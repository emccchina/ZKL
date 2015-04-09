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

- (void)setRealDream:(NSString *)realDream
{
    _realDream = realDream;
    [self realWasteTime];
}

- (void)realWasteTime
{
    NSInteger waste = 60*24-[_realRest integerValue]-[_realDream integerValue];
    if (waste <= 0) {
        _realWaste = 0;
        NSInteger rest = [_realRest integerValue] + waste;
        _realRest = [NSString stringWithFormat:@"%ld", (long)rest];
    }else{
        _realWaste = [NSString stringWithFormat:@"%ld",(long)waste];
    }
}


- (void)setRealRest:(NSString *)realRest
{
    _realRest = realRest;
    [self realWasteTime];
}

@end


