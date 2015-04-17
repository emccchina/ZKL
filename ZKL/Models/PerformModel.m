//
//  PerformModel.m
//  ZKL
//
//  Created by champagne on 15-3-30.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "PerformModel.h"

@implementation PerformModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{
             @"planIDServer":@"planCode",
             @"planName":@"performName",
             @"performCode":@"theDay",
             @"planDream":@"planMinute",
             @"realDream":@"realPlanMinute",
             @"planRest":@"restMinute",
             @"realRest":@"realRestMinute"
             };
}

- (void)setFinished:(BOOL)finished
{
    _finished = finished;
}

- (BOOL)finished
{
    if (!self.realDream || !self.planDream || ![self.planDream floatValue]) {
        return NO;
    }
    return ([self.realDream floatValue]/[self.planDream floatValue] < 1) ? NO : YES;
}

- (void)setRealDream:(NSString *)realDream
{
    _realDream = realDream;
    [self realWasteTime];
}

- (void)realWasteTime
{
    NSInteger waste = 60*24-[_realRest integerValue]-[_realDream integerValue];
    if (waste <= 0) {
        _realWaste = 0;
        NSInteger rest = [_realRest integerValue] + waste;
        _realRest = [NSString stringWithFormat:@"%ld", (long)rest];
    }else{
        _realWaste = [NSString stringWithFormat:@"%ld",(long)waste];
    }
}


- (void)setRealRest:(NSString *)realRest
{
    _realRest = realRest;
    [self realWasteTime];
}



- (void)planWasteTime
{
    NSInteger waste = 60*24-[_realRest integerValue]-[_realDream integerValue];
    if (waste <= 0) {
        _planWaste = 0;
        NSInteger rest = [_realRest integerValue] + waste;
        _planRest = [NSString stringWithFormat:@"%ld", (long)rest];
    }else{
        _planWaste = [NSString stringWithFormat:@"%ld",(long)waste];
    }
}

- (void)setPlanDream:(NSString *)planDream
{
    _planDream = planDream;
    [self planWasteTime];
}
- (NSString*)planDream
{
    return  _planDream;
}
- (void)setPlanRest:(NSString *)planRest
{
    _planRest = planRest;
    _realRest = planRest;
    [self planWasteTime];
}

- (NSString*)planRest
{
    return _planRest;
}

- (void)setEditWasteTime
{
    NSInteger waste = 60*24-[_realRest integerValue]-[_realDream integerValue];
    if (waste <= 0) {
        _editWaste = 0;
        NSInteger rest = [_realRest integerValue] + waste;
        _editRest = [NSString stringWithFormat:@"%ld", (long)rest];
    }else{
        _editWaste = [NSString stringWithFormat:@"%ld",(long)waste];
    }
}

- (void)setEditDream:(NSString *)editDream
{
    _editDream = editDream;
    [self setEditWasteTime];
}

- (void)setEditRest:(NSString *)editRest
{
    _editRest = editRest;
    [self setEditWasteTime];
}

@end


