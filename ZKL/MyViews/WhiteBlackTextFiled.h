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

@interface WhiteBlackTextFiled : UIView
<UITextFieldDelegate>
{
    UITextField *myTF;
    UIFont      *myFont;
}
@property (nonatomic, strong) NSString      *title;
@property (nonatomic, copy) EditFinished   finished;
@end
