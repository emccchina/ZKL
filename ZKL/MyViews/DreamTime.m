//
//  DreamTime.m
//  ZKL
//
//  Created by EMCC on 15/1/23.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "DreamTime.h"
#import "ProgressCricleView.h"

@interface DreamTime()
{
    UILabel     *dreamLabel;
    UILabel     *timeLabel;
    UILabel     *addDreamLabel;
    ProgressCricleView  *fininshed;
    ProgressCricleView  *unFinished;
    
    CAShapeLayer    *stateLayer;//什么状态，0添加   1暂停  2播放
    
    UIView      *circleWhite;
    CAShapeLayer *circleBig;
    CAShapeLayer *circleInside;
    CAShapeLayer *circleInsideLightBG;
    CAShapeLayer *rectTop;
}
@property(nonatomic) CAShapeLayer *circleLayer;
@end

@implementation DreamTime

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    [self addTarget:self action:@selector(pressedSelf:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pressedSelf:(id)sender
{
    if (self.pressed) {
        self.pressed(self.typeState);
        return;
    }
//    switch (self.typeState) {
//        case 0:{
//            if (self.pressed) {
//                self.pressed(0);
//                return;
//            }
//        }break;
//        case 1:{
//            
//        }break;
//        case 2:{
//            self.typeState = 1;
//        }break;
//            
//        default:
//            break;
//    }
//    [self setStateLayer:self.typeState];
}

#pragma mark - Instance Methods

- (void)start:(NSInteger)type
{
    self.typeState = type;
    [self addCircleLayer];
    [self setup:self];
    [self setStateLayer:type];
}

- (void)setStateHidden
{
    circleWhite.hidden = !self.typeState;
    dreamLabel.hidden = !self.typeState;
    timeLabel.hidden = !self.typeState;
    circleInside.hidden = !self.typeState;
    circleInsideLightBG.hidden = self.typeState;
    self.circleLayer.hidden = !self.typeState;
    rectTop.hidden = !self.typeState;
//    fininshed.hidden = !self.typeState;
    unFinished.hidden = !self.typeState;
    addDreamLabel.hidden = self.typeState;
}

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated
{
    if (animated) {
        [self animateToStrokeEnd:strokeEnd];
        return;
    }
    self.circleLayer.strokeEnd = strokeEnd;
}

#pragma mark - Property Setters

- (POPMutableAnimatableProperty *)animationProperty:(NSInteger)type {
    switch (type) {
        case 0://time lable text 逐渐递增
            return [POPMutableAnimatableProperty
                    propertyWithName:@"com.curer.test"
                    initializer:^(POPMutableAnimatableProperty *prop) {
                        prop.writeBlock = ^(id obj, const CGFloat values[]) {
                            UILabel *label = (UILabel *)obj;
                            NSNumber *number = @(values[0]);
                            NSInteger num = [number intValue];
                            label.text = [NSString stringWithFormat:@"%ld%%",(long)num];
                        };
                    }];
        case 1://
            return [POPMutableAnimatableProperty
                    propertyWithName:@"com.curer.test1"
                    initializer:^(POPMutableAnimatableProperty *prop) {
                        prop.writeBlock = ^(id obj, const CGFloat values[]) {
                            
                        };
                    }];
        case 2://圆圈 增长
            return [POPMutableAnimatableProperty
                    propertyWithName:@"com.curer.test1"
                    initializer:^(POPMutableAnimatableProperty *prop) {
                        prop.writeBlock = ^(id obj, const CGFloat values[]) {
                            self.circleLayer.strokeEnd = values[0];
                            circleWhite.center = [self pointFromCircle:values[0] reduceAngle:0 radiusVar:4];
                        };
                    }];
        default:
            break;
    }
    return nil;
}



- (void)setProgressCircle:(ProgressCricleView*)view progress:(CGFloat)progress
{
    view.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame)/4, CGRectGetWidth(self.frame)/4);
    view.center = [self pointFromCircle:progress reduceAngle:.1 radiusVar:0];
    [view setProgress:progress];
}

#pragma mark - Private Instance methods

