//
//  DoingShowView.m
//  ZKL
//
//  Created by EMCC on 15/3/20.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "DoingShowView.h"

@implementation DoingShowView


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    CGFloat spaceH = height / 11;
    CGFloat spaceW = width / 20;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGContextRef content = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(content, 1/scale);
    UIColor *bgColor = [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1];
    CGContextSetFillColorWithColor(content, bgColor.CGColor);
    CGContextAddRect(content, CGRectMake(0, spaceH, width, height-spaceH*4));
    CGContextDrawPath(content, kCGPathFill);
    
    UIFont *font3 = [UIFont fontWithName:kFontName size:20];
    CGSize sizeTitle = [Utities sizeWithUIFont:font3 string:self.title];
    CGContextSetFillColorWithColor(content, [UIColor colorWithRed:250.0/255.0 green:26.0/255.0 blue:92.0/255.0 alpha:1].CGColor);
    CGContextAddRect(content, CGRectMake(spaceW, spaceH/2, spaceW*5+sizeTitle.width, spaceH));
    CGContextDrawPath(content, kCGPathFill);
    
    CGContextSetFillColorWithColor(content, [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6].CGColor);
    CGContextMoveToPoint(content, spaceW*3+sizeTitle.width, spaceH/2);
    CGContextAddLineToPoint(content, spaceW*6+sizeTitle.width, spaceH/2);
    CGContextAddLineToPoint(content, spaceW*6+sizeTitle.width, spaceH*3/2);
    CGContextDrawPath(content, kCGPathFill);
    
    [self.title drawInRect:CGRectMake(spaceW*2, spaceH-(sizeTitle.height)/2, sizeTitle.width, sizeTitle.height) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:font3}];
    
    if (!progressView) {
        progressView = [[ProgressLineView alloc] initWithFrame:CGRectMake(0, spaceH*2, width, (iPhone4 ?spaceH*8 : spaceH*6))];
        [self addSubview:progressView];
    }
    progressView.progress = (self.progress <=1 ? : 1);
    progressView.title = self.dio;
    progressView.backgroundColor = [UIColor clearColor];
    progressView.totalTime = self.progress*self.totalTime;
    progressView.bottom = self.buttom;
    
}


@end
