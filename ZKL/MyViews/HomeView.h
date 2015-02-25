//
//  HomeView.h
//  ZKL
//
//  Created by EMCC on 15/1/22.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeView : UIView
{
    BOOL   willHidden;
}
@property (weak, nonatomic) IBOutlet UIButton *but1;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIButton *closeBut;
- (void)startAnimationHV;
- (void)selfAlpha:(CGFloat)endAlpha; //1  消失    0 显示
@end
