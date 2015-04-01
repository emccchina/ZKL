//
//  UserInfo.m
//  ZYYG
//
//  Created by EMCC on 14/11/19.
//  Copyright (c) 2014年 EMCC. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

static UserInfo *userInfoInstance = nil;

+ (UserInfo*)shareUserInfo
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        userInfoInstance = [[self alloc] init];
    });
    return userInfoInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.update = YES;
    }
    return self;
}

- (void)parseWithDict:(NSDictionary *)result
{
    //单例模式 只有一个实例化 所以合并在一起
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithJSONDictionary:result modelClass:[self class] error:nil];
    [self mergeValuesForKeysFromModel:adapter.model];
    
}

- (BOOL)isLogin
{
    if (!self.userCode || [self.userCode isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{
             @"userid":@"id",
             @"userCode":@"userCode",
             @"openid":@"openid",
             @"email":@"email",
             @"userName":@"userName",
             @"nickName":@"nickName",
             @"realName":@"realName",
             @"password":@"password",
             @"sex":@"sex",
             @"city":@"city",
             @"province":@"province",
             @"country":@"country",
             @"headimgurl":@"headimgurl",
             @"subscribeTime":@"subscribeTime",
             @"idCardNO":@"idCardNO",
             @"birthday":@"birthday",
             @"qq":@"qq",
             @"blog":@"blog",
             @"handPhone":@"handPhone",
             @"telphone":@"telphone",
             @"fax":@"fax",
             @"departmentCode":@"departmentCode",
             @"address":@"address",
             @"hobby":@"hobby",
             @"occupation":@"occupation",
             @"education":@"education",
             @"incomeLevel":@"incomeLevel",
             @"userState":@"userState"
             };
}

@end
