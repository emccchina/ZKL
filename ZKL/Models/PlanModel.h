//
//  PlanModel.h
//  ZKL
//
//  Created by champagne on 15-3-23.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PerformModel.h"

@interface PlanModel : MTLModel
<MTLJSONSerializing>
{
    BOOL    _doing;
    PerformModel *_doingPerform;
}
@property (nonatomic, assign) NSInteger tableRowID;

@property (nonatomic, strong) NSString *planid;
@property (nonatomic, strong) NSString *planCode;// 编号
@property (nonatomic, strong) NSString *usercode;// 用户编号
@property (nonatomic, strong) NSString *superCode;// 上级任务
@property (nonatomic, strong) NSString *frontCode;// 前置任务
@property (nonatomic, strong) NSString *title;// 标题
@property (nonatomic, strong) NSString *content;// 内容
@property (nonatomic, strong) NSString *beginDate;// 开始时间
@property (nonatomic, strong) NSString *endDate;// 结束时间
@property (nonatomic, strong) NSString *totalHour;// 所需总时间 分钟
@property (nonatomic, assign) long long planMinute;// 每日所需时间(24小时 = eachTime + unableTime + 浪费时间)分钟
@property (nonatomic, assign) long long unableMinute;// 每日无法使用的时间(休息时间)分钟
@property (nonatomic, assign) NSInteger dayCount;// 需要的天数
@property (nonatomic, assign) NSInteger priority;// 优先级 越小越优先
@property (nonatomic, strong) NSString *tag;// 标签(特殊任务标记)
@property (nonatomic, strong) NSArray   *performModels;
@property (nonatomic, assign) BOOL      finished;
@property (nonatomic, assign) BOOL      doing;
@property (nonatomic, strong) NSString *dayTime;
@property (nonatomic, strong) NSString *finishedTime;
@property (nonatomic, strong) NSString *restTime;
@property (nonatomic, assign) BOOL      valid;//是否有效修改过没有
@property (nonatomic, strong) PerformModel *doingPerform;
@property (nonatomic, assign) BOOL      lastDay;//是否是完成梦想的最后一天
@end
