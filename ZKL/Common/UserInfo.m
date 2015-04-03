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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.update = YES;
        self.homeAddImage = [Utities homeAddImage];
        self.backImage = [self myBackImage];
    }
    return self;
}

- (UIImage*)myBackImage
{
    CGFloat width = 22;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, width), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color = [UIColor colorWithRed:235.0/255.0 green:247.0/255.0 blue:239.0/255.0 alpha:1.0];
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    CGContextSetLineWidth(context, 2);
    CGFloat radius = 5;
    CGContextMoveToPoint(context, width/2+radius, width/2- 3*radius);
    CGContextAddLineToPoint(context, width/2-radius*2, width/2) ;
    CGContextAddLineToPoint(context, width/2+radius, width/2+3*radius);
    //    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
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
