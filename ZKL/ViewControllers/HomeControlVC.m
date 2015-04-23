//
//  HomeControlVC.m
//  ZKL
//
//  Created by EMCC on 15/1/23.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "HomeControlVC.h"
#import "DreamTime.h"
#import "ProgressRectView.h"
#import "MyDate.h"
#import "HomeView.h"
#import "EditTime.h"
#import "AppDelegate.h"
#import "ProgressLineView.h"
#import "PerformModel.h"
#import "NSTimer+Addition.h"
#import "NSDate+Agenda.h"
#import "CycleScrollView.h"

@interface HomeControlVC ()<CycleScrollViewDatasource, CycleScrollViewDelegate>
{
    NSTimer     *myTimer;
    PlanModel    *doingPlan;
    NSInteger stateDream;//0添加 1暂停 2播放
    BOOL        reminder;
    BOOL        first;
    CycleScrollView* scrollView;
}
#define kTimerSpace1 1
#define kTimerShundle 60

@property (weak, nonatomic) IBOutlet UIButton *rightBut;

@property (weak, nonatomic) IBOutlet UIButton *leftBut;
@property (weak, nonatomic) IBOutlet DreamTime *dreamView;
@property (weak, nonatomic) IBOutlet UILabel *dreameTitle;
@property (weak, nonatomic) IBOutlet ProgressRectView *dreamProgress;
@property (weak, nonatomic) IBOutlet ProgressRectView *needProgress;
@property (weak, nonatomic) IBOutlet ProgressRectView *wasteProgress;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet ProgressLineView *progreessLine;
@end

@implementation HomeControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self showBackItem];
    first = YES;
    self.title = @"自控力";
    self.navigationItem.rightBarButtonItem = [Utities barButtonItemWithSomething:[UIImage imageNamed:@"Header"] target:self action:@selector(doRight:)];
    self.view.backgroundColor = [UIColor colorWithRed:69.0/255.0 green:188.0/255.0 blue:208.0/255.0 alpha:1];
    CGFloat topHieght = iPhone4 ? 10 : 50;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.dreamView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:topHieght]];
    [self.leftBut setBackgroundImage:[Utities backImage:0] forState:UIControlStateNormal];
    [self.rightBut setBackgroundImage:[Utities backImage:1] forState:UIControlStateNormal];
    [Mydate getNowDateComponents];
    [self.homeButton setBackgroundImage:[Utities homeAddImage] forState:UIControlStateNormal];
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:kTimerShundle
                                               target:self
                                             selector:@selector(animationTimerDidFired:)
                                             userInfo:nil
                                              repeats:YES];
    self.progreessLine.hidden = iPhone4;
    
    self.progreessLine.progress = 0;
    self.progreessLine.title = @"梦想和灵魂总有一个在路上";
    self.progreessLine.backgroundColor = [UIColor clearColor];
    self.progreessLine.bottom = NO;
    
    [self.dreamView setPressed:^(NSInteger type){
        switch (type) {
            case 0:
//                if (![[UserInfo shareUserInfo] isLogin]) {
//                    [Utities presentLoginVC:self];
//                    break;
//                }
                [self presentAddDreamVC];
                break;
            case 1:{
                [self setViewState:2];
            }break;
            case 2:{
                [self setViewState:1];
            }break;
            default:
                break;
        }
    }];
    
    
    [self addIntroductionViews];
}

- (void)addIntroductionViews
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *storeVersion = [defaults objectForKey:kVersion];
    if ([appVersion isEqualToString:storeVersion]) {
        return;
    }
    [defaults setObject:appVersion forKey:kVersion];
    [defaults synchronize];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    scrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    scrollView.delegate = self;
    scrollView.datasource = self;
    [scrollView reloadData];
    [scrollView setShowPageControl:YES];
    [delegate.window addSubview:scrollView];
}

#pragma mark- ScrollViewDelegate
- (NSInteger)numberOfPages
{
    return 3;
}
- (UIView *)pageAtIndex:(NSInteger)index
{
    CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"引导页%ld",(long)index+1]]];
    return imageView;
}

- (void)didClickPage:(CycleScrollView *)csView atIndex:(NSInteger)index
{
    NSLog(@"click %d", index);
    if (index == 2) {
        [scrollView removeFromSuperview];
    }
}

