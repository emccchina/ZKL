//
//  NSDate+Agenda.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/3/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "NSDate+Agenda.h"
#import <objc/runtime.h>

const char * const JmoCalendarStoreKey = "jmo.calendar";
const char * const JmoLocaleStoreKey = "jmo.locale";

@implementation NSDate (Agenda)

#pragma mark - Getter and Setter

+ (void)setGregorianCalendar:(NSCalendar *)gregorianCalendar
{
    objc_setAssociatedObject(self, JmoCalendarStoreKey, gregorianCalendar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSCalendar *)gregorianCalendar
{
    NSCalendar* cal = objc_getAssociatedObject(self, JmoCalendarStoreKey);
    if (nil == cal) {
        cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [cal setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [cal setLocale:[self locale]];
        [self setGregorianCalendar:cal];
        
    }
    return cal;
}

+ (void)setLocal:(NSLocale *)locale
{
    objc_setAssociatedObject(self, JmoLocaleStoreKey, locale, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSLocale *)locale
{
    NSLocale *locale  = objc_getAssociatedObject(self, JmoLocaleStoreKey);
    if (nil == locale) {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
        [self setLocal:locale];
    }
    return locale;
}

#pragma mark -

-(NSDate *)dayOfNum:(NSInteger)numDay{
    NSCalendar *gregorian = [self.class gregorianCalendar];
    NSDateComponents *comps = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    [comps setDay:numDay];
    NSDate *day = [gregorian dateFromComponents:comps];
    return day;
}


- (NSDate *)firstDayOfTheMonth
{
    NSCalendar *gregorian = [self.class gregorianCalendar];
    NSDateComponents *comps = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    [comps setDay:1];
    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comps];
    return firstDayOfMonthDate;
}

- (NSDate *)lastDayOfTheMonth
{
    NSCalendar *gregorian = [self.class gregorianCalendar];
    NSDateComponents* comps = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:self];
    
    // set last of month
    [comps setMonth:[comps month]+1];
    [comps setDay:0];
    NSDate *lastDayOfMonthDate = [gregorian dateFromComponents:comps];
    return lastDayOfMonthDate;
}

+ (NSInteger)numberOfMonthFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *gregorian = [self gregorianCalendar];
    return [gregorian components:NSMonthCalendarUnit fromDate:fromDate toDate:toDate options:0].month+1;
}

+ (NSInteger)numberOfDaysInMonthForDate:(NSDate *)fromDate
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSRange range = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:fromDate];
    return range.length;
}

- (NSInteger)weekDay
{
    NSCalendar *gregorian = [self.class gregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:self];
    NSInteger weekday = [comps weekday]-1;//0 周日
    return weekday ;
}

- (NSComparisonResult)compareWithMonth:(NSDate *)date
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *otherDay = [calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    if([today month] == [otherDay month] &&
       [today year] == [otherDay year] &&
       [today era] == [otherDay era]) {
        return NSOrderedSame;
    }
    if([today month] < [otherDay month] &&
       [today year] <= [otherDay year] &&
       [today era] == [otherDay era]) {
        return NSOrderedDescending;
    }
    if([today month] > [otherDay month] &&
       [today year] >= [otherDay year] &&
       [today era] == [otherDay era]) {
        return NSOrderedAscending;
    }
    
    if([today year] < [otherDay year] &&
       [today era] == [otherDay era]) {
        return NSOrderedDescending;
    }
    if([today year] > [otherDay year] &&
       [today era] == [otherDay era]) {
        return NSOrderedAscending;
    }
    return NO;
}

- (BOOL)isToday
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *otherDay = [calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    if([today day] == [otherDay day] &&
       [today month] == [otherDay month] &&
       [today year] == [otherDay year] &&
       [today era] == [otherDay era]) {
        return YES;
    }
    return NO;
}

- (NSDate*)preMonth
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    [comps setMonth:[comps month]-1];
    return [calendar dateFromComponents:comps];
}
- (NSDate*)nextMonth
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    [comps setMonth:[comps month]+1];
    return [calendar dateFromComponents:comps];
}

- (NSDate*)preYear{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    [comps setYear:[comps year]-1];
    return [calendar dateFromComponents:comps];
}
- (NSDate*)nextYear{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    [comps setYear:[comps year]+1];
    return [calendar dateFromComponents:comps];
}

- (NSInteger)quartComponents
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    return comps.hour*4+(comps.minute/15);
}

- (NSInteger)dayComponents
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components: NSDayCalendarUnit fromDate:self];
    return comps.day;
}


- (NSInteger)monthComponents
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components: NSMonthCalendarUnit fromDate:self];
    return comps.month;
}

- (NSInteger)yearComponents
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit fromDate:self];
    return comps.year;
}

- (NSDate *)startingDate
{
    NSDateComponents *components = [[NSDate gregorianCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate gregorianCalendar] dateFromComponents:components];
}

- (NSDate *)endingDate
{
    NSDateComponents *components = [[NSDate gregorianCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    return [[NSDate gregorianCalendar] dateFromComponents:components];
}

+ (NSArray *)weekdaySymbols
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSMutableArray *upper = [NSMutableArray new];
    for (NSString *day in [dateFormatter shortWeekdaySymbols]) {
        [upper addObject:day.uppercaseString];
    }
    return  upper;
}

+ (NSString *)monthSymbolAtIndex:(NSInteger)index
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSArray *months = [dateFormatter monthSymbols];
    return months[index - 1];
}

+ (NSDate*)dateFromString:(NSString*)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:string];
    return destDate;
}

+ (NSString*)stringFromDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSString *destDate= [dateFormatter stringFromDate:date];
    return destDate;
}

+ (NSDate*)dayOfNumWithToday:(NSInteger)numDay
{
    NSCalendar *gregorian = [self.class gregorianCalendar];
    NSDateComponents *comps = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    [comps setDay:comps.day-1];
    NSDate *day = [gregorian dateFromComponents:comps];
    return day;
}

@end
