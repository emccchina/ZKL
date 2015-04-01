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

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{@"planid":@"",
             @"planCode":@"",
             @"usercode":@"",
             @"superCode":@"",
             @"frontCode":@"",
             @"title":@"",
             @"content":@"",
             @"beginDate":@"",
             @"endDate":@"",
             @"totalHour":@"",
             @"unableMinute":@"",
             @"planMinute":@"",
             @"dayCount":@"",
             @"priority":@"",
             @"tag":@"",
             @"performModels":@""
             };
}

+ (NSValueTransformer*)performModelsJSONTransformer{
    NSLog(@"arr transform");
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[PerformModel class]];
}

@end
