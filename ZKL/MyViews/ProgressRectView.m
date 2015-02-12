//
//  ProgressRectView.m
//  ZKL
//
//  Created by EMCC on 15/2/2.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "ProgressRectView.h"

@implementation ProgressRectView

- (void)setViewWithTitle:(NSString*)title progress:(CGFloat)progress
{
    self.backgroundColor = [UIColor clearColor];
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    if (!bg) {
        bg = [CAShapeLayer layer];
        CGRect rect = self.bounds;
        bg.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    cornerRadius:2].CGPath;
        bg.strokeColor = [UIColor whiteColor].CGColor;
        bg.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4].CGColor;
        bg.lineWidth = 2;
        bg.lineCap = kCALineCapRound;
        bg.lineJoin = kCALineJoinMiter;
        [self.layer addSublayer:bg];

    }
    if (!unFinished) {
        unFinished = [CAShapeLayer layer];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 10, height/2);
        CGPathAddLineToPoint(path, NULL, width-50, height/2);
        unFinished.path = [UIBezierPath bezierPathWithCGPath:path].CGPath;
        unFinished.strokeColor = [UIColor orangeColor].CGColor;
        unFinished.fillColor = [UIColor redColor].CGColor;
        unFinished.lineWidth = 5;
        unFinished.strokeStart = progress;
        unFinished.strokeEnd = 1;
        unFinished.lineCap = kCALineCapRound;
        unFinished.lineJoin = kCALineJoinMiter;
        [self.layer addSublayer:unFinished];
    }
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width-40, 0, 40, height)];
        titleLabel.font = [UIFont systemFontOfSize:10];
        titleLabel.textColor = [UIColor colorWithRed:67.0/255.0 green:164.0/255.0 blue:173.00/255.0 alpha:1.0];
        [self addSubview:titleLabel];
    }
    titleLabel.text = title;
}

@end
