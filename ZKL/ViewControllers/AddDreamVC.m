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

@end

@implementation AddDreamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackItem];
    self.OKButton.layer.cornerRadius = 5;
    self.OKButton.layer.backgroundColor = kNavBGColor.CGColor;
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
    [self.addTF setTitle:@"添加梦想"];
    [self.needTimeTF setTitle:@"预计所需时间"];
    [self.timeEverydayTF setTitle:@"每天所需时间"];
    
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
