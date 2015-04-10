//
//  EditTime.h
//  ZKL
//
//  Created by EMCC on 15/2/27.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "PerformModel.h"

@class DrawBut;
typedef void (^EditFinished) (void);
@interface EditTime : UIView
<UITextFieldDelegate>
{
    PerformModel *_performModel;
    NSInteger   dreamTime;
    NSInteger   restTime;
    NSInteger   state;
}
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet MyTextField *timeTF;
@property (weak, nonatomic) IBOutlet MyTextField *minuteTF;
@property (weak, nonatomic) IBOutlet UIButton *OKButton;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIView *whiteBG;
@property (weak, nonatomic) IBOutlet DrawBut *dreamBut;
@property (weak, nonatomic) IBOutlet DrawBut *restBut;
@property (weak, nonatomic) IBOutlet DrawBut *wasteBut;
@property (nonatomic, strong) PerformModel *performModel;
@property (nonatomic, copy) EditFinished    editFinished;
@end

@interface DrawBut : UIButton
@property (nonatomic, strong) UIColor *BGColorSelected;
@property (nonatomic, strong) UIColor *circleColor;
@end