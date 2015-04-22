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
    
    [headerCell.header setImage:[UIImage imageNamed:@"Header"]];
    headerCell.name.text = user.userName?:@"无名氏";
    headerCell.diolague.text = user.nickName?:@"无名";
    PlanModel* model = [[SQLManager shareUserInfo] doingPlan];
    if (!model.finished) {
        self.showView.title = model.title;
        self.showView.dio = @"加油，前进前进";
        self.showView.progress = [model.totalHour floatValue]?[model.finishedTime floatValue]/[model.totalHour floatValue]:0;
        self.showView.totalTime = [model.totalHour floatValue]/60;
        self.showView.buttom = YES;
    }else{
        [self showAlertView:@"暂时没有梦想"];
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
