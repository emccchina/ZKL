//
//  HomeControlVC.m
//  ZKL
//
//  Created by EMCC on 15/1/23.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "HomeControlVC.h"
#import "DreamTime.h"

@interface HomeControlVC ()

@property (weak, nonatomic) IBOutlet UIButton *rightBut;

@property (weak, nonatomic) IBOutlet UIButton *leftBut;
@property (weak, nonatomic) IBOutlet DreamTime *dreamView;
@end

@implementation HomeControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@", NSStringFromCGRect(self.dreamView.frame));
    [self.leftBut setBackgroundImage:[Utities backImage] forState:UIControlStateNormal];
    [self.dreamView start:0];
    [self.dreamView setStrokeEnd:0.6 animated:YES];
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

