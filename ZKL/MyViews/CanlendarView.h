//
//  CanlendarView.h
//  ZKL
//
//  Created by EMCC on 15/2/27.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayButton.h"
typedef void (^DoOneDay) (DayButton* day);
@interface CanlendarView : UIView

@property (nonatomic, copy) DoOneDay doOneDay;

@end
