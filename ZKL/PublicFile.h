//
//  PublicFile.h
//  ZYYG
//
//  Created by wu on 14/11/22.
//  Copyright (c) 2014年 EMCC. All rights reserved.
//

#ifndef ZYYG_PublicFile_h
#define ZYYG_PublicFile_h

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#ifdef DEBUG
#define NSLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define NSLog( s, ... )
#endif

#define iPhone_iOS8        (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define kScreenWidth    CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight   CGRectGetHeight([UIScreen mainScreen].bounds)

#import "PublicDefine.h"
#import "Utities.h"
#import "UserInfo.h"
#import "POP.h"
#endif
