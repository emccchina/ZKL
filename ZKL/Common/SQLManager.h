//
//  SQLManager.h
//  ZKL
//
//  Created by EMCC on 15/4/2.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlanModel.h"
@interface SQLManager : NSObject
{
    FMDatabase *db;
    PlanModel *_myDoingPlan;
    PerformModel* _myDoingPerform;
}

@property (nonatomic, strong) PlanModel *myDoingPlan;

+ (SQLManager*)shareUserInfo;

- (void)openDB;

- (PlanModel*)doingPlan;

- (NSArray*)allPlan;

- (PerformModel*)myDoingPerform:(NSString*)planId;
- (NSArray*)allPerform:(NSString*)planId;

- (void)updatePerform:(PerformModel*)model;
- (void)updatePlan:(PlanModel*)planModel;

- (BOOL)writePlanModel:(PlanModel*)model;
- (BOOL)writePerformModel:(PerformModel*)model;
@end
