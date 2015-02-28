//
//  HomeView.h
//  ZKL
//
//  Created by EMCC on 15/1/22.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextInHomeView.h"

typedef void (^DoButtonOnSelf)(NSInteger type);//0关闭  1第一个按钮，2 第二个按钮， 3第三个按钮

@interface HomeView : UIView
{
    BOOL   willHidden;
    NSInteger   doButtonType;
}
@property (weak, nonatomic) IBOutlet TextInHomeView *textView;
@property (weak, nonatomic) IBOutlet UIButton *closeBut;
@property (nonatomic, copy) DoButtonOnSelf   doBut;
- (void)startAnimationHV;
- (void)selfAlpha:(CGFloat)endAlpha; //1  消失    0 显示
@end
