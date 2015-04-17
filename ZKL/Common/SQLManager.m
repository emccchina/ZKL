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
#define kCreateTime         @"createTime"//每个梦想的标志
#define kTitle              @"title"
#define kBeginTime          @"beginTime"
#define kEndTime            @"endTime"
#define kTotalTime          @"totalTime"
#define kDayTime            @"dayTime"//每天完成了多少
#define kFinishedTime       @"finishedTime"//已经完成多少时间
#define kFinished           @"finished"//是否完成
#define kRestTime           @"restTime"//每天休息时间
#define kValid              @"valid"
#define kPlanIDServer       @"planIDOnServer"
#define kUpload             @"upload"


#define kProgressTable      @"progressTable"
#define kEdit               @"edit"//
#define kDate               @"date"//哪一天的
#define kPlanDream          @"planDream"
#define kPlanRest           @"planRest"
#define kPlanWaste          @"planWaste"
#define kRealDream           @"realDream"
#define kRealRest           @"realRest"
#define kRealWaste          @"realWaste"
#define kEditDream          @"editDream"
#define kEditRest           @"editRest"
#define kEditWaste          @"editWaste"
#define kCup                @"cups"//到这天为止奖杯总数

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

- (BOOL)invauildPlan
{
    NSDate *finishedDate = [NSDate dateFromString:_myDoingPlan.endDate];
    NSString *dat = [NSDate stringFromDate:[NSDate date]];
    NSDate *date = [NSDate dateFromString:dat];
    NSTimeInterval time = [date timeIntervalSinceDate:finishedDate];
    _myDoingPlan.lastDay = (time == 0);
    return time <= 0;
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
    if ([self selectPerform:planId date:[NSDate stringFromDate:[NSDate date]]]) {
        return _myDoingPerform;
    }
    _myDoingPerform.planId = [self myDoingPlan].planid;
    _myDoingPerform.planDream = [self myDoingPlan].dayTime;
    _myDoingPerform.planRest = [self myDoingPlan].restTime;
    _myDoingPerform.planWaste = [NSString stringWithFormat:@"%.0f",(24*60- [_myDoingPerform.planDream floatValue] - [_myDoingPerform.planRest floatValue])];
    _myDoingPerform.realDream = @"0";
    _myDoingPerform.realRest = [self myDoingPlan].restTime;
//    _myDoingPerform.realWaste = [NSString stringWithFormat:@"%.0f",(24*60-[_myDoingPerform.planRest floatValue])];
    _myDoingPerform.edit = NO;
    _myDoingPerform.editDream = @"0";
    _myDoingPerform.editRest = @"0";
    _myDoingPerform.editWaste = @"0";
    _myDoingPerform.performCode = [NSDate stringFromDate:[NSDate date]];
    _myDoingPerform.finished = NO;
    _myDoingPerform.upload = NO;
    _myDoingPerform.planIDServer = [self myDoingPlan].planIDServer;
    [self writePerformModel:_myDoingPerform];
    return _myDoingPerform;
}

- (PlanModel*)myDoingPlan
{
    if (_myDoingPlan) {
        if (![self invauildPlan]) {
            return nil;
        }
        return _myDoingPlan;
    }
    return [self doingPlan];
}

- (NSArray*)allPlan
{
    return [NSArray array];
}

- (NSArray*)uploadPerformModels
{
    if (![db open]) {
        return nil;
    }
    NSMutableArray* models = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = 0", kProgressTable, kUpload];
    FMResultSet *provicesResult = [db executeQuery:sql];
    while ([provicesResult next]) {
        PerformModel *model = [self performModelFromResult:provicesResult];
        if ([model.performCode isEqualToString:[NSDate stringFromDate:[NSDate date]]]) {
            continue;
        }
        [models addObject:model];
    }
    return models;
}

- (NSArray*)uploadPlanModels
{
    if (![db open]) {
        return nil;
    }
    NSMutableArray *models = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = 0 and %@=1", kDreamsTable, kUpload, kValid];
    FMResultSet *provicesResult = [db executeQuery:sql];
    while ([provicesResult next]) {
        [models addObject:[self planModelFromResult:provicesResult]];
    }
    return models;
}

