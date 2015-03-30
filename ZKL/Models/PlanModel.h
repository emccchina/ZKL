//
//  PlanModel.h
//  ZKL
//
//  Created by champagne on 15-3-23.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanModel : NSObject

@property (nonatomic, assign) long long planid;
@property (nonatomic, strong) NSString *planCode;// 编号
@property (nonatomic, strong) NSString *usercode;// 用户编号
@property (nonatomic, strong) NSString *superCode;// 上级任务
@property (nonatomic, strong) NSString *frontCode;// 前置任务
@property (nonatomic, strong) NSString *title;// 标题
@property (nonatomic, strong) NSString *content;// 内容
@property (nonatomic, strong) NSDate *beginDate;// 开始时间
@property (nonatomic, strong) NSDate *endDate;// 结束时间
@property (nonatomic, assign) long long totalMinute;// 所需总时间 分钟
@property (nonatomic, assign) long long planMinute;// 每日所需时间(24小时 = eachTime + unableTime + 浪费时间)分钟
@property (nonatomic, assign) long long unableMinute;// 每日无法使用的时间(休息时间)分钟
@property (nonatomic, assign) NSInteger dayCount;// 需要的天数
@property (nonatomic, assign) NSInteger priority;// 优先级 越小越优先
@property (nonatomic, strong) NSString *tag;// 标签(特殊任务标记)

@end
