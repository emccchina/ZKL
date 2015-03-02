//
//  DayButton.m
//  ZKL
//
//  Created by EMCC on 15/2/28.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "DayButton.h"
#import "NSDate+Agenda.h"

@implementation DayButton

- (void)setshowMonth:(NSDate *)showDate showDay:(NSDate*)dateDay
{
    _date = dateDay;
    [self setTitle:[NSString stringWithFormat:@"%ld", (long)([dateDay dayComponents])] forState:UIControlStateNormal];
    NSComparisonResult result = [dateDay compareWithMonth:showDate];
    UIColor *titleColor = nil;
    switch (result) {
        case NSOrderedAscending:
        {
            self.dayType = KDayTypePast;
            titleColor = [UIColor lightGrayColor];
        }break;
        case NSOrderedSame:{
            self.dayType = KDayTypeToday;
            titleColor = [UIColor whiteColor];
        }break;
        case NSOrderedDescending:{
            self.dayType = KDayTypeFutur;
            titleColor = [UIColor redColor];
        }
        default:
            break;
    }
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if ([self.date isToday]) {
        self.layer.backgroundColor = kNavBGColor.CGColor;
    }
}


@end
