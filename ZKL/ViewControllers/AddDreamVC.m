//
//  AddDreamVC.m
//  ZKL
//
//  Created by EMCC on 15/2/25.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "AddDreamVC.h"
#import "WhiteBlackTextFiled.h"
#import "NSDate+Agenda.h"
@interface AddDreamVC ()
{
    PlanModel *planModel;
    UserInfo *user;
    BOOL        edit;
}
@property (weak, nonatomic) IBOutlet WhiteBlackTextFiled *addTF;
@property (weak, nonatomic) IBOutlet WhiteBlackTextFiled *needTimeTF;
@property (weak, nonatomic) IBOutlet WhiteBlackTextFiled *timeEverydayTF;
@property (weak, nonatomic) IBOutlet UIButton *OKButton;
@property (weak, nonatomic) IBOutlet WhiteBlackTextFiled *beginTime;
@property (weak, nonatomic) IBOutlet WhiteBlackTextFiled *endTime;
@property (weak, nonatomic) IBOutlet WhiteBlackTextFiled *restTime;

@end

@implementation AddDreamVC
@synthesize plan = planModel;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    user=[UserInfo shareUserInfo];
    if (!planModel) {
        edit = NO;
        planModel = [[PlanModel alloc] init];
    }else{
        edit = YES;
        [self setTFValue];
    }
    [self showBackItem];
    self.OKButton.layer.cornerRadius = 5;
    self.OKButton.layer.backgroundColor = kNavBGColor.CGColor;
    self.timeEverydayTF.editTF = NO;
}

- (void)setTFValue
{
    self.addTF.TF.text=[NSString stringWithFormat:@"%@",planModel.title];
    self.needTimeTF.TF.text=[NSString stringWithFormat:@"%.1f",[planModel.totalHour floatValue]/60];
    self.needTimeTF.type = kNumberType;
    self.timeEverydayTF.TF.text=[NSString stringWithFormat:@"%.1f",[planModel.dayTime floatValue]/60];
    self.beginTime.TF.text=[NSString stringWithFormat:@"%@",[NSDate stringFromDate:[NSDate date]]];
    self.endTime.TF.text=[NSString stringWithFormat:@"%@",planModel.endDate];
    self.restTime.TF.text = [NSString stringWithFormat:@"%.1f", [planModel.restTime floatValue]/60];
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

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.addTF setTitle:@"梦想标题"];
    self.addTF.finished = ^(NSString* string){
        planModel.title=string;
    };
    [self.needTimeTF setTitle:@"预计所需时间"];
    [self.needTimeTF setType:kNumberType];
    self.needTimeTF.finished = ^(NSString* string){

    };
    [self.timeEverydayTF setTitle:@"每天所需时间"];
    [self.timeEverydayTF setType:kNumberType];
    self.timeEverydayTF.finished = ^(NSString* string){

    };
    [self.beginTime setTitle:@"开始日期"];
    [self.beginTime setType:kDateType];
    self.beginTime.finished = ^(NSString* string){
        [self countDays];
    };
    [self.endTime setTitle:@"结束日期"];
    [self.endTime setType:kDateType];
    self.endTime.finished = ^(NSString* string){
        [self countDays];
    };
    [self.restTime setTitle:@"休息时间"];
    [self.restTime setType:kNumberType];
    if (!planModel.restTime) {
        [self.restTime.TF setText:@"12"];
    }
    [self.restTime setFinished:^(NSString*string){
        
    }];
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleX];
    animation.toValue = @(1.0);
    animation.fromValue = @(.1);
    animation.springBounciness = 15;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.OKButton.layer pop_addAnimation:animation forKey:@"ZoomInX"];
    });
}

