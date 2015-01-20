//
//  UserInfo.m
//  ZYYG
//
//  Created by EMCC on 14/11/19.
//  Copyright (c) 2014年 EMCC. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (UserInfo*)shareUserInfo
{
    static UserInfo *userInfoInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        userInfoInstance = [[self alloc] init];
    });
    return userInfoInstance;
}



@end
