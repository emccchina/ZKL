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
@interface HomeControlVC ()
{
    NSTimer     *myTimer;
    PlanModel    *doingPlan;
    NSInteger stateDream;//0添加 1暂停 2播放
}

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
    
    self.title = @"自控力";
    self.navigationItem.rightBarButtonItem = [Utities barButtonItemWithSomething:[UIImage imageNamed:@"Header"] target:self action:@selector(doRight:)];
    self.view.backgroundColor = [UIColor colorWithRed:69.0/255.0 green:188.0/255.0 blue:208.0/255.0 alpha:1];
    CGFloat topHieght = iPhone4 ? 10 : 50;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.dreamView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:topHieght]];
    [self.leftBut setBackgroundImage:[Utities backImage:0] forState:UIControlStateNormal];
    [self.rightBut setBackgroundImage:[Utities backImage:1] forState:UIControlStateNormal];
    [Mydate getNowDateComponents];
    [self.homeButton setBackgroundImage:[Utities homeAddImage] forState:UIControlStateNormal];
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                               target:self
                                             selector:@selector(animationTimerDidFired:)
                                             userInfo:nil
                                              repeats:YES];
    self.progreessLine.hidden = iPhone4;
    
    self.progreessLine.progress = 0;
    self.progreessLine.title = @"岁月是把猪饲料";
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
    
}

- (void)animationTimerDidFired:(NSTimer*)timer
{
    NSLog(@"time doing");
}

- (void)back
{
    [Utities presentLoginVC:self];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    doingPlan = [SQLManager shareUserInfo].myDoingPlan;
    stateDream = !doingPlan ? 0 : (doingPlan.finished ? 0 : doingPlan.doing+1);
    [self setViewState:stateDream];
    
}

- (void)setViewState:(NSInteger)state
{
    stateDream = state;
    if (state == 2) {
        [myTimer resumeTimer];
    }else{
        [myTimer pauseTimer];
    }
    //0添加 1暂停 2播放
    self.dreameTitle.text = !stateDream ? @"添加梦想" : doingPlan.title;
    [self.dreamView start:state];
    if (state && [doingPlan.totalHour floatValue]) {
        CGFloat progress = [doingPlan.finishedTime floatValue]/[doingPlan.totalHour floatValue];
        [self.dreamView setStrokeEnd:progress animated:YES];
        self.progreessLine.progress = progress;
    }else{
        self.progreessLine.progress = 0;
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

    [self.dreamProgress setViewWithTitle:[NSString stringWithFormat:@"%.1f小时",h] progress:f  progress:YES];
    
    h=[perform.realRest floatValue]/60;
    [self.needProgress setViewWithTitle:[NSString stringWithFormat:@"%.1f小时",h] progress:0.0 progress:NO];
    
    h=[perform.realWaste floatValue]/60;
    [self.wasteProgress setViewWithTitle:[NSString stringWithFormat:@"%.1f小时",h] progress:0.0 progress:NO];
}

- (void)doRight:(UINavigationItem*)item
{
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
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    EditTime *editTime = (EditTime*)[delegate.window viewWithTag:10];
    if (!editTime) {
        editTime = (EditTime*)[Utities viewAddContraintsParentView :delegate.window subNibName:@"EditTime"];
        editTime.tag = 10;
    }
    editTime.hidden = NO;
}



- (void)presentCalendarVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CalendarVC" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CalendarVC"];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destVC = [segue destinationViewController];
    destVC.hidesBottomBarWhenPushed = YES;
 }

@end

