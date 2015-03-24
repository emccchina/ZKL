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
    [self.BG setImage:[UIImage imageNamed:@"BG"]];
    
}


@end
