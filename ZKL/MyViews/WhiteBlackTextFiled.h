//
//  WhiteBlackTextFiled.h
//  ZKL
//
//  Created by EMCC on 15/2/25.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kWhiteBGTF      [UIColor whiteColor]
#define kBlackBGTF      [UIColor blackColor]

typedef void (^EditFinished) (NSString *editString);
typedef NS_ENUM(NSInteger, kTypeTF){
    kNomalType,
    kDateType,
    kNumberType
};
@interface WhiteBlackTextFiled : UIView
<UITextFieldDelegate>
{
    UIPickerView *numberPicker;
    UIDatePicker *picker;
    UITextField *myTF;
    UIFont      *myFont;
}
@property (nonatomic, strong) NSString      *title;
@property (nonatomic, strong) UITextField   *TF;
@property (nonatomic, copy) EditFinished   finished;
@property (nonatomic, assign) kTypeTF       type;
@property (nonatomic, assign) BOOL          editTF;//是否可以编辑
@end
