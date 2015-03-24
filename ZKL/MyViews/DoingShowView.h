//
//  DoingShowView.h
//  ZKL
//
//  Created by EMCC on 15/3/20.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressLineView.h"

@interface DoingShowView : UIView
{
    ProgressLineView    *progressView;
}
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *dio;
@property (nonatomic, assign) CGFloat  totalTime;
@property (nonatomic, assign) CGFloat  progress;
@property (nonatomic, assign) BOOL      buttom;//底部 0没有  1 有
@end
