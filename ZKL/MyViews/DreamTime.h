//
//  DreamTime.h
//  ZKL
//
//  Created by EMCC on 15/1/23.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDuration                5
#define kBGColor                [UIColor colorWithRed:94.0/255.0 green:196.0/255.0 blue:211.0/255.0 alpha:1]
#define kBGLightColor           [UIColor colorWithRed:153.0/255.0 green:244.0/255.0 blue:235.0/255.0 alpha:1]
#define kOutsideColor           [UIColor colorWithRed:146.0/255.0 green:222.0/255.0 blue:228.0/255.0 alpha:1.0]
#define kProgressColor          [UIColor colorWithRed:50.0/255.0 green:172.0/255.0 blue:191.0/255.0 alpha:1.0]
#define kTextColor              [UIColor colorWithRed:57.0/255.0 green:168.0/255.0 blue:185.0/255.0 alpha:1.0]

typedef void (^TimePressed)(NSInteger type);

@interface DreamTime : UIControl

@property (nonatomic, copy) TimePressed  pressed;
@property (nonatomic, assign) NSInteger typeState;//什么状态，0添加   1暂停  2播放
- (void)start:(NSInteger)type;//0添加   1暂停  2播放

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;

@end


