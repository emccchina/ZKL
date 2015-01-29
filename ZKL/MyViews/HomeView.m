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
    self.closeBut.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0);
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    anim.toValue = @(1);
    [self.closeBut.layer pop_addAnimation:anim forKey:@"size"];
    
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.hidden = YES;
//    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
//    [self.closeBut.layer pop_addAnimation:anim forKey:@"s"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