- (void)animationTimerDidFired:(NSTimer*)timer
{
    PerformModel *perform = doingPlan.doingPerform;
    if ([SQLManager shareUserInfo].running) {
        NSInteger timeInterval = [[NSDate date] timeIntervalSinceDate:[SQLManager shareUserInfo].runningBeginTime]/1;
        NSLog(@"%ld", (long)timeInterval);
        perform.realDream = [NSString stringWithFormat:@"%ld",(long)[perform.realDream integerValue]+timeInterval];
        doingPlan.finishedTime = [NSString stringWithFormat:@"%ld",(long)[doingPlan.finishedTime floatValue]+timeInterval];
        [SQLManager shareUserInfo].running = NO;
    }else{
        perform.realDream = [NSString stringWithFormat:@"%ld",(long)[perform.realDream integerValue]+kTimerSpace1];
        doingPlan.finishedTime = [NSString stringWithFormat:@"%ld",(long)[doingPlan.finishedTime floatValue]+kTimerSpace1];
    }
    if ([perform.realDream integerValue] >= [perform.planDream integerValue]) {
        if (!reminder) {
            [self showAlertView:[NSString stringWithFormat:@"%@\n今日已完成",doingPlan.title]];
            if (doingPlan.lastDay) {
                doingPlan.finished = YES;
                stateDream = 0;
            }
        }
        reminder = YES;
        
    }
    [[SQLManager shareUserInfo] updatePerform:perform];
    [[SQLManager shareUserInfo] updatePlan:doingPlan];
    
    [self setViewState:stateDream];
    NSLog(@"time doing %@, %@", perform.realDream, doingPlan.finishedTime);
}

- (void)back
{
    [self presentCalendarVC];
//    [Utities presentLoginVC:self];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    doingPlan = [SQLManager shareUserInfo].myDoingPlan;
    if (first) {
        stateDream = !doingPlan ? 0 : (doingPlan.finished ? 0 : doingPlan.doing+1);
        first = NO;
    }
    
    if ([SQLManager shareUserInfo].running) {
        stateDream = 2;
        [myTimer resumeTimerAfterTimeInterval:kTimerShundle];
    }
    [self setViewState:stateDream];
    if ([[UserInfo shareUserInfo] isLogin]) {
        [self synchronizeDreams];
    }
    if (!doingPlan) {
        
    }
}

- (void)synchronizeDreams
{
    NSArray *planModels = [[SQLManager shareUserInfo] uploadPlanModels];
    for (PlanModel* model in planModels) {
        if (![model.planIDServer isEqualToString:@"(null)"]) {
            [self requestForEditDream:model];
        }else{
            [self requestForPlanModles:model];
        }
    }
    
    NSArray *performModels = [[SQLManager shareUserInfo] uploadPerformModels];
    for (PerformModel *model in performModels) {
        [self requestForPerformModels:model];
    }
}
//获取今日梦想
- (void)requestForDoingDreams
{
    
}
//上传梦想
- (void)requestForPlanModles:(PlanModel*)planModel
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@planaction!addNewPlan.action",kServerDomain];
    NSString *titleHour = [NSString stringWithFormat:@"%ld",(long)[planModel.totalHour integerValue]/60];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:planModel.title, @"title",titleHour, @"totalHour",planModel.beginDate,@"beginString",planModel.endDate, @"endString",[UserInfo shareUserInfo].userCode, @"userCode", [self.restTime.TF.text floatValue] *60, @"unableMinute",nil];
    NSLog(@"dict %@", dict);
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject is %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        id result = [self parseResults:responseObject];
        if (result[@"result"]) {
            planModel.upload = YES;
            planModel.planIDServer = result[@"result"][@"planCode"];
            [[SQLManager shareUserInfo] updatePlan:planModel];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Utities errorPrint:error vc:self];
    }];
}
//上传已经修改的梦想
- (void)requestForEditDream:(PlanModel*)planModel
{
    [self showIndicatorView:kNetworkConnecting];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@planaction!updatePlan.action",kServerDomain];
    NSString *total = [NSString stringWithFormat:@"%ld", (long)[planModel.totalHour integerValue]/60];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:planModel.title, @"title", total, @"totalHour",planModel.beginDate,@"beginString",planModel.endDate, @"endString",[UserInfo shareUserInfo].userCode, @"userCode",planModel.planIDServer,@"planCode", [self.restTime.TF.text floatValue] *60, @"unableMinute",nil];
    NSLog(@"dict %@", dict);
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject is %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        [self dismissIndicatorView];
        id result = [self parseResults:responseObject];
        if (result) {
            planModel.upload = YES;
            planModel.planIDServer = result[@"result"][@"planCode"];
            [[SQLManager shareUserInfo] updatePlan:planModel];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Utities errorPrint:error vc:self];
        [self dismissIndicatorView];
        [self showAlertView:kNetworkNotConnect];
    }];
}
//上传每日计划
- (void)requestForPerformModels:(PerformModel*)performModel
{
    if (![performModel.planIDServer isEqualToString:@"(null)"]) {
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@performaction!addPerform.action",kServerDomain];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:performModel.planIDServer, @"planCode",performModel.performCode, @"dayString",performModel.planDream,@"planMinute",performModel.realDream, @"realPlanMinute",performModel.planRest,@"restMinute",performModel.realRest,@"realRestMinute",[UserInfo shareUserInfo].userCode, @"userCode", nil];
    NSLog(@"dict %@", dict);
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject is %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        id result = [self parseResults:responseObject];
        if (result[@"result"]) {
            performModel.upload = YES;
            [[SQLManager shareUserInfo] updatePerform:performModel];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Utities errorPrint:error vc:self];
    }];
}

