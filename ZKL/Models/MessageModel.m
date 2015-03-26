//
//  MessageModel.m
//  ZKL
//
//  Created by champagne on 15-3-26.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+(MessageModel *)initWithDict:(NSDictionary *)messageDict
{
    MessageModel *message=[[MessageModel init] alloc];
    message.errorno =[[messageDict safeObjectForKey:@"errorno"] integerValue];
    message.message =[messageDict safeObjectForKey:@"message"];
    message.result =messageDict[@"result"];
    return message;
}

@end
