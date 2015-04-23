//
//  ProgressLineView.m
//  ZKL
//
//  Created by EMCC on 15/3/23.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "ProgressLineView.h"

@implementation ProgressLineView

- (void)awakeFromNib
{
    if (!humanView) {
        humanView = [[UIImageView alloc] init];
        [self addSubview:humanView];
    }
    
    //    humanView.image = [UIImage imageNamed:@"human1"];
    [humanView setContentMode:UIViewContentModeScaleAspectFill];
    
    humanView.animationDuration = 0.3;
//    [humanView startAnimating];
//    [humanView stopAnimating];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    CGFloat spaceH = height /10;

    CGFloat spaceMuli = (self.bottom ? 6 :2.5);
    CGFloat scale = [UIScreen mainScreen].scale;
    CGContextRef content = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(content, 1/scale);
    UIColor *lineColor = self.bottom ? [UIColor colorWithRed:37.0/255.0 green:192.0/255.0 blue:191.0/255.0 alpha:1] :[UIColor lightGrayColor];
    CGContextSetFillColorWithColor(content, lineColor.CGColor);
    CGContextAddRect(content, CGRectMake(0, height-spaceH*spaceMuli, width, 3));
    CGContextDrawPath(content, kCGPathFill);
    
    NSArray *points = @[@(width/3),@(width*2/3),@(width -  spaceH)];
    
    for (NSInteger i = 0; i < 3; i++) {
        CGFloat arcX = [points[i] floatValue];
        CGFloat arcY = height-spaceH*spaceMuli+1.5;
        CGFloat radius = 3;//spaceH /15;

        CGContextSetFillColorWithColor(content, [UIColor whiteColor].CGColor);
        CGContextMoveToPoint(content, arcX, arcY);
        CGContextAddArc(content, arcX, arcY, radius, 0, M_PI*2, 0);
        CGContextClosePath(content);
        CGContextDrawPath(content, kCGPathFill);
        
        if (i == 2) {
            if (!cupView) {
                cupView = [[UIImageView alloc] initWithFrame:CGRectMake(arcX-20, arcY-45, 40, 40)];
                [self addSubview:cupView];
            }
            cupView.image = [UIImage imageNamed:@"cup"];
        }else{
            radius = 10;
            
            CGFloat circleRaidus = arcY-20;
            CGContextSetFillColorWithColor(content, lineColor.CGColor);
            CGContextMoveToPoint(content, arcX, circleRaidus);
            CGContextAddArc(content, arcX, circleRaidus, radius, 0, M_PI, 1);
            CGContextAddLineToPoint(content, arcX, circleRaidus+radius*1.5);
            CGContextAddLineToPoint(content, arcX+radius, circleRaidus);
            CGContextClosePath(content);
            CGContextDrawPath(content, kCGPathFill);
            
            radius =5;
            CGContextSetFillColorWithColor(content, [UIColor whiteColor].CGColor);
            CGContextMoveToPoint(content, arcX, circleRaidus);
            CGContextAddArc(content, arcX, circleRaidus, radius, 0, M_PI*2, 0);
            CGContextClosePath(content);
            CGContextDrawPath(content, kCGPathFill);
            
            radius =2;
            CGContextSetFillColorWithColor(content, lineColor.CGColor);
            CGContextMoveToPoint(content, arcX, circleRaidus);
            CGContextAddArc(content, arcX, circleRaidus, radius, 0, M_PI*2, 0);
            CGContextClosePath(content);
            CGContextDrawPath(content, kCGPathFill);

        }
    }
    
    
    humanView.frame = CGRectMake(self.progress*width*0.8, height-spaceH*spaceMuli-80, 74, 74);
    UIFont *font3 = [UIFont fontWithName:kFontName size:15];
    CGSize size = [Utities sizeWithUIFont:font3 string:self.title];
    CGFloat x = 0;
    if (self.progress > 0.5) {
        x = width /2 - size.width/2+(self.progress-0.5)*width-75;
    }else{
        x = self.progress *width+75;
    }
    
    [self.title drawInRect:CGRectMake(x, height-spaceH*spaceMuli-80, size.width/2+10, size.height*2) withAttributes:@{NSForegroundColorAttributeName:kBlackColor, NSFontAttributeName:font3}];
    
    if (!self.bottom) {
        return;
    }
    [[NSString stringWithFormat:@"共奋斗了%ld小时", (long)self.totalTime] drawInRect:CGRectMake(20, height-spaceH*spaceMuli+30, size.width+10, size.height) withAttributes:@{NSForegroundColorAttributeName:kBlackColor, NSFontAttributeName:font3}];
    NSString *pr = [NSString stringWithFormat:@"共完成了%ld%%", (long)(self.progress*100)];
    CGSize sizePr = [Utities sizeWithUIFont:font3 string:pr];
    [pr drawInRect:CGRectMake(width - 20 - sizePr.width, height-spaceH*spaceMuli+30, size.width+10, size.height) withAttributes:@{NSForegroundColorAttributeName:kBlackColor, NSFontAttributeName:font3}];
    
    if (!bg) {
        bg = [CAShapeLayer layer];
    }
    
    CGRect rect1 = CGRectMake(20, height-spaceH*spaceMuli+55, width-50, 10);
    bg.path = [UIBezierPath bezierPathWithRoundedRect:rect1
                                         cornerRadius:5].CGPath;
    bg.fillColor = [UIColor lightGrayColor].CGColor;
    bg.lineCap = kCALineCapSquare;
    bg.lineJoin = kCALineJoinMiter;
    [self.layer addSublayer:bg];
    
    rect1.size.width *= self.progress;
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.cornerRadius = 5;
    colorLayer.frame    = rect1;//(CGRect){CGPointZero, CGSizeMake(200, 200)};
    [self.layer addSublayer:colorLayer];
    
    // 颜色分配
    colorLayer.colors = @[(__bridge id)[UIColor colorWithRed:24.0/255.0 green:75.0/255.0 blue:227.0/255.0 alpha:1].CGColor,
//                          (__bridge id)[UIColor colorWithRed:24.0/255.0 green:75.0/255.0 blue:227.0/255.0 alpha:1].CGColor,
                          (__bridge id)[UIColor colorWithRed:34.0/255.0 green:175.0/255.0 blue:97.0/255.0 alpha:1].CGColor];

    // 颜色分割线
    colorLayer.locations  = @[@(0.2), @(0.75)];
    
    // 起始点
    colorLayer.startPoint = CGPointMake(0, 0);
    
    // 结束点
    colorLayer.endPoint   = CGPointMake(1, 0);
}

- (void)animationDoing:(BOOL)doing
{
    if (doing) {
        NSArray *arr = [NSArray arrayWithObjects:[UIImage imageNamed:@"001"],[UIImage imageNamed:@"002"], nil];
        humanView.animationImages = arr;
        [humanView startAnimating];
    }else{
        [humanView stopAnimating];
        humanView.image = [UIImage imageNamed:@"003"];
    }
}


@end
