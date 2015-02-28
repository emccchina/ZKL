//
//  Mydate.m
//  ZKL
//
//  Created by EMCC on 15/2/26.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "Mydate.h"

@implementation Mydate

+ (NSDateComponents *)getNowDateComponents
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
//    calendar.locale = locale;
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:[NSDate date]];
    return comps;
}

@end
