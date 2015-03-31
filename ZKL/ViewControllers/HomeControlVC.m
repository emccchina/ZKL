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
@interface HomeControlVC ()
{
    UserInfo *user;
    PerformModel *perform;
    
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
    [self showBackItem];
    user = [UserInfo shareUserInfo];
    perform =[PerformModel sharePerform];
    self.title = @"自控力";
    self.navigationItem.rightBarButtonItem = [Utities barButtonItemWithSomething:[UIImage imageNamed:@"Header"] target:self action:@selector(doRight:)];
    self.view.backgroundColor = [UIColor colorWithRed:69.0/255.0 green:188.0/255.0 blue:208.0/255.0 alpha:1];
    CGFloat topHieght = iPhone4 ? 10 : 50;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.dreamView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:topHieght]];
    [self.leftBut setBackgroundImage:[Utities backImage:0] forState:UIControlStateNormal];
    [self.rightBut setBackgroundImage:[Utities backImage:1] forState:UIControlStateNormal];
    [Mydate getNowDateComponents];
    [self.homeButton setBackgroundImage:[Utities homeAddImage] forState:UIControlStateNormal];
    
    self.progreessLine.hidden = iPhone4;
    
    self.progreessLine.progress = 0.8;
    self.progreessLine.title = @"岁月是把猪饲料";
    self.progreessLine.backgroundColor = [UIColor clearColor];
    self.progreessLine.bottom = NO;
    
}

- (void)back
{
    [Utities presentLoginVC:self];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.dreamView start:0];
    [self.dreamView setStrokeEnd:0.6 animated:YES];
    [self.dreamView setPressed:^(NSInteger type){
        switch (type) {
            case 0:
                [self presentAddDreamVC];
                break;
            case 1:{
                [self startPlan];
                [self.dreamView start:2];
            }break;
            case 2:{
                [self stopPlan];
               [self.dreamView start:1];
            }break;
            default:
                break;
        }
    }];
    
    [self getPlan];
    NSLog( @"重新赋值" );
    [self setPerform];

    
}

- (void)getPlan
{
    if (user.userCode) {
        [self showIndicatorView:kNetworkConnecting];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *url = [NSString stringWithFormat:@"%@performaction!getTodayPlan.action",kServerDomain];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:user.userCode , @"userCode",nil];
        [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self dismissIndicatorView];
            id result = [self parseResults:responseObject];
            NSLog(@"result is %@",result);
            if (result) {
                perform=[perform setParams:perform parmas:result[@"result"]];
                [self.dreamView start:1];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [Utities errorPrint:error vc:self];
            [self dismissIndicatorView];
            [self showAlertView:kNetworkNotConnect];
        }];
        
    }
    
}

- (void)startPlan
{
    if (user.userCode) {
        [self showIndicatorView:kNetworkConnecting];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *url = [NSString stringWithFormat:@"%@performaction!startPlan.action",kServerDomain];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:perform.performCode , @"performCode",nil];
        [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self dismissIndicatorView];
            id result = [self parseResults:responseObject];
            NSLog(@"result is %@",result);
            if (result) {
                [self.dreamView start:2];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [Utities errorPrint:error vc:self];
            [self dismissIndicatorView];
            [self showAlertView:kNetworkNotConnect];
        }];
        
    }
    
}

- (void)stopPlan
{
    if (user.userCode) {
        [self showIndicatorView:kNetworkConnecting];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *url = [NSString stringWithFormat:@"%@performaction!stopPlan.action",kServerDomain];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:user.userCode , @"userCode",nil];
        [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self dismissIndicatorView];
            id result = [self parseResults:responseObject];
            NSLog(@"result is %@",result);
            if (result) {
                [self.dreamView start:1];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [Utities errorPrint:error vc:self];
            [self dismissIndicatorView];
            [self showAlertView:kNetworkNotConnect];
        }];
        
    }
    
}

-(void) setPerform
{
    NSInteger  h=perform.planMinute/60;
    NSInteger  m=perform.planMinute%60;
    CGFloat a=(CGFloat)(perform.realPlanMinute);
    CGFloat f=0;
    if(a >1){
        f= a/perform.planMinute;
    }

    [self.dreamProgress setViewWithTitle:[NSString stringWithFormat:@"%d小时%d分钟",h ,m  ] progress:f  progress:YES];
    
    h=perform.restMinute/60;
    m=perform.restMinute%60;
    [self.needProgress setViewWithTitle:[NSString stringWithFormat:@"%d小时%d分钟",h ,m] progress:0.0 progress:NO];
    
    h=perform.wasteMinute/60;
    m=perform.wasteMinute%60;
    [self.wasteProgress setViewWithTitle:[NSString stringWithFormat:@"%d小时%d分钟",h ,m ] progress:0.0 progress:NO];
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

