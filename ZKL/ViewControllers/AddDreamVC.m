//
//  AddDreamVC.m
//  ZKL
//
//  Created by EMCC on 15/2/25.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "AddDreamVC.h"
#import "WhiteBlackTextFiled.h"

@interface AddDreamVC ()
@property (weak, nonatomic) IBOutlet WhiteBlackTextFiled *addTF;
@property (weak, nonatomic) IBOutlet WhiteBlackTextFiled *needTimeTF;
@property (weak, nonatomic) IBOutlet WhiteBlackTextFiled *timeEverydayTF;
@property (weak, nonatomic) IBOutlet UIButton *OKButton;
@property (weak, nonatomic) IBOutlet WhiteBlackTextFiled *beginTime;
@property (weak, nonatomic) IBOutlet WhiteBlackTextFiled *endTime;

@end

@implementation AddDreamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackItem];
    self.OKButton.layer.cornerRadius = 5;
    self.OKButton.layer.backgroundColor = kNavBGColor.CGColor;
    self.addTF.TF.text=[NSString stringWithFormat:@"%@",_plan.title];
    self.needTimeTF.TF.text=[NSString stringWithFormat:@"%lld 分钟",_plan.totalMinute];
    self.timeEverydayTF.TF.text=[NSString stringWithFormat:@"%lld 分钟",_plan.planMinute];
    self.beginTime.TF.text=[NSString stringWithFormat:@"%@",_plan.beginDate];
    self.needTimeTF.TF.text=[NSString stringWithFormat:@"%@",_plan.endDate];
    
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
        _plan.title=string;
    };
    [self.needTimeTF setTitle:@"预计所需时间"];
    self.needTimeTF.finished = ^(NSString* string){
        _plan.totalMinute=[string longLongValue];
    };
    [self.timeEverydayTF setTitle:@"每天所需时间"];
    self.timeEverydayTF.finished = ^(NSString* string){
         _plan.planMinute=[string longLongValue];
    };
    [self.beginTime setTitle:@"开始日期"];
    [self.beginTime setType:kDateType];
    self.beginTime.finished = ^(NSString* string){
         _plan.beginDate=[NSDate date];
    };
    [self.endTime setTitle:@"结束日期"];
    [self.endTime setType:kDateType];
    self.endTime.finished = ^(NSString* string){
         _plan.endDate=[NSDate date];
    };
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleX];
    animation.toValue = @(1.0);
    animation.fromValue = @(.1);
    animation.springBounciness = 15;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.OKButton.layer pop_addAnimation:animation forKey:@"ZoomInX"];
    });
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
    if ([self.addTF.TF.text isEqualToString:@""]|| [self.needTimeTF.TF.text isEqualToString:@""]|| [self.timeEverydayTF.TF.text isEqualToString:@""]|| [self.beginTime.TF.text isEqualToString:@""]|| [self.endTime.TF.text isEqualToString:@""]) {
        [self showAlertView:@"请输入完整信息!"];
        return;
    }
   
    [self showIndicatorView:kNetworkConnecting];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@planaction!saveJson.action",kServerDomain];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.addTF.TF.text, @"title",self.needTimeTF.TF.text , @"totalMinute",self.timeEverydayTF.TF.text , @"planMinute",self.beginTime.TF.text , @"beginDate", self.endTime.TF.text , @"endDate",nil];
     NSLog( @"%@ ", dict);
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self dismissIndicatorView];
        id result = [self parseResults:responseObject];
        NSLog(@"result is %@",result);
        if (result) {
            if (0==result[@"errorno"]) {
                [self showAlertView:@"添加成功!"];
            }else{
                [self showAlertView:result[@"message"]];
            }

            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Utities errorPrint:error vc:self];
        [self dismissIndicatorView];
        [self showAlertView:kNetworkNotConnect];
    }];

    
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
