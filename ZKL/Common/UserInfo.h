//
//  UserInfo.h
//  ZYYG
//
//  Created by EMCC on 14/11/19.
//  Copyright (c) 2014年 EMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

//User info 单例模式
@interface UserInfo : NSObject

@property (strong, nonatomic) UIImage   *homeAddImage;
@property (strong, nonatomic) UIImage   *backImage;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, strong) NSString *userCode;

@property (nonatomic, strong) NSString *userName;// 用户名(登陆用)
@property (nonatomic, strong) NSString *nickName;// 昵称
@property (nonatomic, strong) NSString *realName;// 真实姓名
@property (nonatomic, strong) NSString *password;// 密码
@property (nonatomic, strong) NSString *departmentCode;// 单位编号
@property (nonatomic, strong) NSString *hobby;// 爱好
@property (nonatomic, strong) NSString *idCardNO;// 身份证号码
@property (nonatomic, strong) NSString *sex; // 性别 0 保密 1 男 2女
@property (nonatomic, strong) NSString *birthday; // 生日
@property (nonatomic, strong) NSString *email; // 邮箱
@property (nonatomic, strong) NSString *qq;// QQ
@property (nonatomic, strong) NSString *blog;// 博客或者主页
@property (nonatomic, strong) NSString *handPhone;// 手机
@property (nonatomic, strong) NSString *telphone; // 电话
@property (nonatomic, strong) NSString *fax; // 传真
@property (nonatomic, strong) NSString *zipcode;// 邮编
@property (nonatomic, strong) NSString *homeAddress;// 家庭住址
@property (nonatomic, strong) NSString *address;// 通信地址
@property (nonatomic, strong) NSString *occupation;// 职业
@property (nonatomic, strong) NSString *education;// 学历
@property (nonatomic, strong) NSString *incomeLevel;// 收入水平
@property (nonatomic, assign) NSInteger userState; // 激活状态 0未激活 1激活

+ (UserInfo*)shareUserInfo; //全局共享的用户信息 单例模式
- (UserInfo*)setParams:(UserInfo*)userInfo parmas:(NSDictionary *)param;

@end
