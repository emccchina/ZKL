//
//  ProgressRectView.m
//  ZKL
//
//  Created by EMCC on 15/2/2.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "ProgressRectView.h"
#import "RichStyleLabel.h"

@implementation WhorlLayer

- (void)setup
{
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    self.layer.cornerRadius = 5;
    self.layer.backgroundColor = [UIColor redColor].CGColor;
//    CAShapeLayer *bg = [CAShapeLayer layer];
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 0, self.frame.size.height/2);
//    CGPathAddLineToPoint(path, NULL, self.frame.size.width,self.frame.size.height/2);
//    bg.path = [UIBezierPath bezierPathWithCGPath:path].CGPath;
//    bg.strokeColor = [UIColor redColor].CGColor;
//    bg.fillColor = [UIColor redColor].CGColor;
//    bg.lineWidth = self.frame.size.height;
//    bg.strokeStart = 0;//progress;
//    bg.strokeEnd = 1;
//    bg.lineCap = kCALineCapRound;
//    bg.lineJoin = kCALineJoinMiter;
//    [self.layer addSublayer:bg];
//    CGPathRelease(path);
    
    UIColor* barColor =  [UIColor colorWithRed:30.0f/256.0f green:104.0f/256.0f blue:209.0f/256.0f alpha:1];
    CALayer* barberPoleLayer = [CALayer layer];
    barberPoleLayer.frame = self.bounds;
    CALayer* barberPoleMaskLayer = [CALayer layer];
    barberPoleMaskLayer.frame = self.bounds;
    barberPoleMaskLayer.cornerRadius = self.frame.size.height/2;
    // mask doesnt work without a solid background
    barberPoleMaskLayer.backgroundColor = [UIColor whiteColor].CGColor;
    barberPoleLayer.mask = barberPoleMaskLayer;
    
    self.barberPoleStripWidth = 5;
    CGRect frame = self.frame;
    CALayer* barberStrip = [CALayer layer];
    barberStrip.frame = CGRectMake(0,0,self.barberPoleStripWidth * 2,frame.size.height);
    
    CGMutablePathRef stripPath = CGPathCreateMutable();
    CGPathMoveToPoint(stripPath, nil, 0, 0);
    CGPathAddLineToPoint(stripPath, nil, self.barberPoleStripWidth, 0);
    CGPathAddLineToPoint(stripPath, nil, self.barberPoleStripWidth * 2, barberStrip.frame.size.height);
    CGPathAddLineToPoint(stripPath, nil, self.barberPoleStripWidth, barberStrip.frame.size.height);
    
    CAShapeLayer* stripShape = [CAShapeLayer layer];
    stripShape.fillColor = barColor.CGColor;
    stripShape.path = stripPath;
    
    [barberStrip addSublayer:stripShape];
    CGPathRelease(stripPath);
    
    self.replicatorLayer= [CAReplicatorLayer layer];
    self.replicatorLayer.bounds = barberPoleLayer.bounds;
    self.replicatorLayer.position = CGPointMake(- barberStrip.frame.size.width * 4, barberPoleLayer.frame.size.height / 2);
    self.replicatorLayer.instanceCount = (NSInteger)roundf(frame.size.width / barberStrip.frame.size.width * 2) + 1;
    
    CATransform3D finalTransform = CATransform3DMakeTranslation(barberStrip.frame.size.width, 0, 0);
    [self.replicatorLayer setInstanceTransform:finalTransform];
    
    [self.replicatorLayer addSublayer:barberStrip];
    
    [barberPoleLayer addSublayer:self.replicatorLayer];
    
    [self.layer addSublayer:barberPoleLayer];
    
//    barberPoleView.alpha = 0.65f;
    
//    [self addSubview:barberPoleView];

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

@end

@implementation ProgressRectView

