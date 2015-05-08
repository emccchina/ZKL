//
//  ChangePasswordVC.m
//  ZKL
//
//  Created by EMCC on 15/4/23.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "ChangePasswordVC.h"

@interface ChangePasswordVC ()
<UITextFieldDelegate>
{
    BOOL isBack;
}
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *p2;

@property (weak, nonatomic) IBOutlet UIButton *okBut;

@property (weak, nonatomic) IBOutlet UITextField *passwordAgain;
@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackItem];
    self.title = @"修改密码";
    [self.oldPassword setSecureTextEntry:YES];
    [self.p2 setSecureTextEntry:YES];
    [self.passwordAgain setSecureTextEntry:YES];
    self.oldPassword.delegate = self;
    self.p2.delegate =self;
    self.passwordAgain.delegate = self;
    
    self.okBut.layer.cornerRadius = 3;
    self.okBut.layer.backgroundColor = kNavBGColor.CGColor;
    isBack = NO;
}

- (void)requestForNewPassword
{
    if ([self.oldPassword.text isEqualToString:@""] || [self.p2.text isEqualToString:@""] || [self.passwordAgain.text isEqualToString:@""]) {
        [self showAlertView:@"请完整信息"];
        return;
    }
    if (![self.p2.text isEqualToString:self.passwordAgain.text]) {
        [self showAlertView:@"两次密码不同"];
        return;
    }
    [self showIndicatorView:kNetworkConnecting];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@loginaction!userChangePass.action",kServerDomain];
    NSDictionary *regsiterDict = [NSDictionary dictionaryWithObjectsAndKeys:[UserInfo shareUserInfo].userCode, @"userCode",self.p2.text,@"newPassword",self.oldPassword.text, @"password",nil];
    NSLog(@"%@",regsiterDict);
    [manager POST:url parameters:regsiterDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"request is  %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        [self dismissIndicatorView];
        id result = [self parseResults:responseObject];
        if (result) {
            if([@"0" isEqual:result[@"errorno"]]){
                [self showAlertView:@"密码修改成功"];
                isBack = YES;
            }else{
                [self showAlertView:result[@"message"]];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Utities errorPrint:error vc:self];
        [self dismissIndicatorView];
        [self showAlertView:kNetworkNotConnect];
    }];
}
- (void)doAlertView
{
    if (isBack) {
        [self back];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doOKButton:(id)sender {
    [self requestForNewPassword];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
