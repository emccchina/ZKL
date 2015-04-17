//
//  CanlendarView.m
//  ZKL
//
//  Created by EMCC on 15/2/27.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "CanlendarView.h"
#import "NSDate+Agenda.h"
#import "DayButton.h"
@interface CanlendarView()
{
    NSDate      *currentDate;
    NSDate      *showDate;
    NSInteger   items;
    NSInteger   numRows;
}
@property (strong, nonatomic) NSCalendar *calendar;

@end
#define kArrowsColor    [UIColor colorWithRed:89.0/255.0 green:213.0/255.0 blue:212.0/255.0 alpha:1.0]
#define kLineColor      [UIColor greenColor]
#define ENToChinese     [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"]

@implementation CanlendarView

- (void)awakeFromNib
{
    self.calendar = [NSDate gregorianCalendar];
    currentDate = [NSDate date];
    showDate = [[NSDate date] firstDayOfTheMonth];
//    self.userInteractionEnabled = YES;
    self.showFirstDate = [NSDate stringFromDate:[self dateAtItem:0]];
    self.showLastDate = [NSDate stringFromDate:[NSDate date]];
    [self setItemsAndNumRows];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (void)setItemsAndNumRows
{
    NSInteger weekDay = [showDate weekDay];
    items =  weekDay + [NSDate numberOfDaysInMonthForDate:showDate];
    numRows = (items/7+ (items%7?1:0));
    self.showFirstDate = [NSDate stringFromDate:[self dateAtItem:0]];
    self.showLastDate = [NSDate stringFromDate:[self dateAtItem:numRows*7-1]];

}

- (void)drawRect:(CGRect)rect
{
//    NSLog(@"my rect %@", NSStringFromCGRect(rect));
    NSArray *arr = @[@"doPreYear:",@"doNextYear:",@"doPreMonth:",@"doNextMonth:"];
    
    //计算有多少天
    
    
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    //清楚 重画
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    for (id subview in self.subviews) {
//        if ([subview isKindOfClass:[DayButton class]]) {
//            [subview removeFromSuperview];
//        }
//    }
    CGContextClearRect(UIGraphicsGetCurrentContext(),rect); //清除rect
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddRect(context, rect);
    CGContextFillPath(context);
    
//...........................
     //箭头+时间
     int arrowSize = 20;
     int xmargin = width/8;
     int ymargin = xmargin/4;

    CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, kArrowsColor.CGColor);
    CGContextSetLineWidth(context, 3);
    
    CGFloat x = 1;
    for (int i = 1; i < 8; i+=2) {
        CGContextMoveToPoint(context, xmargin*i, ymargin);
        CGContextAddLineToPoint(context,xmargin*i-x*arrowSize/2,ymargin+arrowSize/2);
        CGContextAddLineToPoint(context,xmargin*i,ymargin+arrowSize);
        x *= -1;
        
        UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(xmargin*i-arrowSize, 0, arrowSize*2, xmargin)];
        [but addTarget:self action:NSSelectorFromString(arr[i/2]) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but];
        
    }
    CGContextStrokePath(context);
    
    UIFont *font = [UIFont fontWithName:kFontName size:20];
    NSString *year = [NSString stringWithFormat:@"%ld",(long)[showDate yearComponents]];
    CGSize sizeYear = [Utities sizeWithUIFont:font string:year];
    [year drawInRect:CGRectMake(xmargin*2-sizeYear.width/2, ymargin, sizeYear.width, arrowSize*2) withAttributes:@{NSForegroundColorAttributeName:kArrowsColor, NSFontAttributeName:font}];
    
    NSString *month = [NSString stringWithFormat:@"%02ld月",(long)[showDate monthComponents]];
    CGSize sizeMonth = [Utities sizeWithUIFont:font string:month];
    [month drawInRect:CGRectMake(xmargin*6-sizeMonth.width/2, ymargin, sizeMonth.width, arrowSize*2) withAttributes:@{NSForegroundColorAttributeName:kArrowsColor, NSFontAttributeName:font}];
//......................
    //[self numRows];
    CGContextSetAllowsAntialiasing(context, NO);
    
    CGFloat y = xmargin;
    //周几的背景
    CGFloat dayHeight = width/7;
    CGContextBeginPath(context);
    CGContextAddRect(context, CGRectMake(0, y, width, dayHeight));
    CGContextSetFillColorWithColor(context, kArrowsColor.CGColor);
    CGContextFillPath(context);
    //日期的背景
    y += dayHeight;
    CGContextBeginPath(context);
    CGContextAddRect(context, CGRectMake(0, y, width, dayHeight*numRows));
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillPath(context);
    
//..............
    //画线
    CGFloat scale = 1/[UIScreen mainScreen].scale;
    //Grid white lines
    CGContextSetStrokeColorWithColor(context, kLineColor.CGColor);
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, scale);
    for (int i = 1; i <= numRows; i++) {
        CGContextMoveToPoint(context, 0, dayHeight*i+y);
        CGContextAddLineToPoint(context, width, dayHeight*i+y);
//        CGContextStrokePath(context);
    }
    for (int i = 1; i <= 7; i++) {
        CGContextMoveToPoint(context, dayHeight*i, y);
        CGContextAddLineToPoint(context, dayHeight*i, dayHeight*numRows+y);
        
    }
    CGContextStrokePath(context);

