//
//  DoneShowView.m
//  ZKL
//
//  Created by EMCC on 15/3/23.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "DoneShowView.h"

@implementation DoneShowView

- (NSInteger)maxPoint
{
    NSInteger max = 0;
    for (NSDictionary *dict in self.points) {
        if ([dict[kTime] floatValue] > max) {
            max = [dict[kTime] floatValue]+1;
        }
    }
    return max;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    CGFloat spaceH = height /10;
    CGFloat spaceW = width / 20;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGContextRef content = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(content, 1/scale);
    UIColor *bgColor = [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1];
    CGContextSetFillColorWithColor(content, bgColor.CGColor);
    CGContextAddRect(content, CGRectMake(0, spaceH, width, height-spaceH*2));
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
    UIFont *font4 = [UIFont fontWithName:kFontName size:13];
    [@"时间比例" drawInRect:CGRectMake(width/2 - 50, spaceH*2-3, 150, 40) withAttributes:@{NSForegroundColorAttributeName:kBlackColor, NSFontAttributeName:font4}];
    
    UIColor *dreamColor = [UIColor colorWithRed:32.0/255.0 green:185.0/255.0 blue:230.0/255.0 alpha:1];
    UIColor *restColor = [UIColor colorWithRed:34.0/255.0 green:173.0/255.0 blue:188.0/255.0 alpha:1];
    UIColor *weasteColor = [UIColor colorWithRed:243.0/255.0 green:64.0/255.0 blue:43.0/255.0 alpha:1];
    
    CGFloat arcX = width/2-20;
    CGFloat arcY = spaceH*3+17;
    CGFloat radius = spaceH;
    CGContextSetFillColorWithColor(content, dreamColor.CGColor);
    CGContextMoveToPoint(content, arcX, arcY);
    CGContextAddArc(content, arcX, arcY, radius, 0, self.dreamTime*M_PI*2, 0);
    CGContextClosePath(content);
    CGContextDrawPath(content, kCGPathFill);
    
    CGContextSetFillColorWithColor(content, restColor.CGColor);
    CGContextMoveToPoint(content, arcX, arcY);
    CGContextAddArc(content, arcX, arcY, radius, self.dreamTime*M_PI*2, (self.dreamTime+self.restTime)*M_PI*2, 0);
    CGContextClosePath(content);
    CGContextDrawPath(content, kCGPathFill);
    
    CGContextSetFillColorWithColor(content, weasteColor.CGColor);
    CGContextMoveToPoint(content, arcX, arcY);
    CGContextAddArc(content, arcX, arcY, radius, (self.dreamTime+self.restTime)*M_PI*2, M_PI*2, 0);
    CGContextClosePath(content);
    CGContextDrawPath(content, kCGPathFill);
    
    CGContextSetFillColorWithColor(content, bgColor.CGColor);
    CGContextMoveToPoint(content, arcX, arcY);
    CGContextAddArc(content, arcX, arcY, radius-15, 0, M_PI*2, 0);
    CGContextClosePath(content);
    CGContextDrawPath(content, kCGPathFill);
    
    //..........................
    arcX = width/2 + spaceH*2;
    arcY = spaceH*3-10;
    radius = 3;//spaceH /15;
    CGContextSetFillColorWithColor(content, dreamColor.CGColor);
    CGContextMoveToPoint(content, arcX, arcY);
    CGContextAddArc(content, arcX, arcY, radius, 0, M_PI*2, 0);
    CGContextClosePath(content);
    CGContextDrawPath(content, kCGPathFill);
    UIFont *font5 = [UIFont fontWithName:kFontName size:10];
    CGSize size = [Utities sizeWithUIFont:font5 string:@"我"];
    
    [@"梦想" drawInRect:CGRectMake(arcX+10, arcY-size.height/2, 50, 30) withAttributes:@{NSForegroundColorAttributeName:kBlackColor, NSFontAttributeName:font5}];
    [[NSString stringWithFormat:@"%ld%%", (long)(self.dreamTime*100)] drawInRect:CGRectMake(arcX+40, arcY-size.height/2, 50, 30) withAttributes:@{NSForegroundColorAttributeName:dreamColor, NSFontAttributeName:font5}];
    arcY += spaceH /2;
    CGContextSetFillColorWithColor(content, restColor.CGColor);
    CGContextMoveToPoint(content, arcX, arcY);
    CGContextAddArc(content, arcX, arcY, radius, 0, M_PI*2, 0);
    CGContextClosePath(content);
    CGContextDrawPath(content, kCGPathFill);
    [@"休息" drawInRect:CGRectMake(arcX+10, arcY-size.height/2, 50, 30) withAttributes:@{NSForegroundColorAttributeName:kBlackColor, NSFontAttributeName:font5}];
    [[NSString stringWithFormat:@"%ld%%", (long)(self.restTime*100)] drawInRect:CGRectMake(arcX+40, arcY-size.height/2, 50, 30) withAttributes:@{NSForegroundColorAttributeName:restColor, NSFontAttributeName:font5}];
    
    arcY += spaceH /2;
    CGContextSetFillColorWithColor(content, weasteColor.CGColor);
    CGContextMoveToPoint(content, arcX, arcY);
    CGContextAddArc(content, arcX, arcY, radius, 0, M_PI*2, 0);
    CGContextClosePath(content);
    CGContextDrawPath(content, kCGPathFill);
    [@"虚度" drawInRect:CGRectMake(arcX+10, arcY-size.height/2, 50, 30) withAttributes:@{NSForegroundColorAttributeName:kBlackColor, NSFontAttributeName:font5}];
    [[NSString stringWithFormat:@"%ld%%", (long)((1-self.dreamTime-self.restTime)*100)] drawInRect:CGRectMake(arcX+40, arcY-size.height/2, 50, 30) withAttributes:@{NSForegroundColorAttributeName:weasteColor, NSFontAttributeName:font5}];
    
    NSLog(@"max is %ld", (long)[self maxPoint]);
    CGFloat spaceTime = (CGFloat)[self maxPoint]/5;
    
    for (int i = 0; i < 6; i++) {
        NSString *timeTitle = [NSString stringWithFormat:@"%.1fh", spaceTime*i];
        [timeTitle drawAtPoint:CGPointMake(width/2-85, height-spaceH*2-spaceH*0.5*i-7) withAttributes:@{NSForegroundColorAttributeName:kBlackColor, NSFontAttributeName:font5}];
        CGContextSetStrokeColorWithColor(content, [UIColor lightGrayColor].CGColor);
        CGContextMoveToPoint(content, width/2-60, height-spaceH*2-spaceH*0.5*i);
        CGContextAddLineToPoint(content, width-20, height-spaceH*2-spaceH*0.5*i);
        CGContextDrawPath(content, kCGPathStroke);
    }
    
    
    
    if (!self.points || !self.points.count) {
        return;
    }
    CGContextSetLineWidth(content, 1);
    CGFloat chatX = (width/2+40)/self.points.count;
    NSDate *startTime = [NSDate date];
    for (int i = 1; i < self.points.count; i++) {
        NSDictionary *dict = self.points[i];
        CGFloat time = [dict[kTime] floatValue];
        CGFloat x = chatX*i +width/2-60+chatX/2;
        CGFloat y = height-spaceH*2 - time/spaceTime*spaceH*0.5;
        CGContextSetFillColorWithColor(content, [UIColor colorWithRed:47.0/255.0 green:194.0/255.0 blue:196.0/255.0 alpha:.5].CGColor);
        NSDictionary *dictPre = self.points[i-1];
        CGFloat timePre = [dictPre[kTime] floatValue];
        CGFloat xPre = chatX*(i-1) +width/2-60+chatX/2;
        CGFloat yPre = height-spaceH*2 - timePre/spaceTime*spaceH*0.5;
        CGContextMoveToPoint(content, xPre, yPre);
        CGContextAddLineToPoint(content, x, y);
        CGContextAddLineToPoint(content, x, height-spaceH*2);
        CGContextAddLineToPoint(content, xPre, height-spaceH*2);
        CGContextClosePath(content);
        CGContextDrawPath(content, kCGPathFill);
    }
    
    for (int i = 0; i < self.points.count; i++) {
        NSDictionary *dict = self.points[i];
        CGFloat time = [dict[kTime] floatValue];
        CGFloat x = chatX*i +width/2-60+chatX/2;
        CGFloat y = height-spaceH*2 - time/spaceTime*spaceH*0.5;
        CGContextSetFillColorWithColor(content, [UIColor colorWithRed:47.0/255.0 green:194.0/255.0 blue:196.0/255.0 alpha:1].CGColor);
        CGContextMoveToPoint(content, x, y);
        CGContextAddArc(content, x, y, 3, 0, M_PI*2, 0);
        CGContextClosePath(content);
        CGContextDrawPath(content, kCGPathFill);
        NSString *dateTitle = dict[kDate];
        [dateTitle drawAtPoint:CGPointMake(x-10, height-spaceH*2+7) withAttributes:@{NSForegroundColorAttributeName:kBlackColor, NSFontAttributeName:font5}];
    }
    NSLog(@"%f",[startTime timeIntervalSinceNow]);
}


@end
