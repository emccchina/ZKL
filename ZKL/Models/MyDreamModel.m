//
//  MyDreamModel.m
//  ZKL
//
//  Created by EMCC on 15/2/26.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "MyDreamModel.h"

@implementation MyDreamModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{
             @"au":@"AuthorIntro",
             @"url":@"Pic_Url",
             @"pid":@"Product_Id",
             @"pname":@"Product_Name",
             @"pprice":@"Product_Price",
             @"sid":@"Special_Id",
             };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error
{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self) {
        
    }
    return self;
}

@end
