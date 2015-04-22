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
        
        cup = [CAShapeLayer layer];
        cup.frame = CGRectMake(CGRectGetWidth(frame)*2/3, CGRectGetHeight(frame)*2/3, CGRectGetWidth(frame)/3, CGRectGetWidth(frame)/3);
        cup.contents = (id)[UIImage imageNamed:@"cup"].CGImage;
//        cup.backgroundColor = [UIColor orangeColor].CGColor;
        [self.layer addSublayer:cup];
        
        redPoint = [CAShapeLayer layer];
        redPoint.frame = CGRectMake(CGRectGetWidth(frame)/2-2, CGRectGetHeight(frame)-10, 4, 4);
        redPoint.cornerRadius = 2;
        redPoint.backgroundColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:redPoint];
        
        cup.hidden = YES;
        redPoint.hidden = YES;
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
            titleColor = [UIColor lightGrayColor];
        }
        default:
            break;
    }
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    if ([self.date isToday]) {
        self.layer.backgroundColor = kNavBGColor.CGColor;
    }
    self.performModel = [[SQLManager shareUserInfo] cupsWithDate:dateDay];
    if (self.performModel.finished) {
        [self setDayState:kDayStateTwo];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    }
}

- (void)setDayState:(DayState)dayState
{
    switch (dayState) {
        case kDayStateZone:
        {
            cup.hidden = YES;
            redPoint.hidden = YES;
        }break;
        case kDayStateOne:
        {
            cup.hidden = YES;
            redPoint.hidden = NO;
        }break;
        case kDayStateTwo:
        {
            cup.hidden = NO;
            redPoint.hidden = YES;
        }break;
            
        default:
            break;
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}


@end
