//
//  SQLManager.m
//  ZKL
//
//  Created by EMCC on 15/4/2.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "SQLManager.h"
#import "NSDate+Agenda.h"
#define kDreamsTable        @"dreamsTable"
#define kProgressTable      @"progressTable"

#define kCreateTime         @"createTime"//每个梦想的标志
#define kTitle              @"title"
#define kBeginTime          @"beginTime"
#define kEndTime            @"endTime"
#define kTotalTime          @"totalTime"
#define kDayTime            @"dayTime"
#define kFinishedTime       @"finishedTime"
#define kFinished           @"finished"
#define kRestTime           @"restTime"

#define kEdit               @"edit"
#define kDate               @"date"
#define kPlanDream          @"planDream"
#define kPlanRest           @"planRest"
#define kPlanWaste          @"planWaste"
#define kRealDream           @"realDream"
#define kRealRest           @"realRest"
#define kRealWaste          @"realWaste"
#define kEditDream          @"editDream"
#define kEditRest           @"editRest"
#define kEditWaste          @"editWaste"

@implementation SQLManager

+ (SQLManager*)shareUserInfo
{
    static SQLManager *sqlManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sqlManagerInstance = [[self alloc] init];
    });
    return sqlManagerInstance;
}

- (PlanModel*)doingPlan
{
    if (![db open]) {
        return nil;
    }
    NSLog(@"doing plan");
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE id = (SELECT MAX(id)  FROM dreamsTable)", kDreamsTable];
    FMResultSet *provicesResult = [db executeQuery:sql];
    while ([provicesResult next]) {
        if (!_myDoingPlan) {
            _myDoingPlan = [[PlanModel alloc] init];
        }
        _myDoingPlan.planid = [provicesResult stringForColumn:kCreateTime];
        _myDoingPlan.title = [provicesResult stringForColumn:kTitle];
        _myDoingPlan.beginDate = [provicesResult stringForColumn:kBeginTime];
        _myDoingPlan.endDate = [provicesResult stringForColumn:kEndTime];
        _myDoingPlan.totalHour = [provicesResult stringForColumn:kTotalTime];
        _myDoingPlan.dayTime = [provicesResult stringForColumn:kDayTime];
        _myDoingPlan.finished = [provicesResult intForColumn:kFinished];
        
        return _myDoingPlan;
    }
    return nil;
}

