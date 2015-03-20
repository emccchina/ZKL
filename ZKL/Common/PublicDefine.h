//
//  PublicDefine.h
//  ZYYG
//
//  Created by EMCC on 14/11/19.
//  Copyright (c) 2014年 EMCC. All rights reserved.
//

#ifndef ZYYG_PublicDefine_h
#define ZYYG_PublicDefine_h
//底部线
#define createBottomLine  UIView *lineB = [[UIView alloc] init];\
                                    lineB.backgroundColor = [UIColor blackColor];\
                                    lineB.alpha = 0.3;\
                                    [self addSubview:lineB];\
                                    [lineB setTranslatesAutoresizingMaskIntoConstraints:NO];\
                                    [self addConstraint:[NSLayoutConstraint constraintWithItem:lineB attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];\
                                    [self addConstraint:[NSLayoutConstraint constraintWithItem:lineB attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];\
                                    [self addConstraint:[NSLayoutConstraint constraintWithItem:lineB attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];\
                                    [lineB addConstraint:[NSLayoutConstraint constraintWithItem:lineB attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:1/[UIScreen mainScreen].scale]];

//顶部线
#define createTopLine   UIView *lineT = [[UIView alloc] init];\
                                    lineT.backgroundColor = [UIColor blackColor];\
                                    lineT.alpha = 0.3;\
                                    [self addSubview:lineT];\
                                    [lineT setTranslatesAutoresizingMaskIntoConstraints:NO];\
                                    [self addConstraint:[NSLayoutConstraint constraintWithItem:lineT attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];\
                                    [self addConstraint:[NSLayoutConstraint constraintWithItem:lineT attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];\
                                    [self addConstraint:[NSLayoutConstraint constraintWithItem:lineT attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];\
                                    [lineT addConstraint:[NSLayoutConstraint constraintWithItem:lineT attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:1/[UIScreen mainScreen].scale]];

#endif

#define kNavBGColor    [UIColor colorWithRed:89.0/255.0 green:213.0/255.0 blue:212.0/255.0 alpha:1.0]
#define kFontName       @"FZLTHK--GBK1-0"