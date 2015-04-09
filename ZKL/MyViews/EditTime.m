//
//  EditTime.m
//  ZKL
//
//  Created by EMCC on 15/2/27.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "EditTime.h"

@implementation DrawBut

- (void)drawRect:(CGRect)rect
{
    [self setTitleShadowColor:[UIColor clearColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    CGFloat scale = [UIScreen mainScreen].scale;
    CGContextRef content = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(content, 1/scale);
    CGContextSetStrokeColorWithColor(content, [UIColor lightGrayColor].CGColor);
    CGContextMoveToPoint(content, 0, CGRectGetHeight(rect));
    CGContextAddLineToPoint(content, CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGContextAddLineToPoint(content, CGRectGetWidth(rect), 0);
    CGContextDrawPath(content, kCGPathStroke);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    
    CGContextSetLineWidth(content, 2);
    CGContextSetStrokeColorWithColor(content, self.circleColor.CGColor);
    CGContextSetFillColorWithColor(content, self.circleColor.CGColor);
    CGContextAddArc(content, CGRectGetWidth(rect)/4, CGRectGetHeight(rect)/2, 7, 0, 2*M_PI, 0);
    if (self.selected) {
        CGContextDrawPath(content, kCGPathFill);
        self.layer.backgroundColor = self.BGColorSelected.CGColor;
    }else{
        CGContextDrawPath(content, kCGPathStroke);
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    }
}

@end

@implementation EditTime

- (void)awakeFromNib
{
    UIColor *lineColor = [UIColor lightGrayColor];
    self.whiteBG.layer.borderColor = lineColor.CGColor;
    CGFloat scale = [UIScreen mainScreen].scale;
    self.whiteBG.layer.borderWidth = 1/scale;
    
    self.dateLabel.text = @"2014 03 25   4";
    
    self.timeTF.delegate  = self;
    self.timeTF.returnKeyType = UIReturnKeyDone;
    self.timeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.timeTF.layer.borderWidth = 1/scale;
    self.timeTF.layer.borderColor = lineColor.CGColor;
    self.timeTF.finished = ^(MyTextField* tf){
        [self doFinish:tf];
    };
    self.minuteTF.delegate  = self;
    self.minuteTF.returnKeyType = UIReturnKeyDone;
    self.minuteTF.keyboardType = UIKeyboardTypeNumberPad;
    self.minuteTF.layer.borderWidth = 1/scale;
    self.minuteTF.layer.borderColor = lineColor.CGColor;
    self.minuteTF.finished = ^(MyTextField *tf){
        [self doFinish:tf];
    };
    
    
    self.OKButton.layer.cornerRadius = 3;
    self.OKButton.layer.backgroundColor = kNavBGColor.CGColor;
    self.cancel.layer.cornerRadius = 3;
    self.cancel.layer.backgroundColor = kLightGrayColor.CGColor;
    
    self.dreamBut.BGColorSelected = [UIColor orangeColor];
    self.dreamBut.circleColor = [UIColor redColor];
    
    self.restBut.BGColorSelected = [UIColor greenColor];
    self.restBut.circleColor = [UIColor blackColor];
    
    self.wasteBut.BGColorSelected = [UIColor blueColor];
    self.wasteBut.circleColor = [UIColor brownColor];
    [self setButSelected:0];
}

- (void)setPerformModel:(PerformModel *)performModel
{
    _performModel = performModel;
    self.dateLabel.text = _performModel.performCode;
    self.timeTF.text = [NSString stringWithFormat:@"%d",(NSInteger)([_performModel.planDream integerValue]/60)];
    self.minuteTF.text = [NSString stringWithFormat:@"%d",(NSInteger)([_performModel.planDream integerValue]%60)];
}

- (void)setButSelected:(NSInteger)type
{
    switch (type) {
        case 0:{
            self.dreamBut.selected = YES;
            self.restBut.selected = NO;
            self.wasteBut.selected = NO;
            self.timeTF.text = [NSString stringWithFormat:@"%d",(NSInteger)([_performModel.planDream integerValue]/60)];
            self.minuteTF.text = [NSString stringWithFormat:@"%d",(NSInteger)([_performModel.planDream integerValue]%60)];
        }break;
        case 1:{
            self.dreamBut.selected = NO;
            self.restBut.selected = YES;
            self.wasteBut.selected = NO;
            self.timeTF.text = [NSString stringWithFormat:@"%d",(NSInteger)([_performModel.planRest integerValue]/60)];
            self.minuteTF.text = [NSString stringWithFormat:@"%d",(NSInteger)([_performModel.planRest integerValue]%60)];
        }break;
        case 2:{
            self.dreamBut.selected = NO;
            self.restBut.selected = NO;
            self.wasteBut.selected = YES;
        }break;
            
        default:
            break;
    }
}
- (IBAction)editTimeDreamBut:(id)sender {
    [self setButSelected:0];
}
- (IBAction)editTimeRestBut:(id)sender {
    [self setButSelected:1];
}
- (IBAction)editTimeWasteBut:(id)sender {
    [self setButSelected:2];
}

- (void)doFinish:(MyTextField*)tf
{
    
}
- (IBAction)doOKButton:(id)sender {
    
}
- (IBAction)doCancelBut:(id)sender {
    [self.timeTF resignFirstResponder];
    self.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(MyTextField *)textField
{
    [textField addNotifications];
    textField.superRect = textField.superview.superview.frame;
    textField.mySuperview = textField.superview.superview;
}

- (void)textFieldDidEndEditing:(MyTextField *)textField
{
    [textField removeNotifications];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
