//
//  ProgressCricleView.m
//  ZKL
//
//  Created by EMCC on 15/1/27.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "ProgressCricleView.h"

@implementation ProgressCricleView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    [self setup];
    if (!progressLabel) {
        progressLabel = [UILabel new];
        progressLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:172.0/255.0 blue:191.0/255.0 alpha:1.0];
        progressLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:progressLabel];
        progressLabel.font = [UIFont systemFontOfSize:10];
    }
    progressLabel.frame = CGRectInset(self.bounds, 5, 5);
    progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
}

- (void)setup
{
    CGFloat lineWidth = 6.f;
    CGFloat radius = CGRectGetWidth(self.bounds)/2 - lineWidth/2;
    if (!circleBig) {
        circleBig = [CAShapeLayer layer];
        CGRect rect = CGRectMake(lineWidth/2, lineWidth/2, radius * 2, radius * 2);
        circleBig.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    cornerRadius:radius].CGPath;
        
        circleBig.strokeColor = [UIColor colorWithRed:79.0/255.0 green:171.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
        circleBig.fillColor = nil;
        circleBig.lineWidth = lineWidth;
        circleBig.lineCap = kCALineCapRound;
        circleBig.lineJoin = kCALineJoinMiter;
        [self.layer addSublayer:circleBig];
    }
    
    
    if (!circleInside) {
        circleInside = [CAShapeLayer layer];
        CGRect rectInside = CGRectMake(lineWidth, lineWidth, radius * 2-lineWidth, radius * 2-lineWidth);
        circleInside.path = [UIBezierPath bezierPathWithRoundedRect:rectInside
                                                       cornerRadius:radius].CGPath;
        
        circleInside.strokeColor = nil;//[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3].CGColor;
        circleInside.fillColor = [UIColor colorWithRed:230.0/255.0 green:254.0/255.0 blue:250/255.0 alpha:1.0].CGColor;
        circleInside.lineWidth = 0;
        circleInside.lineCap = kCALineCapRound;
        circleInside.lineJoin = kCALineJoinMiter;
        [self.layer addSublayer:circleInside];
    }
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
