//
//  ProgressRectView.h
//  ZKL
//
//  Created by EMCC on 15/2/2.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WhorlLayer;
@interface ProgressRectView : UIControl
{
    CAShapeLayer    *bg;
    UIImageView     *progressImage;
    CAShapeLayer    *unFinished;
    CAShapeLayer    *finished;
    UILabel         *titleLabel;

}
- (void)setViewWithTitle:(NSString*)title progress:(CGFloat)progress progress:(BOOL)p;//p 进度条是否存在
- (void)setViewWithTitle:(NSString *)title progress:(CGFloat)progress color:(UIColor*)color titleColor:(NSString*)titleColor;//图表中进度条
@end

@interface WhorlLayer : UIView
{
    CAShapeLayer  *finished;

}
@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;
@property (nonatomic, assign) CGFloat barberPoleStripWidth;
@end