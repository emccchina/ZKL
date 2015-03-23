//
//  HeaderCell.h
//  ZKL
//
//  Created by EMCC on 15/3/20.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderCell : UIView
@property (weak, nonatomic) IBOutlet UIImageView *BG;

@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *levle;
@property (weak, nonatomic) IBOutlet UILabel *diolague;
@end
