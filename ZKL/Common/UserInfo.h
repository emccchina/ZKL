//
//  UserInfo.h
//  ZYYG
//
//  Created by EMCC on 14/11/19.
//  Copyright (c) 2014年 EMCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "PlanModel.h"
//User info 单例模式
@interface UserInfo : MTLModel
<MTLJSONSerializing>
/*
 MTLModel 类的解析 https://github.com/Mantle/Mantle 参考， 主要在实现+ (NSDictionary*)JSONKeyPathsByPropertyKey 这个协议 （MTLJSONSerializing），
 使用参考
 MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithJSONDictionary:result modelClass:[self class] error:nil];
 [self mergeValuesForKeysFromModel:adapter.model];
 
 或
 
 UserInfo* userInfo = [MTLJSONAdapter modelOfClass:[UserInfo Class] fromJSONDictionary:JSONDictionary error:&error];
 
 */
@property (strong, nonatomic) UIImage   *homeAddImage;
@property (strong, nonatomic) UIImage   *backImage;

@property (nonatomic, assign) long long userid;
@property (nonatomic, strong) NSString *userCode;// 系统产生的唯一码
@property (nonatomic, strong) NSString *openid;// 微信关注产生的(微信端用)
@property (nonatomic, strong) NSString *userName;// 用户名(app登陆用)
@property (nonatomic, strong) NSString *nickName;// 昵称
@property (nonatomic, strong) NSString *realName;// 真实姓名
@property (nonatomic, strong) NSString *password;// 密码
@property (nonatomic, strong) NSString *sex; // 性别 0 保密 1 男 2女
@property (nonatomic, strong) NSString *city;// 所在城市
@property (nonatomic, strong) NSString *province;// 所在省份
@property (nonatomic, strong) NSString *country;// 所属国家
@property (nonatomic, strong) NSString *headimgurl;// 头像地址
@property (nonatomic, strong) NSString *subscribeTime;// 关注时间
@property (nonatomic, strong) NSString *email; // 邮箱

@property (nonatomic, strong) NSString *idCardNO;// 身份证号码
@property (nonatomic, strong) NSString *birthday; // 生日
@property (nonatomic, strong) NSString *qq;// QQ
@property (nonatomic, strong) NSString *blog;// 博客或者主页
@property (nonatomic, strong) NSString *handPhone;// 手机
@property (nonatomic, strong) NSString *telphone; // 电话
@property (nonatomic, strong) NSString *fax; // 传真
@property (nonatomic, strong) NSString *departmentCode;// 单位编号
@property (nonatomic, strong) NSString *zipcode;// 邮编
@property (nonatomic, strong) NSString *homeAddress;// 家庭住址
@property (nonatomic, strong) NSString *address;// 通信地址
@property (nonatomic, strong) NSString *hobby;// 爱好
@property (nonatomic, strong) NSString *occupation;// 职业
@property (nonatomic, strong) NSString *education;// 学历
@property (nonatomic, strong) NSString *incomeLevel;// 收入水平
@property (nonatomic, assign) NSInteger userState; // 激活状态 0未激活 1激活

@property (nonatomic, assign) BOOL      update;//

@property (nonatomic, strong) PlanModel *doingPlan;

- (BOOL)isLogin;
+ (UserInfo*)shareUserInfo; //全局共享的用户信息 单例模式
- (void)parseWithDict:(NSDictionary*)result;
@end
