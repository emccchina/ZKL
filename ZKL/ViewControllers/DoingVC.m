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
@interface DoingVC ()
{
    HeaderCell *headerCell;
}
@property (weak, nonatomic) IBOutlet UIView *headViewBG;
@property (weak, nonatomic) IBOutlet DoingShowView *showView;
@end

@implementation DoingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackItem];
    headerCell = (HeaderCell*)[Utities viewAddContraintsParentView:self.headViewBG subNibName:@"HeaderCell"];
    
    [headerCell.header setImageWithURL:[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/55e736d12f2eb93890a739fbd7628535e4dd6ff4.jpg"]];
    headerCell.name.text = @"name";
    headerCell.diolague.text = @"jkj;i";
    self.showView.title = @"过四级";
    
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
