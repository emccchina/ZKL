//
//  HomeView.m
//  ZKL
//
//  Created by EMCC on 15/1/22.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "HomeView.h"

//#import <QuartzCore/QuartzCore.h>
@implementation HomeView
- (void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
}


- (void)startAnimationHV
{
    willHidden = NO;
    [self.closeBut setBackgroundImage:[Utities homeAddImage] forState:UIControlStateNormal];
    self.closeBut.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0);
    [self closeButAnimation:0];
    
    self.bu1.layer.transform = CATransform3DMakeTranslation(-300, 0, 0);
    POPSpringAnimation *anim1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
    anim1.toValue = @(0);
    [self.bu1.layer pop_addAnimation:anim1 forKey:@"size1"];
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleY];
    self.button.layer.transform = CATransform3DMakeScale(1.0, 0.1, 1.0);
    animation.toValue = @(1.0);
    animation.springBounciness = 10;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.button.layer pop_addAnimation:animation forKey:@"ZoomInY"];
    });
    
}

- (void)closeButAnimation:(BOOL)state//0 旋转变大   1还原
{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    CGFloat angle = state ? 0 : M_PI_4;
    anim.toValue = @(angle);
    anim.delegate = self;
    [self.closeBut.layer pop_addAnimation:anim forKey:@"size"];
    
    POPSpringAnimation *animScale = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    CGPoint scale = state ? CGPointMake(1.0, 1.0) : CGPointMake(1.2, 1.2);
    animScale.toValue = [NSValue valueWithCGPoint:scale];
    anim.name = @"state";
    [self.closeBut.layer pop_addAnimation:animScale forKey:@"sizescale"];
}

- (void)selfAlpha:(CGFloat)endAlpha //1  消失    0 显示
{
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.fromValue = @(1-endAlpha);
    anim.toValue = @(endAlpha);
    [self pop_addAnimation:anim forKey:@"alpha"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    willHidden = YES;
    [self closeButAnimation:1];
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished{
//    NSLog(@"finished  %@", anim.name);
    if (willHidden) {
        [self selfAlpha:0];
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
