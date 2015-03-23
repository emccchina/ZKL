//
//  HeaderCell.m
//  ZKL
//
//  Created by EMCC on 15/3/20.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "HeaderCell.h"

@implementation HeaderCell

- (void)awakeFromNib {
    // Initialization code
    self.header.layer.cornerRadius = 50;
    self.header.layer.masksToBounds = YES;
    self.diolague.numberOfLines = 0;
    [self.BG setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/w%3D310/sign=350095096509c93d07f208f6af3df8bb/9f510fb30f2442a7252422a2d343ad4bd113028b.jpg"]];
}


@end
