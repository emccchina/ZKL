//
//  NSDate+Agenda.h
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/3/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Agenda)

- (NSDate *)firstDayOfTheMonth;

- (NSDate *)lastDayOfTheMonth;
- (NSInteger)weekDay;
- (NSInteger)dayComponents;
- (NSInteger)quartComponents;
- (NSInteger)monthComponents;
- (NSInteger)yearComponents;
+ (NSCalendar *)gregorianCalendar;
+ (NSLocale *)locale;

+ (NSInteger)numberOfMonthFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSInteger)numberOfDaysInMonthForDate:(NSDate *)fromDate;

- (NSComparisonResult)compareWithMonth:(NSDate*)date;

- (BOOL)isToday;

- (NSDate*)preMonth;
- (NSDate*)nextMonth;

- (NSDate*)preYear;
- (NSDate*)nextYear;

- (NSDate *)dayOfNum:(int)numDay;

- (NSDate *)startingDate;
- (NSDate *)endingDate;
+ (NSArray *)weekdaySymbols;
+ (NSString *)monthSymbolAtIndex:(NSInteger)index;

@end
