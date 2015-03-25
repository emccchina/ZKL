//
//  WhiteBlackTextFiled.m
//  ZKL
//
//  Created by EMCC on 15/2/25.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "WhiteBlackTextFiled.h"

@implementation WhiteBlackTextFiled

- (void)awakeFromNib
{
    myFont = [UIFont fontWithName:kFontName size:16];
    myTF = [[UITextField alloc] init];
    myTF.font = myFont;
    myTF.delegate = self;
    [self addSubview:myTF];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat space = 10;
    CGFloat height = rect.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGSize titleSize = [Utities sizeWithUIFont:myFont string:self.title];
    titleSize.width += 20;
    CGContextSetFillColorWithColor(context, kBlackBGTF.CGColor);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, titleSize.width+space, 0);
    CGContextAddLineToPoint(context, titleSize.width, height);
    CGContextAddLineToPoint(context, 0, height);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSetFillColorWithColor(context, kWhiteBGTF.CGColor);
    CGContextMoveToPoint(context, titleSize.width+space+3, 0);
    CGContextAddLineToPoint(context, rect.size.width, 0);
    CGContextAddLineToPoint(context, rect.size.width, height);
    CGContextAddLineToPoint(context, titleSize.width+3, height);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    [self.title drawAtPoint:CGPointMake(10, (height-titleSize.height)/2) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:myFont}];
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleX];
    animation.fromValue = @(.1);
    animation.toValue = @(1.0);
    animation.springBounciness = 15;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.layer pop_addAnimation:animation forKey:@"ZoomInX"];
    });
    
    myTF.frame = CGRectMake(titleSize.width+space+15, 0, rect.size.width-titleSize.width-space-15, height);
}

#pragma UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (self.finished) {
        self.finished(textField.text);
    }
    return YES;
}
@end
