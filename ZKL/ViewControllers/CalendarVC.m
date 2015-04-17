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
#import "NSDate+Agenda.h"
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
    if ([[UserInfo shareUserInfo] isLogin]) {
        [self requestForMonthPlan:self.calendarView.showFirstDate toDate:self.calendarView.showLastDate];
    }
    [self.calendarView setDoOneDay:^(DayButton *button){
        chartView.dateString = [NSDate stringFromDate:button.date];
        chartView.model = button.performModel;
        [self.mySegment setSelectedSegmentIndex:1];
        [self showView:1];
    }];
    [self.calendarView setChangeMonth:^(NSInteger type){
        if ([[UserInfo shareUserInfo] isLogin]) {
            [self requestForMonthPlan:self.calendarView.showFirstDate toDate:self.calendarView.showLastDate];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)requestForMonthPlan:(NSString*)fromDate toDate:(NSString*)toDate
{
    [self showIndicatorView:kNetworkConnecting];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@planaction!getMonthPlan.action",kServerDomain];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:fromDate,@"beginString",toDate, @"endString",[UserInfo shareUserInfo].userCode, @"userCode", nil];
    NSLog(@"dict %@", dict);
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject is %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        [self dismissIndicatorView];
        id result = [self parseResults:responseObject];
        if (result) {
            [self pareseForPerformModel:result[@"result"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Utities errorPrint:error vc:self];
        [self dismissIndicatorView];
        [self showAlertView:kNetworkNotConnect];
    }];
}

- (void)pareseForPerformModel:(NSArray*)models
{
    NSArray *perfromModels = [MTLJSONAdapter modelsOfClass:[PerformModel class] fromJSONArray:models error:nil];
    [[SQLManager shareUserInfo] replacePerformModels:perfromModels];
    [self.calendarView setNeedsDisplay];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    chartView.dateString = [NSDate stringFromDate:[NSDate date]];
    chartView.model = [[SQLManager shareUserInfo] cupsWithDate:[NSDate date]];
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