- (void)setViewState:(NSInteger)state
{
    stateDream = state;
    [self.progreessLine animationDoing:(state == 2)];
    [SQLManager shareUserInfo].runningState = stateDream -1;
    if (state == 2) {
        [myTimer resumeTimerAfterTimeInterval:kTimerShundle];
    }else{
        [myTimer pauseTimer];
    }
    //0添加 1暂停 2播放
    self.dreameTitle.text = !stateDream ? @"添加梦想" : doingPlan.title;
    [self.dreamView start:state];
    if (state && [doingPlan.totalHour floatValue]) {
        CGFloat progress = [doingPlan.finishedTime floatValue]/[doingPlan.totalHour floatValue];
        [self.dreamView setStrokeEnd:progress animated:(state==1?YES:NO)];
        NSLog(@"progress %f,, %ld", progress, (long)state);
    }
    [self setPerform];
}


-(void)setPerform
{
    PerformModel *perform = doingPlan.doingPerform;
    CGFloat  h = [perform.planDream floatValue]/60;
    CGFloat a = [perform.realDream floatValue];
    CGFloat f = 0;
    if(a >1){
        f= a/[perform.planDream floatValue];
    }
    
    [self.dreamProgress setViewWithTitle:(doingPlan.finished ? @"0小时" :[NSString stringWithFormat:@"%.1f小时",a/60]) progress:(doingPlan.finished ? 0 : f)  progress:YES];
    
    h=[perform.realRest floatValue]/60;
    [self.needProgress setViewWithTitle:(doingPlan.finished ? @"0小时" : [NSString stringWithFormat:@"%.1f小时",h]) progress:0.0 progress:NO];
    
    h=[perform.realWaste floatValue]/60;
    [self.wasteProgress setViewWithTitle:(doingPlan.finished ? @"0小时" :[NSString stringWithFormat:@"%.1f小时",h]) progress:0.0 progress:NO];
    
    if (stateDream && [perform.planDream floatValue]) {
        CGFloat progress = [perform.realDream floatValue]/[perform.planDream floatValue];
        self.progreessLine.progress = (progress<=1)?progress:1;
    }else{
        self.progreessLine.progress = 0;
    }
    [self.progreessLine setNeedsDisplay];
}

- (void)doRight:(UINavigationItem*)item
{
    if (![[UserInfo shareUserInfo] isLogin]) {
        [Utities presentLoginVC:self];
        return;
    }
    [self performSegueWithIdentifier:@"SettingVC" sender:self];
    
}
- (IBAction)doHomeButton:(id)sender {
    [self presentHomeView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doLeftBut:(id)sender {
    [self.dreamView setStrokeEnd:0.2 animated:YES];
}
- (IBAction)doRightBut:(id)sender {
}

- (void)presentAddDreamVC
{
    first = YES;
    [self performSegueWithIdentifier:@"AddDreamVC" sender:self];
}

- (void)presentHomeView
{
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    HomeView *homeview = (HomeView*)[delegate.window viewWithTag:1];
    if (!homeview) {
        homeview = (HomeView*)[Utities viewAddContraintsParentView:delegate.window subNibName:@"HomeView"];
        homeview.tag = 1;
        homeview.alpha = 0;
    }
    [homeview selfAlpha:1];
    [homeview startAnimationHV];//AddreamVC
    homeview.doBut = ^(NSInteger type){
        switch (type) {
            case 0:{
                
            }break;
            case 1:{
                
                [self presentAddDreamVC];
            }break;
            case 2:{
                [self presentEditTimeView];
            }break;
            case 3:{
                [self presentCalendarVC];
            }break;
            default:
                break;
        }
        
    };
}

- (void)presentEditTimeView
{
    if (!doingPlan.doingPerform) {
        [self showAlertView:@"请添加梦想"];
        return;
    }
    
//    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    EditTime *editTime = (EditTime*)[self.view viewWithTag:10];
    if (!editTime) {
        editTime = (EditTime*)[Utities viewAddContraintsParentView :self.view subNibName:@"EditTime"];
        editTime.tag = 10;
    }
    editTime.hidden = NO;
    editTime.performModel = doingPlan.doingPerform;
    editTime.editFinished = ^(BOOL success){
        if (!success) {
            [self showAlertView:@"时间超出"];
            return;
        }
        stateDream = 1;
        [self animationTimerDidFired:nil];
    };
}



- (void)presentCalendarVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CalendarVC" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CalendarVC"];
    [self.navigationController pushViewController:vc animated:NO];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destVC = [segue destinationViewController];
    destVC.hidesBottomBarWhenPushed = YES;
    if ([segue.identifier isEqualToString:@"AddDreamVC"]) {
        if (!doingPlan.finished) {
            [destVC setValue:doingPlan forKey:@"plan"];
        }
    }
 }

@end