- (PerformModel*)doingPerform:(NSString *)planId
{
    if (![db open]) {
        return nil;
    }
    NSLog(@"doing perform");
    if (!_myDoingPerform) {
        _myDoingPerform = [[PerformModel alloc] init];
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = ('%@') and %@ = ('%@')", kProgressTable, kCreateTime, planId, kDate, [NSDate stringFromDate:[NSDate date]]];
    FMResultSet *provicesResult = [db executeQuery:sql];
    while ([provicesResult next]) {
        _myDoingPerform.planId = [provicesResult stringForColumn:kCreateTime];
        _myDoingPerform.planDream = [provicesResult stringForColumn:kPlanDream];
        _myDoingPerform.planRest = [provicesResult stringForColumn:kPlanRest];
        _myDoingPerform.planWaste = [provicesResult stringForColumn:kPlanWaste];
        _myDoingPerform.realDream = [provicesResult stringForColumn:kRealDream];
        _myDoingPerform.realRest = [provicesResult stringForColumn:kRealRest];
        _myDoingPerform.realWaste = [provicesResult stringForColumn:kRealWaste];
        _myDoingPerform.edit  = [provicesResult intForColumn:kEdit];
        _myDoingPerform.editDream = [provicesResult stringForColumn:kEditDream];
        _myDoingPerform.editRest = [provicesResult stringForColumn:kEditRest];
        _myDoingPerform.editWaste = [provicesResult stringForColumn:kEditWaste];
        _myDoingPerform.performCode = [provicesResult stringForColumn:kDate];
        return _myDoingPerform;
    }
    _myDoingPerform.planId = [self myDoingPlan].planid;
    _myDoingPerform.planDream = [self myDoingPlan].dayTime;
    _myDoingPerform.planRest = [self myDoingPlan].restTime;
    _myDoingPerform.planWaste = [NSString stringWithFormat:@"%.0f",(24*60- [_myDoingPerform.planDream floatValue] - [_myDoingPerform.planRest floatValue])];
    _myDoingPerform.realDream = @"0";
    _myDoingPerform.realRest = [self myDoingPlan].restTime;
    _myDoingPerform.realWaste = [NSString stringWithFormat:@"%.0f",(24*60-[_myDoingPerform.planRest floatValue])];
    _myDoingPerform.edit = NO;
    _myDoingPerform.editDream = @"0";
    _myDoingPerform.editRest = @"0";
    _myDoingPerform.editWaste = @"0";
    _myDoingPerform.performCode = [NSDate stringFromDate:[NSDate date]];
    [self writePerformModel:_myDoingPerform];
    return _myDoingPerform;
}

- (PlanModel*)myDoingPlan
{
    if (_myDoingPlan) {
        return _myDoingPlan;
    }
    return [self doingPlan];
}

- (NSArray*)allPlan
{
    return [NSArray array];
}

- (PerformModel*)myDoingPerform:(NSString*)planId
{//取出当天的计划
    if (_myDoingPerform && [_myDoingPerform.performCode isEqualToString:[NSDate stringFromDate:[NSDate date]]]) {
        return _myDoingPerform;
    }
    return [self doingPerform:planId];
}
- (NSArray*)allPerform:(NSString*)planId
{
    return [NSArray array];
}

- (void)updatePerform:(PerformModel*)model
{

}
- (void)updatePlan:(PlanModel*)planModel
{
    
}

- (BOOL)writePerformModel:(PerformModel *)model
{
    NSString *string = [NSString stringWithFormat:@"insert into %@ (%@,%@, %@, %@,%@,%@,%@,%@,%@, %@,%@,%@) values ('%@','%@', '%@','%@','%@','%@','%@','%@','%@','%@','%@',%d);", kProgressTable, kCreateTime,kDate, kPlanDream,kPlanRest,kPlanWaste,kRealDream,kRealRest,kRealWaste,kEditDream,kEditRest,kEditWaste,kEdit,model.planId,model.performCode, model.planDream, model.planRest, model.planWaste, model.realDream, model.realRest, model.realWaste, model.editDream, model.editRest, model.editWaste, model.edit];
    BOOL success = [db executeStatements:string];
    if (success) {
        _myDoingPerform = model;
        return YES;
    }
    return NO;
}

- (BOOL)writePlanModel:(PlanModel*)model
{
    NSString *string = [NSString stringWithFormat:@"insert into %@ (%@, %@, %@,%@,%@,%@,%@,%@, %@) values ('%@', '%@','%@','%@','%@','%@','%d','%@','%@');", kDreamsTable, kCreateTime, kTitle, kBeginTime, kEndTime, kTotalTime, kDayTime, kFinished,kFinishedTime,kRestTime, model.planid, model.title, model.beginDate, model.endDate, model.totalHour, model.dayTime, model.finished, model.finishedTime, model.restTime];
    BOOL success = [db executeStatements:string];
    if (success) {
        _myDoingPlan = model;
        return YES;
    }
    return NO;
}

- (void)openDB
{
    [self createDB];
}
- (void)createDB
{
    NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath   = [docsPath stringByAppendingPathComponent:@"dream.db"];
    db     = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        return;
    }
    NSString *dreams = [NSString stringWithFormat:@"create table IF NOT EXISTS %@ (id integer primary key autoincrement,%@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ integer, %@ text, %@ text);", kDreamsTable, kCreateTime, kTitle,kBeginTime, kEndTime, kTotalTime, kDayTime, kFinished, kFinishedTime,kRestTime];
    NSString *progress = [NSString stringWithFormat:@"create table IF NOT EXISTS %@ (id integer primary key autoincrement,%@ text, %@ integer, %@ text, %@ text, %@ text, %@ text, %@ text,%@ text,%@ text,%@ text,%@ text,%@ text);", kProgressTable, kCreateTime,kEdit, kDate, kPlanDream, kPlanRest, kPlanWaste, kRealDream, kRealRest, kRealWaste,kEditDream,kEditRest,kEditWaste];
    NSString *sql = [NSString stringWithFormat:@"%@%@",dreams, progress];
    ;
    if (![db executeStatements:sql]) {
        NSLog(@"create table failed");
    }
    
}

@end
