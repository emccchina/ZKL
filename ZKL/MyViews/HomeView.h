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
    
}
@property (weak, nonatomic) IBOutlet UIButton *bu1;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIButton *closeBut;
@property (weak, nonatomic) IBOutlet UIButton *button;
- (void)startAnimationHV;
@end
