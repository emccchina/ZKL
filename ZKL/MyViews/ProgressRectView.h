//
//  ProgressRectView.h
//  ZKL
//
//  Created by EMCC on 15/2/2.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressRectView : UIControl
{
    CAShapeLayer    *bg;
    UIImageView     *progressImage;
    CAShapeLayer    *unFinished;
    UILabel         *titleLabel;
}

- (void)setViewWithTitle:(NSString*)title progress:(CGFloat)progress;

@end
