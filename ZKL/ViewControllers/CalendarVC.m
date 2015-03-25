//
//  CalendarVC.m
//  ZKL
//
//  Created by EMCC on 15/2/27.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "CalendarVC.h"
#import "CanlendarView.h"
#import "ChartView.h"

@interface CalendarVC ()
{
    ChartView *chartView;
}

@property (weak, nonatomic) IBOutlet CanlendarView *calendarView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegment;
@end

@implementation CalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackItem];
    self.navigationItem.rightBarButtonItem = [Utities barButtonItemWithSomething:nil target:nil action:nil];
    if (!chartView) {
        chartView = (ChartView*)[Utities viewAddContraintsParentView:self.view subNibName:@"ChartView"];
    }
    [self showView:0];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setChartProgress];
}


- (IBAction)doSegmentIndex:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl*)sender;
    [self showView:segment.selectedSegmentIndex];
}

- (void)showView:(BOOL)calendar//0calendar  1chart图表
{
    self.calendarView.hidden = calendar;
    chartView.hidden = !calendar;
}

- (void)setChartProgress
{
    [chartView.dreamProgress setViewWithTitle:@"直接哦i街里街道；32就；i；瓯江；" progress:0.5 color:[UIColor redColor] titleColor:@"32"];
    [chartView.restProgress setViewWithTitle:@"ljoij;;;" progress:0.1 color:[UIColor greenColor] titleColor:@"34"];
    [chartView.wasteProgress setViewWithTitle:@"klj;i54" progress:0.8 color:[UIColor magentaColor] titleColor:@"54"];
}

- (void)doRight:(UINavigationItem*)item
{
    
}

- (void)back
{
    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if ([self respondsToSelector:@selector(dismissModalViewControllerAnimated:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
