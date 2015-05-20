//
//  PlanModel.m
//  ZKL
//
//  Created by champagne on 15-3-23.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "PlanModel.h"
#import "PerformModel.h"
@implementation PlanModel

- (BOOL)doing
{
    return self.finished ? NO : _doing;
}

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{
             @"planIDServer":@"planCode",
             @"title":@"title",
             @"beginDate":@"beginDate",
             @"endDate":@"endDate",
             @"totalHour":@"planMinute",
             @"restTime":@"unableMinute",
             @"dayTime":@"dayCount"
             };
}

- (PerformModel*)doingPerform
{
    if (!_doingPerform) {
        //数据库查询
        _doingPerform = [[SQLManager shareUserInfo] myDoingPerform:self.planid];
    }
    return _doingPerform;
}

+ (NSValueTransformer*)performModelsJSONTransformer{
    NSLog(@"arr transform");
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[PerformModel class]];
}

@end
