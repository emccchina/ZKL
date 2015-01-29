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

+ (UserInfo*)shareUserInfo; //全局共享的用户信息 单例模式

@property (strong, nonatomic) UIImage   *homeAddImage;

@end