- (PlanModel*)planModelFromResult:(FMResultSet*)provicesResult
{
    PlanModel *planModel = [[PlanModel alloc] init];
    planModel.tableRowID = [provicesResult intForColumn:@"id"];
    planModel.planid = [provicesResult stringForColumn:kCreateTime];
    planModel.title = [provicesResult stringForColumn:kTitle];
    planModel.beginDate = [provicesResult stringForColumn:kBeginTime];
    planModel.endDate = [provicesResult stringForColumn:kEndTime];
    planModel.totalHour = [provicesResult stringForColumn:kTotalTime];
    planModel.dayTime = [provicesResult stringForColumn:kDayTime];
    planModel.finished = [provicesResult intForColumn:kFinished];
    planModel.finishedTime = [provicesResult stringForColumn:kFinishedTime];
    planModel.restTime = [provicesResult stringForColumn:kRestTime];
    planModel.upload = [provicesResult intForColumn:kUpload];
    planModel.valid = [provicesResult intForColumn:kValid];
    planModel.planIDServer = [provicesResult stringForColumn:kPlanIDServer];
    return planModel;
}

- (PerformModel*)performModelFromResult:(FMResultSet*)provicesResult
{
    PerformModel *perforModelDate = [[PerformModel alloc] init];
    perforModelDate.planId = [provicesResult stringForColumn:kCreateTime];
    perforModelDate.planDream = [provicesResult stringForColumn:kPlanDream];
    perforModelDate.planRest = [provicesResult stringForColumn:kPlanRest];
    perforModelDate.planWaste = [provicesResult stringForColumn:kPlanWaste];
    perforModelDate.realDream = [provicesResult stringForColumn:kRealDream];
    perforModelDate.realRest = [provicesResult stringForColumn:kRealRest];
    //        _myDoingPerform.realWaste = [provicesResult stringForColumn:kRealWaste];
    perforModelDate.edit  = [provicesResult intForColumn:kEdit];
    perforModelDate.editDream = [provicesResult stringForColumn:kEditDream];
    perforModelDate.editRest = [provicesResult stringForColumn:kEditRest];
    perforModelDate.editWaste = [provicesResult stringForColumn:kEditWaste];
    perforModelDate.performCode = [provicesResult stringForColumn:kDate];
    perforModelDate.finished = [provicesResult intForColumn:kFinished];
    perforModelDate.upload = [provicesResult intForColumn:kUpload];
    perforModelDate.planIDServer = [provicesResult stringForColumn:kPlanIDServer];
    return perforModelDate;
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

- (void)openDB
{
    [self createDB];
}

#pragma -mark DB
- (void)createDB
{
    NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath   = [docsPath stringByAppendingPathComponent:@"dream.db"];
    db     = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        return;
    }
    NSString *dreams = [NSString stringWithFormat:@"create table IF NOT EXISTS %@ (id integer,%@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ integer, %@ text, %@ text,%@ integer,%@ integer,%@ text,PRIMARY KEY(%@));", kDreamsTable, kCreateTime, kTitle,kBeginTime, kEndTime, kTotalTime, kDayTime, kFinished, kFinishedTime,kRestTime, kValid, kUpload, kPlanIDServer,kPlanIDServer];
    NSString *progress = [NSString stringWithFormat:@"create table IF NOT EXISTS %@ (id integer,%@ text, %@ integer, %@ text , %@ text, %@ text, %@ text, %@ text,%@ text,%@ text,%@ text,%@ text,%@ text, %@ integer,%@ integer, %@ text, PRIMARY KEY(%@));", kProgressTable, kCreateTime,kEdit, kDate, kPlanDream, kPlanRest, kPlanWaste, kRealDream, kRealRest, kRealWaste,kEditDream,kEditRest,kEditWaste, kFinished, kUpload, kPlanIDServer, kDate];
    NSString *sql = [NSString stringWithFormat:@"%@%@",dreams, progress];
    ;
    if (![db executeStatements:sql]) {
        NSLog(@"create table failed");
    }
    
}

- (BOOL)writePerformModel:(PerformModel *)model
{
    if (![db open]) {
        return NO;
    }
    NSString *string = [NSString stringWithFormat:@"insert into %@ (%@,%@, %@, %@,%@,%@,%@,%@,%@, %@,%@,%@,%@,%@,%@) values ('%@','%@', '%@','%@','%@','%@','%@','%@','%@','%@','%@',%d,%d,%d,'%@');", kProgressTable, kCreateTime,kDate, kPlanDream,kPlanRest,kPlanWaste,kRealDream,kRealRest,kRealWaste,kEditDream,kEditRest,kEditWaste,kEdit,kFinished,kUpload,kPlanIDServer,model.planId,model.performCode, model.planDream, model.planRest, model.planWaste, model.realDream, model.realRest, model.realWaste, model.editDream, model.editRest, model.editWaste, model.edit, model.finished,model.upload,model.planIDServer];
    BOOL success = [db executeStatements:string];
    if (success) {
        _myDoingPerform = model;
        return YES;
    }
    return NO;
}

