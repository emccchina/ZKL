//
//  MessageModel.m
//  ZKL
//
//  Created by champagne on 15-3-26.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{
             @"errorno":@"errorno",
             @"message":@"message",
             @"result":@"result",
             };
}


@end
