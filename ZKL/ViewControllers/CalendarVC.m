//
//  CalendarVC.m
//  ZKL
//
//  Created by EMCC on 15/2/27.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "CalendarVC.h"
#import "CanlendarView.h"


@interface CalendarVC ()


@property (weak, nonatomic) IBOutlet CanlendarView *calendarView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegment;
@end

@implementation CalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackItem];
    self.navigationItem.rightBarButtonItem = [Utities barButtonItemWithSomething:[UserInfo shareUserInfo].backImage target:self action:@selector(doRight:)];
}
- (IBAction)doSegmentIndex:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl*)sender;
    [self showView:segment.selectedSegmentIndex];
}

- (void)showView:(BOOL)calendar//0calendar  1chart图表
{
    self.calendarView.hidden = calendar;
}

- (void)doRight:(UINavigationItem*)item
{
    
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