- (BOOL)writePlanModel:(PlanModel*)model
{
    if (![db open]) {
        return NO;
    }
    NSString *string = [NSString stringWithFormat:@"insert into %@ (%@, %@, %@,%@,%@,%@,%@,%@, %@,%@,%@,%@) values ('%@', '%@','%@','%@','%@','%@','%d','%@','%@','%d','%d','%@');", kDreamsTable, kCreateTime, kTitle, kBeginTime, kEndTime, kTotalTime, kDayTime, kFinished,kFinishedTime,kRestTime,kValid,kUpload,kPlanIDServer, model.planid, model.title, model.beginDate, model.endDate, model.totalHour, model.dayTime, model.finished, model.finishedTime, model.restTime,model.valid,model.upload, model.planIDServer];
    BOOL success = [db executeStatements:string];
    if (success) {
        _myDoingPlan = model;
        return YES;
    }
    return NO;
}

- (BOOL)existPerform:(NSString*)planID performID:(NSString*)performID
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = ('%@') and %@ = ('%@')", kProgressTable, kCreateTime, planID, kDate, performID];
    return [db executeStatements:sql];
}

- (void)updatePerform:(PerformModel*)model
{
    if (![db open]) {
        return;
    }
    NSString *string = [NSString stringWithFormat:@"update %@ set  %@ = %d, %@ = ('%@'), %@ = ('%@'),%@ = ('%@'),%@ = ('%@'),%@ = ('%@'),%@ = ('%@'),%@ = ('%@'),%@ = ('%@'),%@ = ('%@'),%@ = ('%@'),%@= ('%d'),%@= ('%d'),%@=%d where %@ = ('%@') and %@ = ('%@')", kProgressTable,kUpload,model.upload,kPlanIDServer,model.planIDServer, kRealDream, model.realDream, kRealWaste, model.realWaste,kRealRest,model.realRest,kPlanDream,model.planDream,kPlanRest,model.planRest,kPlanWaste,model.planWaste,kEditDream,model.editDream,kEditRest,model.editRest,kEditWaste,model.editWaste, kFinished, model.finished,kEdit,model.edit,kUpload,model.upload, kDate,model.performCode, kCreateTime, model.planId];
    BOOL success = [db executeStatements:string];
    if (success) {
        _myDoingPerform = model;
    }
}

- (BOOL)replacePlanModels:(NSArray*)models
{
    if (![db open]) {
        return NO;
    }
    NSMutableString *sqlString = [NSMutableString string];
    for (PlanModel *model in models) {
        NSString *string = [NSString stringWithFormat:@"replace into %@ (%@, %@, %@,%@,%@,%@,%@,%@, %@,%@,%@,%@) values ('%@','%@', '%@','%@','%@','%@','%@','%d','%@','%@','%d',1);", kDreamsTable,kPlanIDServer, kCreateTime, kTitle, kBeginTime, kEndTime, kTotalTime, kDayTime, kFinished,kFinishedTime,kRestTime,kValid,kUpload,model.planIDServer, model.planid, model.title, model.beginDate, model.endDate, model.totalHour, model.dayTime, model.finished, model.finishedTime, model.restTime,model.valid];
        [sqlString appendString:string];
    }
    
    return [db executeStatements:sqlString];
}
- (BOOL)replacePerformModels:(NSArray*)models
{
    if (![db open]) {
        return NO;
    }
    NSMutableString *sqlString = [NSMutableString string];
    for (PerformModel *model in models) {
        NSString *string = [NSString stringWithFormat:@"replace into %@ (%@,%@, %@, %@,%@,%@,%@,%@,%@, %@,%@,%@,%@,%@,%@) values ('%@','%@','%@', '%@','%@','%@','%@','%@','%@','%@','%@','%@',%d,%d,1);", kProgressTable,kDate,kPlanIDServer, kCreateTime, kPlanDream,kPlanRest,kPlanWaste,kRealDream,kRealRest,kRealWaste,kEditDream,kEditRest,kEditWaste,kEdit,kFinished,kUpload,model.performCode,model.planIDServer,model.planId, model.planDream, model.planRest, model.planWaste, model.realDream, model.realRest, model.realWaste, model.editDream, model.editRest, model.editWaste, model.edit, model.finished];
        [sqlString appendString:string];
    }
    return [db executeStatements:sqlString];
}

- (BOOL)existPlan:(NSString*)planID
{
    NSString *sql = [NSString stringWithFormat:@"SELECT Count(*) FROM %@ WHERE %@ = ('%@')", kDreamsTable, kCreateTime, planID];
    return [db executeStatements:sql];
}

