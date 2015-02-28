//
//  TextInHomeView.m
//  ZKL
//
//  Created by EMCC on 15/2/26.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "TextInHomeView.h"
#import "Mydate.h"
#import <CoreText/CoreText.h>
@implementation TextInHomeView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSDateComponents *comps = [Mydate getNowDateComponents];
    NSString *month = [NSString stringWithFormat:@"%02ld",(long)[comps month]];
    NSString *day = [NSString stringWithFormat:@"%02ld", (long)[comps day]];
    NSString *year = [NSString stringWithFormat:@"%ld", (long)[comps year]];
    
    UIFont *font = [UIFont fontWithName:@"CourierNewPS-BoldItalicMT" size:20];
    
    NSMutableParagraphStyle * paragraphStyle =[[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [month drawInRect:CGRectMake(20, 5, 50, 20) withAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:font, NSParagraphStyleAttributeName: paragraphStyle}];
    [year drawInRect:CGRectMake(20, 30, 50, 20) withAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:font, NSParagraphStyleAttributeName: paragraphStyle}];
    UIFont *font2 = [UIFont fontWithName:@"CourierNewPS-BoldItalicMT" size:50];
    [day drawInRect:CGRectMake(80, 5, 70, 50) withAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor], NSFontAttributeName:font2, NSParagraphStyleAttributeName: paragraphStyle}];
    
    UIFont *font3 = [UIFont fontWithName:@"CourierNewPS-BoldItalicMT" size:20];
    [self.content drawInRect:CGRectMake(15, 70, rect.size.width-30, rect.size.height-70) withAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor], NSFontAttributeName:font3}];
    
}


@end
