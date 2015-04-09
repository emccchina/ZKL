//
//  SQLManager.h
//  ZKL
//
//  Created by EMCC on 15/4/2.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlanModel.h"

/*
 添加一个新梦想，写入数据库dreamsTable，
 同时创建当天perform，同时写入数据库progress，当开始计时时候 刷新数据库 增加完成时间，计算完成比例，
 调整梦想 相当于重新创建一个 同时这个无效，
 */
@interface SQLManager : NSObject
{
    FMDatabase *db;
    PlanModel *_myDoingPlan;
    PerformModel* _myDoingPerform;
}

@property (nonatomic, strong) PlanModel *myDoingPlan;
@property (nonatomic, assign) BOOL      running;//后台运行
@property (nonatomic, strong) NSDate    *runningBeginTime;
@property (nonatomic, assign) BOOL      runningState;//后台运行是是否计时
+ (SQLManager*)shareUserInfo;

- (void)openDB;

- (PlanModel*)doingPlan;//正在进行的梦想

- (NSArray*)allPlan;

- (PerformModel*)myDoingPerform:(NSString*)planId;//每天实现情况
- (NSArray*)allPerform:(NSString*)planId;
- (BOOL)deletePerform:(PerformModel*)perform;


- (void)updatePerform:(PerformModel*)model;
- (void)updatePlan:(PlanModel*)planModel;

- (BOOL)writePlanModel:(PlanModel*)model;
- (BOOL)writePerformModel:(PerformModel*)model;

- (BOOL)updatePlanVlaid:(PlanModel*)model;

- (NSInteger)cupsTotal;
- (NSInteger)cupsMonth:(NSString*)month;
- (PerformModel*)cupsWithDate:(NSDate*)date;
@end
