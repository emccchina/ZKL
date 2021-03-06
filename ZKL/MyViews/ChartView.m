//
//  ChartView.m
//  ZKL
//
//  Created by EMCC on 15/3/19.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "ChartView.h"
#import "Mydate.h"
@implementation ChartView

- (void)awakeFromNib
{
    self.topBG.layer.cornerRadius = 4;
    self.topBG.layer.borderColor = kNavBGColor.CGColor;
    self.topBG.layer.borderWidth = 1;
    
//    NSDateComponents *comps = [Mydate getNowDateComponents];
//    NSString *month = [NSString stringWithFormat:@"%02ld",(long)[comps month]];
//    NSString *day = [NSString stringWithFormat:@"%02ld", (long)[comps day]];
//    NSString *year = [NSString stringWithFormat:@"%ld", (long)[comps year]];
    
    NSDictionary* redTextAttributes = @{ NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName:[UIFont fontWithName:kFontName size:19]};
    [self.sortLabel setAttributedText:@"如果已经登陆\n当日的结果需要\n第二天才可以看得到" withRegularPattern:@"[0-9]+" attributes:redTextAttributes];
    NSString *string = @"但你发现时间是贼,它早已偷走你的时光";
    NSArray *array = [string componentsSeparatedByString:@","];
    if (array.count > 1) {
        self.dioLabel.text = array[0];
        self.dioLabel2.text = array[1];
    }else{
        self.dioLabel.text = string;
        self.dioLabel2.text = @"";
    }
    
    self.dioLabel.numberOfLines = 0;
    self.sortLabel.numberOfLines = 0;
}

- (void)setModel:(PerformModel *)model
{
    _model = model;
    self.dateLabel.text = self.dateString;
    CGFloat progress = [model.planDream floatValue] ? ([model.realDream floatValue]/[model.planDream floatValue]) : 0;
    [self.dreamProgress setViewWithTitle:@"尔之所向，所向披靡。"  progress:progress realTime:model.realDream color:[UIColor redColor] titleColor:@"32"];
    progress = [model.planRest floatValue] ? ([model.realRest floatValue]/[model.planRest floatValue]):0;
    [self.restProgress setViewWithTitle:@"身体是革命的本钱，注意休息。" progress:progress realTime:model.realRest color:[UIColor greenColor] titleColor:@"34"];
    progress = [model.planWaste floatValue] ? ([model.realWaste floatValue]/[model.planWaste floatValue]):0;
    [self.wasteProgress setViewWithTitle:@"一寸光阴一寸金，莫要虚度。" progress:progress realTime:model.realWaste color:[UIColor magentaColor] titleColor:@"54"];
}

@end
