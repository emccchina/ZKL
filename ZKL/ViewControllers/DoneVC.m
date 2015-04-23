//
//  DoneVC.m
//  ZKL
//
//  Created by EMCC on 15/3/20.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "DoneVC.h"
#import "HeaderCell.h"
#import "DoingShowView.h"
#import "DoneShowView.h"
#import "NSDate+Agenda.h"
@interface DoneVC ()
{
    HeaderCell *headerCell;
    NSArray     *plans;
    NSInteger   currentIndex;//正在显示的哪个
    NSMutableArray  *performs;
}
@property (weak, nonatomic) IBOutlet UIView *headViewBG;
@property (weak, nonatomic) IBOutlet DoneShowView *showView;
@end

@implementation DoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackItem];
    
    UISwipeGestureRecognizer *gestureDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureSwipeDown:)];
    gestureDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.showView addGestureRecognizer:gestureDown];
    
    UISwipeGestureRecognizer *gestureUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureSwipeUp:)];
    gestureUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.showView addGestureRecognizer:gestureUp];
    
    headerCell = (HeaderCell*)[Utities viewAddContraintsParentView:self.headViewBG subNibName:@"HeaderCell"];
    UserInfo* user =[UserInfo shareUserInfo];
    [headerCell.header setImage:[UIImage imageNamed:@"Header"]];
    headerCell.name.text = user.userName?:@"无名氏";
    headerCell.diolague.text = user.nickName?:@"无名";
    [self requestForFinishedPlan];
    
}

- (void)gestureSwipeDown:(UISwipeGestureRecognizer*)gesture
{
//    NSLog(@"%d", gesture.direction);
    if (currentIndex == 0) {
        [self showAlertView:@"没了"];
        return;
    }else{
        currentIndex--;
        [self planViewChange:currentIndex];
    }
}
- (void)gestureSwipeUp:(UISwipeGestureRecognizer*)gesture
{
//    NSLog(@"%d", gesture.direction);
    if (currentIndex == plans.count-1) {
        [self showAlertView:@"没了"];
        return;
    }else{
        currentIndex++;
        [self planViewChange:currentIndex];
    }
}

- (void)requestForFinishedPlan
{
    [self showIndicatorView:kNetworkConnecting];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@planaction!getAllFinishedPlan.action",kServerDomain];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UserInfo shareUserInfo].userCode, @"userCode", nil];
    NSLog(@"dict %@", dict);
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject is %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        id result = [self parseResults:responseObject];
        if (result) {
            [self parseForPlans:result[@"result"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Utities errorPrint:error vc:self];
        [self dismissIndicatorView];
        [self showAlertView:kNetworkNotConnect];
    }];
}

- (void)parseForPlans:(NSArray*)array
{
    plans = [MTLJSONAdapter modelsOfClass:[PlanModel class] fromJSONArray:array error:nil];
    if (!plans.count) {
        [self dismissIndicatorView];
        return;
    }
    currentIndex = 0;
    [self planViewChange:currentIndex];
}

- (void)planViewChange:(NSInteger)index
{
    PlanModel *model = [plans objectAtIndex:0];
    [self requestForPerform:model.planIDServer];
}

- (void)requestForPerform:(NSString*)planCode
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@performaction!getPerformByPlanCode.action",kServerDomain];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UserInfo shareUserInfo].userCode, @"userCode",planCode,@"planCode", nil];
    NSLog(@"dict %@", dict);
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject is %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        [self dismissIndicatorView];
        id result = [self parseResults:responseObject];
        if (result) {
            performs = result[@"result"];
            [self setShowViewState];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Utities errorPrint:error vc:self];
        [self dismissIndicatorView];
        [self showAlertView:kNetworkNotConnect];
    }];
}

- (void)setShowViewState
{
    self.showView.title = ((PlanModel*)[plans objectAtIndex:currentIndex]).title;
    
    CGFloat dreams = 0;
    CGFloat rest = 0;
    NSMutableArray *points = [[NSMutableArray alloc] init];
    for (NSDictionary* model in performs) {
        dreams += [model[@"planMinute"] floatValue]/60;
        rest += [model[@"restMinute"] floatValue]/60;
        NSString *date = [model[@"theDay"] substringFromIndex:5];
        [points addObject:[self dictionaryWithTime:[NSString stringWithFormat:@"%.1f",[model[@"planMinute"] floatValue]/60] date:date]];
    }
    PlanModel *model = [plans objectAtIndex:currentIndex];
    NSDate *beginDate = [NSDate dateFromString:model.beginDate];
    NSDate  *endDate = [NSDate dateFromString:model.endDate];
    NSTimeInterval space = [endDate timeIntervalSinceDate:beginDate];
    NSInteger days = space/60/60/24;
    self.showView.dreamTime = dreams/(days*24);
    self.showView.restTime = rest/(days*24);
    self.showView.points = points;
    self.showView.backgroundColor = [UIColor clearColor];
}

- (NSDictionary*)dictionaryWithTime:(NSString*)time date:(NSString*)date
{
    NSDictionary *dict = @{kTime:time, kDate:date};
    return dict;
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
