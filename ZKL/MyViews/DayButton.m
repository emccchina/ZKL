//
//  DayButton.m
//  ZKL
//
//  Created by EMCC on 15/2/28.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "DayButton.h"
#import "NSDate+Agenda.h"
#import "FBShimmeringView.h"

@implementation DayButton

- (void)awakeFromNib
{
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:self.bounds];
//        [self addSubview:shimmeringView];
//        shimmeringView.contentView = self.titleLabel;
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        // Start shimmering.
//        shimmeringView.shimmering = YES;
//        shimmeringView.shimmeringSpeed = 50;
    }
    return self;
    
}

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
    if ([self.date isToday]) {
        self.layer.backgroundColor = kNavBGColor.CGColor;
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}


@end
