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
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (void)drawRect:(CGRect)rect
{
//    NSLog(@"my rect %@", NSStringFromCGRect(rect));
    NSArray *arr = @[@"doPreYear:",@"doNextYear:",@"doPreMonth:",@"doNextMonth:"];
    
    //计算有多少天
    NSInteger weekDay = [showDate weekDay];
    NSInteger items =  weekDay + [NSDate numberOfDaysInMonthForDate:showDate];
    
    CGFloat width = CGRectGetWidth(rect);
//    CGFloat height = CGRectGetHeight(rect);
    
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
    
    UIFont *font = [UIFont fontWithName:@"CourierNewPS-BoldItalicMT" size:20];
    NSString *year = [NSString stringWithFormat:@"%ld",(long)[showDate yearComponents]];
    CGSize sizeYear = [Utities sizeWithUIFont:font string:year];
    [year drawInRect:CGRectMake(xmargin*2-sizeYear.width/2, ymargin, sizeYear.width, arrowSize*2) withAttributes:@{NSForegroundColorAttributeName:kArrowsColor, NSFontAttributeName:font}];
    
    NSString *month = [NSString stringWithFormat:@"%02ld月",(long)[showDate monthComponents]];
    CGSize sizeMonth = [Utities sizeWithUIFont:font string:month];
    [month drawInRect:CGRectMake(xmargin*6-sizeMonth.width/2, ymargin, sizeMonth.width, arrowSize*2) withAttributes:@{NSForegroundColorAttributeName:kArrowsColor, NSFontAttributeName:font}];
//......................
    NSInteger numRows = (items/7+ (items%7?1:0));//[self numRows];
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
        UIFont *fontweek = [UIFont fontWithName:@"STHeitiTC-Medium" size:17];
        CGSize weekSize = [Utities sizeWithUIFont:fontweek string:weekdayValue];
        [weekdayValue drawInRect:CGRectMake((.5+i)*dayHeight-weekSize.width/2, -dayHeight/2-weekSize.height/2 +y, dayHeight, dayHeight) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:fontweek}];
    }
    
//画日期
    
    for (int i = 0; i < numRows*7; i++) {
        DayButton *day = [[DayButton alloc] initWithFrame:CGRectMake((i%7)*dayHeight, (i/7)*dayHeight+y, dayHeight, dayHeight)];
        [day setshowMonth:showDate showDay:[self dateAtItem:i]];
        [self addSubview:day];
        
    }
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
    [self setNeedsDisplay];
}

- (void)doNextYear:(id)sender
{
    showDate = [showDate nextYear];
    [self setNeedsDisplay];
}

- (void)doPreMonth:(id)sender
{
    showDate = [showDate preMonth];
    [self setNeedsDisplay];
}

- (void)doNextMonth:(id)sender
{
    showDate = [showDate nextMonth];
    [self setNeedsDisplay];
}

@end
