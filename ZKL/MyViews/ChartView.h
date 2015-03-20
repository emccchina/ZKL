//
//  ChartView.h
//  ZKL
//
//  Created by EMCC on 15/3/19.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressRectView.h"
#import "RichStyleLabel.h"

@interface ChartView : UIView

@property (weak, nonatomic) IBOutlet UIView *topBG;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet ProgressRectView *dreamProgress;
@property (weak, nonatomic) IBOutlet ProgressRectView *restProgress;
@property (weak, nonatomic) IBOutlet ProgressRectView *wasteProgress;
@property (weak, nonatomic) IBOutlet RichStyleLabel *sortLabel;
@property (weak, nonatomic) IBOutlet UILabel *dioLabel;
@end
