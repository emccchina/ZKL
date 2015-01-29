//
//  ProgressCricleView.h
//  ZKL
//
//  Created by EMCC on 15/1/27.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressCricleView : UIControl
{
    UILabel   *progressLabel;
    CAShapeLayer *circleBig;
    CAShapeLayer *circleInside;
}
@property (nonatomic, assign) CGFloat  progress;

@end
