//
//  ImageButton.m
//  ZKL
//
//  Created by EMCC on 15/2/26.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "ImageButton.h"

@implementation ImageButton

- (void)awakeFromNib
{
    UIImage *image = [UIImage imageNamed:self.imageName];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    imageview.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:imageview];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:imageview attribute:NSLayoutAttributeCenterX multiplier:1 constant:1]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:imageview attribute:NSLayoutAttributeCenterY multiplier:1 constant:1]];
    UILabel *label = [[UILabel alloc] init];
    label.text = self.title;
    label.font = [UIFont fontWithName:kFontName size:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kBlackColor;
    [self addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeTop multiplier:1 constant:-5]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
