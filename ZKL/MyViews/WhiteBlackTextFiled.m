//
//  WhiteBlackTextFiled.m
//  ZKL
//
//  Created by EMCC on 15/2/25.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "WhiteBlackTextFiled.h"

@implementation WhiteBlackTextFiled
@synthesize TF = myTF;
- (void)awakeFromNib
{
    myFont = [UIFont fontWithName:kFontName size:16];
    myTF = [[UITextField alloc] init];
    myTF.font = myFont;
    self.editTF = YES;
    myTF.delegate = self;
    [self addSubview:myTF];
}

- (void)setType:(kTypeTF)type
{
    _type = type;
    if (type != kNomalType) {
        UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 30)];
        [topView setBarStyle:UIBarStyleDefault];
        
        UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doFinish)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
        
        [topView setItems:buttonsArray];
        [myTF setInputAccessoryView:topView];
    }
    if (type == kDateType) {
        picker = [[UIDatePicker alloc] init];
        picker.minimumDate = [NSDate date];
        picker.datePickerMode=UIDatePickerModeDate;
        myTF.inputView = picker;
    }else if (type == kNumberType){
        myTF.keyboardType = UIKeyboardTypeNumberPad;
    }
}

//- (void)setEditTF:(BOOL)editTF
//{
//    myTF.editing
//}

- (void)doFinish
{
    [myTF resignFirstResponder];
    if (self.type == kDateType) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
        NSString *destDate= [dateFormatter stringFromDate:picker.date];
        myTF.text = destDate;
        if (self.finished) {
            self.finished(destDate);
        }
    }
    
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

#pragma -mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return self.editTF;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (self.finished) {
        self.finished(textField.text);
    }
    return YES;
}


@end
