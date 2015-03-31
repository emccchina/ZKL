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

-(UserInfo *)setParams:(UserInfo *)userInfo parmas:(NSDictionary *)param
{
    userInfo.userid=[[param safeObjectForKey:@"userid"] longLongValue];
    userInfo.userCode=[param safeObjectForKey:@"userCode"];
    userInfo.openid=[param safeObjectForKey:@"openid"];
    userInfo.userName=[param safeObjectForKey:@"userName"];
    userInfo.nickName=[param safeObjectForKey:@"nickName"];
    userInfo.realName=[param safeObjectForKey:@"realName"];
    userInfo.password=[param safeObjectForKey:@"password"];
    userInfo.sex=[[param safeObjectForKey:@"sex"] integerValue] == 1?@"男":@"女" ;
    userInfo.city=[param safeObjectForKey:@"city"];
    userInfo.province=[param safeObjectForKey:@"province"];
    userInfo.country=[param safeObjectForKey:@"country"];
    userInfo.headimgurl=[param safeObjectForKey:@"headimgurl"];
    userInfo.subscribeTime=[param safeObjectForKey:@"subscribeTime"];
    userInfo.email=[param safeObjectForKey:@"email"];
    
    userInfo.idCardNO=[param safeObjectForKey:@"idCardNO"];
    userInfo.birthday=[param safeObjectForKey:@"birthday"];
    userInfo.qq=[param safeObjectForKey:@"qq"];
    userInfo.blog=[param safeObjectForKey:@"blog"];
    userInfo.handPhone=[param safeObjectForKey:@"handPhone"];
    userInfo.telphone=[param safeObjectForKey:@"telphone"];
    userInfo.fax=[param safeObjectForKey:@"fax"];
    userInfo.departmentCode=[param safeObjectForKey:@"departmentCode"];
    userInfo.zipcode=[param safeObjectForKey:@"zipcode"];
    userInfo.homeAddress=[param safeObjectForKey:@"homeAddress"];
    userInfo.address=[param safeObjectForKey:@"address"];
    userInfo.hobby=[param safeObjectForKey:@"hobby"];
    userInfo.occupation=[param safeObjectForKey:@"occupation"];
    userInfo.education=[param safeObjectForKey:@"education"];
    userInfo.incomeLevel=[param safeObjectForKey:@"incomeLevel"];
    userInfo.userState=[[param safeObjectForKey:@"userState"] integerValue];
    return userInfo;
}

@end
