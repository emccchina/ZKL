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
{
    NSString *_realDream;
    NSString *_realRest;
    NSString *_realWaste;
    
    NSString *_planDream;
    NSString *_planRest;
    NSString *_planWaste;
    NSString *_editDream;
    NSString *_editRest;
    NSString *_editWaste;
    BOOL        _finished;
}

@property (nonatomic, strong) NSString *planId;
@property (nonatomic, strong) NSString *performCode;//日期计
@property (nonatomic, strong) NSString *planName;
@property (nonatomic, strong) NSDate *theDay;// 日期
@property (nonatomic, strong) NSString *planDream;// 计划的时间 (分钟)-可能是修改过的 默认是 planMinute
@property (nonatomic, strong) NSString *planRest;
@property (nonatomic, strong) NSString *planWaste;
@property (nonatomic, strong) NSString *realDream;
@property (nonatomic, strong) NSString *realRest;
@property (nonatomic, strong) NSString *realWaste;
@property (nonatomic, strong) NSString *editDream;
@property (nonatomic, strong) NSString *editRest;
@property (nonatomic, strong) NSString *editWaste;
@property (nonatomic, assign) NSInteger cups;

@property (nonatomic, assign) BOOL finished;
@property (nonatomic, assign) BOOL edit;

@property (nonatomic, assign) BOOL  upload;
@property (nonatomic, strong) NSString *planIDServer;

@end