- (void)setup:(UIView*)parentView
{
    CGFloat sizeFont = CGRectGetWidth(self.frame)/4;
//    if (!dreamLabel) {
//        dreamLabel = [UILabel new];
//        dreamLabel.textColor = kTextColor;
//        dreamLabel.font = [UIFont boldSystemFontOfSize:sizeFont];
//        [self addSubview:dreamLabel];
//        dreamLabel.textAlignment = NSTextAlignmentCenter;
//    }
    if (!timeLabel) {
        timeLabel = [UILabel new];
        timeLabel.textColor = kTextColor;
        timeLabel.font = [UIFont boldSystemFontOfSize:sizeFont];
        [self addSubview:timeLabel];
        timeLabel.textAlignment = NSTextAlignmentCenter;
    }
//    if (!fininshed) {
//        fininshed = [ProgressCricleView new];
//        [self addSubview:fininshed];
//    }
    if (!unFinished) {
        unFinished = [ProgressCricleView new];
        [self addSubview:unFinished];
    }
    if (!circleWhite) {
        circleWhite = [UIView new];
        [self addSubview:circleWhite];
        circleWhite.layer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.8].CGColor;
    }
    
//    if (!addDreamLabel) {
//        addDreamLabel = [UILabel new];
//        [self addSubview:addDreamLabel];
//        addDreamLabel.textColor = kTextColor;
//        addDreamLabel.font = [UIFont boldSystemFontOfSize:sizeFont/2];
//        addDreamLabel.textAlignment = NSTextAlignmentCenter;
//    }
    
//    dreamLabel.text = @"梦想";
//    dreamLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2);
//    dreamLabel.center =CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/4+15);
    timeLabel.frame =  CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2);
    timeLabel.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    timeLabel.text = @"0%";
    circleWhite.frame = CGRectMake(CGRectGetWidth(self.frame)/2-8, -4, 16, 16);
    circleWhite.layer.cornerRadius = 8;
//    addDreamLabel.text = @"添加梦想";
//    addDreamLabel.frame = CGRectMake(0, 0, self.frame.size.width, CGRectGetHeight(self.frame)/2);
//    addDreamLabel.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)*6/8);
}

- (CGPoint)pointFromCircle:(CGFloat)progress reduceAngle:(CGFloat)angleReduce radiusVar:(CGFloat)radiusVar
{
    CGFloat space = radiusVar;
    CGFloat radius = CGRectGetWidth(self.bounds)/2;
    CGFloat angle = -(progress-angleReduce)*M_PI*2+M_PI_2;
    CGFloat x = (radius-space)*cos(angle);//radius*cos(angle);
    CGFloat y = (radius-space)*sin(angle);
    return CGPointMake(radius+x,radius - y);
}

- (void)addCircleLayer
{
    CGFloat lineWidth = 8.f;
    CGFloat radius = CGRectGetWidth(self.bounds)/2 - lineWidth/2;
    
    if (!circleBig) {
        circleBig = [CAShapeLayer layer];
        CGRect rect = CGRectMake(lineWidth/2, lineWidth/2, radius * 2, radius * 2);
        circleBig.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    cornerRadius:radius].CGPath;
        circleBig.strokeColor = kOutsideColor.CGColor;
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
        circleInside.fillColor = kBGColor.CGColor;
        circleInside.lineWidth = 0;
        circleInside.lineCap = kCALineCapRound;
        circleInside.lineJoin = kCALineJoinMiter;
        [self.layer addSublayer:circleInside];
    }
    if (!circleInsideLightBG) {
        circleInsideLightBG = [CAShapeLayer layer];
        CGRect rectInside = CGRectMake(lineWidth, lineWidth, radius * 2-lineWidth, radius * 2-lineWidth);
        circleInsideLightBG.path = [UIBezierPath bezierPathWithRoundedRect:rectInside
                                                       cornerRadius:radius].CGPath;
        circleInsideLightBG.strokeColor = nil;//[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3].CGColor;
        circleInsideLightBG.fillColor = kBGLightColor.CGColor;
        circleInsideLightBG.lineWidth = 0;
        circleInsideLightBG.lineCap = kCALineCapRound;
        circleInsideLightBG.lineJoin = kCALineJoinMiter;
        [self.layer addSublayer:circleInsideLightBG];
    }
    
    lineWidth = 4.f;
    CGFloat space = 2;
    radius = CGRectGetWidth(self.bounds)/2 - lineWidth/2-space;
    if (!self.circleLayer) {
        self.circleLayer = [CAShapeLayer layer];
        CGRect rect1 = CGRectMake(lineWidth/2+space, lineWidth/2+space, radius * 2, radius * 2);
        self.circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect1
                                                           cornerRadius:radius].CGPath;
        self.circleLayer.strokeColor = kProgressColor.CGColor;
        self.circleLayer.fillColor = nil;
        self.circleLayer.lineWidth = lineWidth;
        self.circleLayer.strokeStart = 0;
        self.circleLayer.strokeEnd = 0;
        self.circleLayer.lineCap = kCALineCapRound;
        self.circleLayer.lineJoin = kCALineJoinRound;
        [self.layer addSublayer:self.circleLayer];
    }
    
    if (!rectTop) {
        rectTop = [CAShapeLayer layer];
        CGRect rectTopRect = CGRectMake(CGRectGetWidth(self.frame)/2-3, -5, 3, 20);
        rectTop.path = [UIBezierPath bezierPathWithRect:rectTopRect].CGPath;
        rectTop.strokeColor = 0;
        rectTop.fillColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:rectTop];
    }
    
    
}


