//
//  MyTextField.h
//  ZYYG
//
//  Created by EMCC on 14/12/23.
//  Copyright (c) 2014年 wu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTextField;
typedef void (^DoFinished) (MyTextField* tf);
@interface MyTextField : UITextField
{
}
@property (nonatomic, strong) UIView *mySuperview;
@property (nonatomic, assign) CGRect superRect;
@property (nonatomic, strong) id mark;
@property (nonatomic, copy) DoFinished finished;

- (void)removeNotifications;
- (void)addNotifications;

@end
