//
//  HomeView.m
//  ZKL
//
//  Created by EMCC on 15/1/22.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "HomeView.h"
#import "ImageButton.h"
@implementation HomeView
- (void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    CGFloat topSpace = ((!iPhone_iOS8 || iPhone4) ? 15 : 75);
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:topSpace]];
}

- (IBAction)doButton:(id)sender {
    ImageButton *button = (ImageButton*)sender;
    doButtonType = button.tag - 1;
    [self doCloseButton:nil];
}

- (void)startAnimationHV
{
    doButtonType = 0;
    self.textView.content = @"1231231231312312313";
//    if (iPhone_iOS8) {
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
        anim.fromValue = @(-100);
        anim.toValue = @(0);
        anim.springBounciness = 20;
        [self.textView.layer pop_addAnimation:anim forKey:@"RotationX"];
//    }
    
    for (int i = 2; i < 5; i++) {
        POPSpringAnimation *anim1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
        anim1.toValue = @(0);
        anim1.fromValue = @(200);
        anim1.springBounciness = 10+i*4;
        ImageButton *button = (ImageButton*)[self viewWithTag:i];
        [button.layer pop_addAnimation:anim1 forKey:@"transformY"];
    }
    willHidden = NO;
    [self.closeBut setBackgroundImage:[Utities homeAddImage] forState:UIControlStateNormal];
    [self closeButAnimation:0];
    
}

- (void)closeButAnimation:(BOOL)state//0 旋转变大   1还原
{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    CGFloat angle = state ? 0 : M_PI_4;
    anim.toValue = @(angle);
    anim.fromValue = @(state ? M_PI_4 : 0);
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
    [self doCloseButton:nil];
}
- (IBAction)doCloseButton:(id)sender {
    willHidden = YES;
    [self closeButAnimation:1];
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished{
    NSLog(@"finished  %@", anim.name);
    if (willHidden) {
        [self selfAlpha:0];
        if (self.doBut) {
            self.doBut(doButtonType);
        }
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
