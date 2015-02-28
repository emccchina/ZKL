//
//  CalendarVC.m
//  ZKL
//
//  Created by EMCC on 15/2/27.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "CalendarVC.h"

@interface CalendarVC ()


@end

@implementation CalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackItem];
    
    
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CanlendarView" owner:self options:nil];
//    UIView *view = nib[0];
//    [self.view addSubview:view];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
