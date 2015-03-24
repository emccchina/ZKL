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
    self.showView.title = @"过四级";
    self.showView.dreamTime = 0.63;
    self.showView.restTime = 0.2;
    NSMutableArray *points = [[NSMutableArray alloc] init];
    [points addObject:[self dictionaryWithTime:@"1.5" date:@"2/22"]];
    [points addObject:[self dictionaryWithTime:@"4" date:@"3/33"]];
    [points addObject:[self dictionaryWithTime:@"6" date:@"2/25"]];
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
