//
//  MyDreamModel.h
//  ZKL
//
//  Created by EMCC on 15/2/26.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "MTLModel.h"

@interface MyDreamModel : MTLModel
<MTLJSONSerializing>

@property (nonatomic, strong) NSString      *name;//
@property (nonatomic, strong) NSDate        *startTime;//
@property (nonatomic, strong) NSDate        *endTime;//
@property (nonatomic, assign) CGFloat       progress;//已经完成多少

@end