- (void)countDays
{
    if ([self.beginTime.TF.text isEqualToString:@""]) {
        return;
    }
    if ([self.endTime.TF.text isEqualToString:@""]) {
        return;
    }
    NSDate *beginDate = [NSDate dateFromString:self.beginTime.TF.text];
    NSDate  *endDate = [NSDate dateFromString:self.endTime.TF.text];
    NSTimeInterval space = [endDate timeIntervalSinceDate:beginDate];
    NSInteger days = space/60/60/24;
    planModel.dayCount = days;
    planModel.finished = NO;
    planModel.dayTime = [NSString stringWithFormat:@"%.0f",([self.needTimeTF.TF.text floatValue]/(days+1)*60)];
    self.timeEverydayTF.TF.text = [NSString stringWithFormat:@"%.1f",[self.needTimeTF.TF.text floatValue]/(days+1)];
    
    if ([planModel.dayTime integerValue] > 12*60) {
        planModel.restTime = [NSString stringWithFormat:@"%.0f",24*60-[planModel.dayTime floatValue]];
    }else{
        planModel.restTime = [NSString stringWithFormat:@"%.0f",[self.restTime.TF.text floatValue]*60];
    }
    self.restTime.TF.text = [NSString stringWithFormat:@"%.0f", [planModel.restTime floatValue]/60];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doOkButton:(id)sender {
    if ([self.addTF.TF.text isEqualToString:@""]|| [self.needTimeTF.TF.text isEqualToString:@""]||  [self.beginTime.TF.text isEqualToString:@""]|| [self.endTime.TF.text isEqualToString:@""]) {
        [self showAlertView:@"请输入完整信息!"];
        return;
    }
    if ([UserInfo shareUserInfo].isLogin) {
        if (edit) {
            [self requestForEditDream];
        }else{
            [self requestForAddDream];
        }
    }else{
        planModel.upload = NO;
        [self writeToDB];
    }
    
}

- (void)writeToDB
{
    if (edit) {
        planModel.finished = YES;
        planModel.valid = NO;
        [[SQLManager shareUserInfo] updatePlanVlaid:planModel];
        [[SQLManager shareUserInfo] deletePerform:planModel.doingPerform];
    }
    planModel.title = self.addTF.TF.text;
    planModel.beginDate = self.beginTime.TF.text;
    planModel.endDate = self.endTime.TF.text;
    planModel.totalHour = [NSString stringWithFormat:@"%.0f",[self.needTimeTF.TF.text floatValue]*60];
    planModel.finishedTime = @"0";
    planModel.finished = NO;
    planModel.valid = YES;
    planModel.planid = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    planModel.doingPerform = nil;
    if ([[SQLManager shareUserInfo] writePlanModel:planModel]){
        [self back];
    }
}

- (void)requestForAddDream
{
    [self showIndicatorView:kNetworkConnecting];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@planaction!addNewPlan.action",kServerDomain];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.addTF.TF.text, @"title",self.needTimeTF.TF.text, @"totalHour",self.beginTime.TF.text,@"beginString",self.endTime.TF.text, @"endString",[UserInfo shareUserInfo].userCode, @"userCode", nil];
    NSLog(@"dict %@", dict);
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject is %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        [self dismissIndicatorView];
        id result = [self parseResults:responseObject];
        if (result[@"result"]) {
            planModel.upload = YES;
            planModel.planIDServer = result[@"result"][@"planCode"];
            [self writeToDB];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Utities errorPrint:error vc:self];
        [self dismissIndicatorView];
        [self showAlertView:kNetworkNotConnect];
    }];
}

- (void)requestForEditDream
{
    [self showIndicatorView:kNetworkConnecting];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@planaction!updatePlan.action",kServerDomain];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.addTF.TF.text, @"title",self.needTimeTF.TF.text, @"totalHour",self.beginTime.TF.text,@"beginString",self.endTime.TF.text, @"endString",[UserInfo shareUserInfo].userCode, @"userCode",planModel.planIDServer,@"planCode", nil];
    NSLog(@"dict %@", dict);
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject is %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        [self dismissIndicatorView];
        id result = [self parseResults:responseObject];
        if (result) {
            planModel.upload = YES;
            planModel.planIDServer = result[@"result"][@"planCode"];
            [self writeToDB];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Utities errorPrint:error vc:self];
        [self dismissIndicatorView];
        [self showAlertView:kNetworkNotConnect];
    }];
}


@end