- (void)setStateLayer:(NSInteger)type
{
    [self setStateHidden];
    [stateLayer removeFromSuperlayer];
    stateLayer = [CAShapeLayer layer];
    CGFloat space = CGRectGetWidth(self.frame)/5;
    switch (type) {
        case 0:{
            stateLayer.strokeColor = [UIColor colorWithRed:101.0/255.0 green:196.0/255.0 blue:211.0/255.0 alpha:1].CGColor;
            stateLayer.fillColor = nil;
            stateLayer.lineWidth = space/6;
            stateLayer.lineCap = kCALineCapRound;
            stateLayer.lineJoin = kCALineJoinRound;
            CGRect rectstate = CGRectMake(CGRectGetWidth(self.frame)/2-space, CGRectGetHeight(self.frame)/2-space/12, 2*space, space/6);
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:rectstate];
            rectstate = CGRectMake(CGRectGetWidth(self.frame)/2-space/12, CGRectGetHeight(self.frame)/2-space, space/6, space*2);
            UIBezierPath *path1 = [UIBezierPath bezierPathWithRect:rectstate];
            [path appendPath:path1];
            stateLayer.path = path.CGPath;
        }break;
        case 1:{
//            stateLayer.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.5].CGColor;
            CGRect rectstate = CGRectMake(CGRectGetWidth(self.frame)/2-space*3/4, CGRectGetHeight(self.frame)/2-space, space/2, space*2);
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:rectstate];
            rectstate.origin.x += space;
            UIBezierPath *path1 = [UIBezierPath bezierPathWithRect:rectstate];
            [path appendPath:path1];
            stateLayer.path = path.CGPath;
        }break;
        case 2:{
            //1.获取图形上下文
//            stateLayer.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.5].CGColor;
            CGFloat midX = CGRectGetWidth(self.frame)/2+10;
            CGFloat midY = CGRectGetHeight(self.frame)/2;
            CGMutablePathRef path=CGPathCreateMutable();
            CGPathMoveToPoint(path, NULL, midX-space, midY-space);
            CGPathAddLineToPoint(path, NULL, midX+space, midY);
            CGPathAddLineToPoint(path, NULL, midX-space, midY+space);
            UIBezierPath *path1 = [UIBezierPath bezierPathWithCGPath:path];
            stateLayer.path = path1.CGPath;
            CGPathRelease(path);
        }break;
            
        default:
            break;
    }
    
    stateLayer.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.5].CGColor;
    stateLayer.lineCap = kCALineCapRound;
    stateLayer.lineJoin = kCALineJoinMiter;
    [self.layer addSublayer:stateLayer];
}

- (void)animateToStrokeEnd:(CGFloat)strokeEnd
{
    POPBasicAnimation *strokeAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.fromValue = @(0);
    strokeAnimation.toValue = @(strokeEnd);
    strokeAnimation.duration = kDuration;
    strokeAnimation.property = [self animationProperty:2];
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
    
    POPBasicAnimation *animation = [POPBasicAnimation animation];
    animation.property = [self animationProperty:0];
    animation.fromValue = @(0);
    animation.toValue = [NSNumber numberWithFloat:strokeEnd*100];
    animation.duration =  kDuration;
    [timeLabel pop_addAnimation:animation forKey:@"numberLabelAnimation"];
    
//    [self setProgressCircle:fininshed progress:strokeEnd];
//    POPBasicAnimation *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
//    alpha.fromValue = @(0);
//    alpha.toValue = @(1);
//    alpha.duration = kDuration;
//    [fininshed pop_addAnimation:alpha forKey:@"alpha"];
}
@end