//.........................
    //画 周一 至周日
    NSArray *weekdays = [NSDate weekdaySymbols];
    for (int i =0; i<[weekdays count]; i++) {
        NSString *weekdayValue = (NSString *)[weekdays objectAtIndex:i];
        UIFont *fontweek = [UIFont fontWithName:kFontName size:17];
        CGSize weekSize = [Utities sizeWithUIFont:fontweek string:weekdayValue];
        [weekdayValue drawInRect:CGRectMake((.5+i)*dayHeight-weekSize.width/2, -dayHeight/2-weekSize.height/2 +y, dayHeight, dayHeight) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:fontweek}];
    }
    
//画日期
    
    for (int i = 0; i < numRows*7; i++) {
        DayButton *day = [[DayButton alloc] initWithFrame:CGRectMake((i%7)*dayHeight, (i/7)*dayHeight+y, dayHeight, dayHeight)];
        [day setshowMonth:showDate showDay:[self dateAtItem:i]];
        [self addSubview:day];
        
        [day addTarget:self action:@selector(doDayButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
//底部的
    y += numRows*dayHeight;
    CGContextSetFillColorWithColor(context, kNavBGColor.CGColor);
    CGContextAddRect(context, CGRectMake(0, y, width, height-y));
    CGContextDrawPath(context, kCGPathFill);

    y += dayHeight*.5;
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextAddRect(context, CGRectMake(0, y, width, dayHeight));
    CGContextDrawPath(context, kCGPathFill);
    
    UIFont *font3 = [UIFont fontWithName:kFontName size:15];
    NSString *stringLeft = @"本月累计获得奖杯数";
    CGSize sizeLeft = [Utities sizeWithUIFont:font3 string:stringLeft];
    [stringLeft drawInRect:CGRectMake(width/4-sizeLeft.width/2, y+(dayHeight-sizeLeft.height)/2, sizeLeft.width, sizeLeft.height) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:font3}];
    
    NSString *stringRight = @"累计获得奖杯数";
    CGSize sizeRight = [Utities sizeWithUIFont:font3 string:stringRight];
    [stringRight drawInRect:CGRectMake(width*3/4-sizeRight.width/2, y+(dayHeight-sizeRight.height)/2, sizeRight.width, sizeRight.height) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:font3}];
    
    y += dayHeight;
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 1);
    
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextAddRect(context, CGRectMake(10, y, width/2-20, height-y-dayHeight*.5));
    CGContextAddRect(context, CGRectMake(width/2+10, y, width/2-20, height-y-dayHeight*.5));
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    UIFont* font4 = [UIFont fontWithName:kFontName size:30];
    NSString*dateMonth1 = [NSDate stringFromDate:showDate];
    NSInteger cupsMonth = [[SQLManager shareUserInfo] cupsMonth:[dateMonth1 substringToIndex:7]];
    NSString *stringMonth = [NSString stringWithFormat:@"%ld",(long)cupsMonth];
    CGSize sizeMonth1 = [Utities sizeWithUIFont:font4 string:stringMonth];
    y += (height-y-dayHeight*.5 - sizeMonth1.height)/2;
    
    [stringMonth drawInRect:CGRectMake(width/4-sizeMonth1.width/2, y, sizeMonth1.width, sizeMonth1.height) withAttributes:@{NSForegroundColorAttributeName:kNavBGColor, NSFontAttributeName:font4}];
    
    NSString *totalCups = [NSString stringWithFormat:@"%ld",(long)[[SQLManager shareUserInfo] cupsTotal]];
    CGSize sizeMonth2 = [Utities sizeWithUIFont:font4 string:totalCups];
    [totalCups drawInRect:CGRectMake(width*3/4-sizeMonth2.width/2, y, sizeMonth2.width, sizeMonth2.height) withAttributes:@{NSForegroundColorAttributeName:kNavBGColor, NSFontAttributeName:font4}];
}

#pragma -mark private monthed

- (NSDate *)dateAtItem:(NSInteger)item
{
    NSInteger weekDay = [showDate weekDay];
    NSDate *dateToReturn = nil;
    dateToReturn = [showDate dayOfNum:item-weekDay+1];
    return dateToReturn;
}

#pragma -mark  events
- (void)doPreYear:(id)sender
{
    showDate = [showDate preYear];
    [self setItemsAndNumRows];
    [self setNeedsDisplay];
    if (self.changeMonth) {
        self.changeMonth(2);
    }
}

- (void)doNextYear:(id)sender
{
    showDate = [showDate nextYear];
    [self setItemsAndNumRows];
    [self setNeedsDisplay];
    if (self.changeMonth) {
        self.changeMonth(3);
    }
}

- (void)doPreMonth:(id)sender
{
    showDate = [showDate preMonth];
    [self setItemsAndNumRows];
    [self setNeedsDisplay];
    if (self.changeMonth) {
        self.changeMonth(0);
    }
}

- (void)doNextMonth:(id)sender
{
    showDate = [showDate nextMonth];
    [self setItemsAndNumRows];
    [self setNeedsDisplay];
    if (self.changeMonth) {
        self.changeMonth(1);
    }
}

- (void)doDayButton:(DayButton*)button
{
    NSLog(@"%@", button.date);
    if (self.doOneDay) {
        self.doOneDay(button);
    }
}

@end