- (void)setViewWithTitle:(NSString*)title progress:(CGFloat)progress progress:(BOOL)p
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    self.backgroundColor = [UIColor clearColor];
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
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

    if (p) {
        CGFloat lineWidth = 5;
        
        CGFloat space = 10;
        unFinished = [CAShapeLayer layer];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, space, height/2);
        CGPathAddLineToPoint(path, NULL, width-50, height/2);
        unFinished.path = [UIBezierPath bezierPathWithCGPath:path].CGPath;
        unFinished.strokeColor = [UIColor orangeColor].CGColor;
        unFinished.fillColor = [UIColor redColor].CGColor;
        unFinished.lineWidth = lineWidth;
        unFinished.strokeStart = progress;
        unFinished.strokeEnd = 1;
        unFinished.lineCap = kCALineCapRound;
        unFinished.lineJoin = kCALineJoinMiter;
        [self.layer addSublayer:unFinished];
        CGPathRelease(path);
        
        
        WhorlLayer *finished = [[WhorlLayer alloc] initWithFrame:CGRectMake(space, height/2-lineWidth/2, (width-40-space*2)*progress+space, lineWidth)];
        [self addSubview:finished];
    }
    if (p) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width-40, 0, 40, height)];
    }else{
        titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    titleLabel.font = [UIFont systemFontOfSize:10];
    titleLabel.textColor = [UIColor colorWithRed:67.0/255.0 green:164.0/255.0 blue:173.00/255.0 alpha:1.0];
    [self addSubview:titleLabel];
    titleLabel.text = title;
    
}

- (void)setViewWithTitle:(NSString *)title progress:(CGFloat)progress color:(UIColor *)color titleColor:(NSString *)titleColor
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    self.backgroundColor = [UIColor clearColor];
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    bg = [CAShapeLayer layer];
    CGRect rect = CGRectMake(0, height/3, width, height/3);
    bg.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                         cornerRadius:0].CGPath;
    bg.strokeColor = color.CGColor;
    bg.fillColor = [UIColor clearColor].CGColor;
    bg.lineWidth = 1;
    bg.lineCap = kCALineCapSquare;
    bg.lineJoin = kCALineJoinMiter;
    [self.layer addSublayer:bg];
    

    CGFloat lineWidth = height/6;
    
    CGFloat space = 10;
    unFinished = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, space, height/2);
    CGPathAddLineToPoint(path, NULL, width-10, height/2);
    unFinished.path = [UIBezierPath bezierPathWithCGPath:path].CGPath;
    unFinished.strokeColor = color.CGColor;
    unFinished.fillColor = [UIColor redColor].CGColor;
    unFinished.lineWidth = lineWidth;
    unFinished.strokeStart = 0;
    unFinished.strokeEnd = progress;
    unFinished.lineCap = kCALineCapSquare;
    unFinished.lineJoin = kCALineJoinMiter;
    [self.layer addSublayer:unFinished];
    CGPathRelease(path);
    
    
    NSString *timeString = [NSString stringWithFormat:@"%ld小时",(long)(progress*10)];
    UIFont *font3 = [UIFont fontWithName:kFontName size:15];
    CGSize size = [Utities sizeWithUIFont:font3 string:timeString];
    CGFloat stringX = (width-20)*progress +10-size.width;
    if (stringX < 0) {
        stringX = 0;
    }else if(stringX > (width-20-size.width)){
        stringX += size.width/4;
    }else{
        stringX += size.width/2;
    }
    
    RichStyleLabel *timeLabel = [[RichStyleLabel alloc] initWithFrame:CGRectMake(stringX, 0, size.width, size.height)];
    timeLabel.font = font3;
    timeLabel.textColor = [UIColor blackColor];
    [self addSubview:timeLabel];
    timeLabel.text = timeString;
    
    RichStyleLabel *dioLabel = [[RichStyleLabel alloc] initWithFrame:CGRectMake(0, height*2/3+9, width, size.height)];
    dioLabel.text = title;
    dioLabel.font = font3;
    dioLabel.textColor = [UIColor blackColor];
    NSDictionary* redTextAttributes = @{ NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName:[UIFont fontWithName:kFontName size:19]};
    [dioLabel setAttributedText:title withRegularPattern:@"[0-9]+" attributes:redTextAttributes];
    [self addSubview:dioLabel];
    
    
}

@end
