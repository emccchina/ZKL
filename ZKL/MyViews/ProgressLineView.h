//
//  ProgressLineView.h
//  ZKL
//
//  Created by EMCC on 15/3/23.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressLineView : UIView
{
    UIImageView     *humanView;
    UIImageView     *cupView;
    CAShapeLayer    *bg;
    CAShapeLayer    *progressColor;
}

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat totalTime;
@property (nonatomic, assign) BOOL      bottom;
@end
