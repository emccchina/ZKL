//
//  DoneShowView.h
//  ZKL
//
//  Created by EMCC on 15/3/23.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kTime       @"time"
#define kDate       @"date"

@interface DoneShowView : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat  dreamTime;
@property (nonatomic, assign) CGFloat  restTime;
@property (nonatomic, strong) NSArray   *points;

@end
