//
//  MyTextField.m
//  ZYYG
//
//  Created by EMCC on 14/12/23.
//  Copyright (c) 2014年 wu. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

-(void)dealloc
{
    
}

- (void)removeNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib
{
//    [self setupView];
}

- (void)setupView
{
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doFinish)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    [topView setItems:buttonsArray];
    [self setInputAccessoryView:topView];
}

- (void)doFinish
{
    [self resignFirstResponder];
    if (self.finished) {
        self.finished(self);
    }
}

#pragma mark keyboardNotification

- (void)keyboardWillShow:(NSNotification*)notification{
    if (self.superRect.origin.y <= 0) {
        return;
    }
//    NSLog(@"keyboard info %@", notification.userInfo);
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"%@,%@,%f", NSStringFromCGRect(self.superRect),NSStringFromCGRect(_keyboardRect),CGRectGetMaxY(self.superRect));
    //如果self在键盘之下 才做偏移
    if (CGRectGetMaxY(self.superRect)>= _keyboardRect.origin.y-40)
        {
            
            [UIView animateWithDuration:[[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]
                                  delay:0
                                options:[[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]
                             animations:^{
                                 self.mySuperview.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height);
                             } completion:nil];
            
        }

}

- (void)keyboardWillHide:(NSNotification*)notification
{
    [UIView animateWithDuration:[[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.mySuperview.transform = CGAffineTransformMakeTranslation(0, 0);
                     } completion:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