- (void)updatePlan:(PlanModel*)planModel
{
    if (![db open]) {
        return;
    }
    NSString *string = [NSString stringWithFormat:@"update %@ set %@ = ('%@'),%@=('%d'),%@=('%d') where %@ = ('%@')", kDreamsTable, kFinishedTime, planModel.finishedTime,kFinished, planModel.finished,kUpload, planModel.upload, kCreateTime, planModel.planid];
    BOOL success = [db executeStatements:string];
    if (success) {
        _myDoingPlan = planModel;
    }
}

- (BOOL)updatePlanVlaid:(PlanModel*)model
{
    if (![db open]) {
        return NO;
    }
    NSString *string = [NSString stringWithFormat:@"update %@ set %@ = ('%d') where %@ = ('%@')", kDreamsTable, kValid, model.valid, kCreateTime, model.planid];
    return [db executeStatements:string];
    
}

- (BOOL)deletePerform:(PerformModel *)perform
{
    _myDoingPerform = nil;
    if (!perform) {
        return 0;
    }
    if (![db open]) {
        return 0;
    }
    NSString *sql = [NSString stringWithFormat:@"delete FROM %@ WHERE %@ = ('%@')", kProgressTable,kDate, perform.performCode];
    return  [db intForQuery:sql];
}

- (BOOL)selectPerform:(NSString*)planID date:(NSString*)date
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = ('%@') and %@ = ('%@')", kProgressTable, kCreateTime, planID, kDate, date];
    FMResultSet *provicesResult = [db executeQuery:sql];
    while ([provicesResult next]) {
        _myDoingPerform.planId = [provicesResult stringForColumn:kCreateTime];
        _myDoingPerform.planDream = [provicesResult stringForColumn:kPlanDream];
        _myDoingPerform.planRest = [provicesResult stringForColumn:kPlanRest];
        _myDoingPerform.planWaste = [provicesResult stringForColumn:kPlanWaste];
        _myDoingPerform.realDream = [provicesResult stringForColumn:kRealDream];
        _myDoingPerform.realRest = [provicesResult stringForColumn:kRealRest];
        //        _myDoingPerform.realWaste = [provicesResult stringForColumn:kRealWaste];
        _myDoingPerform.edit  = [provicesResult intForColumn:kEdit];
        _myDoingPerform.editDream = [provicesResult stringForColumn:kEditDream];
        _myDoingPerform.editRest = [provicesResult stringForColumn:kEditRest];
        _myDoingPerform.editWaste = [provicesResult stringForColumn:kEditWaste];
        _myDoingPerform.performCode = [provicesResult stringForColumn:kDate];
        _myDoingPerform.finished = [provicesResult intForColumn:kFinished];
        _myDoingPerform.upload = [provicesResult intForColumn:kUpload];
        _myDoingPerform.planIDServer = [provicesResult stringForColumn:kPlanIDServer];
        return YES;
    }
    return NO;
}

- (PerformModel*)cupsWithDate:(NSDate*)date
{
    NSString *dateString = [NSDate stringFromDate:date];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = ('%@')", kProgressTable, kDate, dateString];
    FMResultSet *provicesResult = [db executeQuery:sql];
    while ([provicesResult next]) {
        return [self performModelFromResult:provicesResult];
    }
    return nil;
}

- (NSInteger)cupsTotal
{
    if (![db open]) {
        return 0;
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM %@ WHERE %@ = 1", kProgressTable, kFinished];
    return  [db intForQuery:sql];
}

- (NSInteger)cupsMonth:(NSString *)month
{
    if (![db open]) {
        return 0;
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM %@ WHERE %@ like '%%%@%%' and %@=1", kProgressTable,kDate, month,kFinished];
    return  [db intForQuery:sql];
    
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
        _myDoingPlan = [self planModelFromResult:provicesResult];
        if (![self invauildPlan]) {
            return nil;
        }
        return _myDoingPlan;
    }
    return nil;
}

- (PlanModel*)lastPlan:(PlanModel*)model
{
    if (![db open]) {
        return nil;
    }
    NSLog(@"doing plan");
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where id < %ld and %@ = 1 and %@ = 1 order by id desc limit 1", kDreamsTable,(long)model.tableRowID, kFinished,kValid];
    FMResultSet *provicesResult = [db executeQuery:sql];
    while ([provicesResult next]) {
        return [self planModelFromResult:provicesResult];
    }
    return nil;
}

- (NSArray*)performsByPlan:(PlanModel*)plan
{
    if (!plan) {
        return nil;
    }
    if (![db open]) {
        return nil;
    }
    NSLog(@"doing plan");
    NSMutableArray *array = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ = ('%@')", kProgressTable, kCreateTime, plan.planid];
    FMResultSet *provicesResult = [db executeQuery:sql];
    while ([provicesResult next]) {
        [array addObject:[self performModelFromResult:provicesResult]];
    }
    return array;
}

@end
