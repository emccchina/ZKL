//
//  CanlendarView.h
//  ZKL
//
//  Created by EMCC on 15/2/27.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayButton.h"
typedef void (^DoOneDay) (DayButton* day);
typedef void (^ChangeMonth) (NSInteger type);//0 下月，1 上月，2 上年，3 下年
@interface CanlendarView : UIView

@property (nonatomic, copy) DoOneDay doOneDay;
@property (nonatomic, copy) ChangeMonth changeMonth;
@property (nonatomic, strong) NSString *showFirstDate;//显示的第一个日期
@property (nonatomic, strong) NSString *showLastDate;//显示的最后一个日期
@end
