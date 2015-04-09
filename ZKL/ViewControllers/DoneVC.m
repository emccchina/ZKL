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

@interface DoneVC ()
{
    HeaderCell *headerCell;
    PlanModel   *planModel;
    NSArray     *performs;
}
@property (weak, nonatomic) IBOutlet UIView *headViewBG;
@property (weak, nonatomic) IBOutlet DoneShowView *showView;
@end

@implementation DoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackItem];
    
    headerCell = (HeaderCell*)[Utities viewAddContraintsParentView:self.headViewBG subNibName:@"HeaderCell"];
    
    [headerCell.header setImageWithURL:[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/55e736d12f2eb93890a739fbd7628535e4dd6ff4.jpg"]];
    headerCell.name.text = @"name";
    headerCell.diolague.text = @"jkj;i";
    
    planModel = [[SQLManager shareUserInfo] doingPlan];
    if (!planModel.finished) {
        planModel = [[SQLManager shareUserInfo] lastPlan:planModel];
    }
    if (!planModel) {
        [self showAlertView:@"没有完成的梦想"];
        return;
    }
    performs = [[SQLManager shareUserInfo] performsByPlan:planModel];
    [self setShowViewState];
    
}

- (void)setShowViewState
{
    self.showView.title = planModel.title;
    
    CGFloat dreams = 0;
    CGFloat rest = 0;
    NSMutableArray *points = [[NSMutableArray alloc] init];
    for (PerformModel* model in performs) {
        dreams += [model.realDream floatValue];
        rest += [model.realDream floatValue];
        [points addObject:[self dictionaryWithTime:[NSString stringWithFormat:@"%.1f",[model.realDream floatValue]/60] date:model.performCode]];
    }
    
    self.showView.dreamTime = dreams/24/60;
    self.showView.restTime = rest/24/60;
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
