//
//  DayButton.h
//  ZKL
//
//  Created by EMCC on 15/2/28.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,  DayType) {
    KDayTypeEmpty,
    KDayTypeToday,
    KDayTypePast,//本月以前的
    KDayTypeFutur//本月以后的
};

typedef NS_ENUM(NSInteger, DayState) {
    kDayStateZone,//无
    kDayStateOne,//红点
    kDayStateTwo//奖杯
};

@interface DayButton : UIButton
{
    NSDate      *_date;
}
@property (nonatomic, assign) DayType   dayType;
@property (nonatomic, assign) DayState  dayState;
@property (nonatomic, strong) NSDate    *date;
- (void)setshowMonth:(NSDate *)showDate showDay:(NSDate*)dateDay;
@end
