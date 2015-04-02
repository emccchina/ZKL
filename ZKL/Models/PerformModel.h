//
//  PerformModel.h
//  ZKL
//
//  Created by champagne on 15-3-30.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PerformModel : MTLModel
<MTLJSONSerializing>

@property (nonatomic, assign) BOOL      update;//是否需要更新
@property (nonatomic, strong) NSString *performCode;// 编号
@property (nonatomic, strong) NSString *userCode;// 用户
@property (nonatomic, strong) NSString *planCode;// 计划
@property (nonatomic, strong) NSString *performName;
@property (nonatomic, strong) NSDate *theDay;// 日期
@property (nonatomic, assign) NSInteger planMinute;// 计划的时间 (分钟)-可能是修改过的 默认是 planMinute
@property (nonatomic, assign) NSInteger realPlanMinute;// 实际使用的时间 (分钟)
@property (nonatomic, assign) NSInteger restMinute;// 实际使用的时间 (分钟)
@property (nonatomic, assign) NSInteger realRestMinute;// 实际使用的时间 (分钟)
@property (nonatomic, assign) NSInteger wasteMinute; // 虚度系统计算出来(24小时=realPlanMinute+realRestMinute+westeMinute)
@property (nonatomic, assign) long long timeLine; //时间线(后台用)
@property (nonatomic, strong) NSString *timeSwitch; //开关 (后台用)
@property (nonatomic, assign) NSInteger performID;
@property (nonatomic, assign) long long createTime;
@property (nonatomic, assign) long long lastUpdateTime;
@property (nonatomic, strong) NSString *viewState;

+ (PerformModel *)sharePerform;

- (void)setPerformDict:(NSDictionary*)dict;//

@end
