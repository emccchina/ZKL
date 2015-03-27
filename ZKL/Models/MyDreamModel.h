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

@property (nonatomic, strong) NSString      *au;
@property (nonatomic, strong) NSString      *url;//
@property (nonatomic, strong) NSString      *pid;//
@property (nonatomic, strong) NSString      *pname;//
@property (nonatomic, strong) NSString      *pprice;//
@property (nonatomic, strong) NSString      *sid;//

@end
