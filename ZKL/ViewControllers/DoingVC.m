//
//  DoingVC.m
//  ZKL
//
//  Created by EMCC on 15/3/20.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "DoingVC.h"
#import "HeaderCell.h"
#import "DoingShowView.h"
#import "PerformModel.h"
@interface DoingVC ()
{
    HeaderCell *headerCell;
    UserInfo *user;
    PerformModel *perform;
}
@property (weak, nonatomic) IBOutlet UIView *headViewBG;
@property (weak, nonatomic) IBOutlet DoingShowView *showView;
@end

@implementation DoingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[UserInfo shareUserInfo];
    // Do any additional setup after loading the view.
    [self showBackItem];
    headerCell = (HeaderCell*)[Utities viewAddContraintsParentView:self.headViewBG subNibName:@"HeaderCell"];
    
    [headerCell.header setImageWithURL:[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/55e736d12f2eb93890a739fbd7628535e4dd6ff4.jpg"]];
    headerCell.name.text = user.userName;
    headerCell.diolague.text = user.nickName;
    self.showView.title = @"过四级";
    self.showView.dio = @"岁月是把杀猪刀";
    self.showView.progress = 0.3;
    self.showView.totalTime = 30;
    self.showView.buttom = YES;
    
    [[SQLManager shareUserInfo] cupsTotal];
    [[SQLManager shareUserInfo] cupsMonth:@"2015-05"];
    NSLog(@"%d,%d", [[SQLManager shareUserInfo] cupsTotal],[[SQLManager shareUserInfo] cupsMonth:@"2015-05"]);
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
