//
//  SettingVC.m
//  ZKL
//
//  Created by EMCC on 15/3/19.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "SettingVC.h"
#import "HeaderCell.h"

@interface SettingVC ()
<UITableViewDataSource, UITableViewDelegate>{
    NSArray *settingArray;
    UserInfo *user;
}
@property (weak, nonatomic) IBOutlet UITableView *settingTB;
@end
static NSString *headerCell = @"headerCell";
static NSString *settingCell = @"settingCell";
@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackItem];
    
    [self setArray];
    user =[UserInfo shareUserInfo];
    
    self.settingTB.delegate = self;
    self.settingTB.dataSource = self;
//    [self.settingTB registerNib:[UINib nibWithNibName:@"HeaderCell" bundle:nil] forCellReuseIdentifier:headerCell];
}

- (void)setArray
{
    NSArray *section1 = @[@[@"running",@"正在进行的梦想",@"DoingVC"],@[@"finished",@"已经完成的梦想",@"DoneVC"]];
    NSArray *section2 = @[@[@"setting",@"设置",@"DoingVC"]];
    settingArray = @[section1,section2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return settingArray.count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    NSArray *arr = settingArray[section-1];
    return arr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return .1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120;
    }
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1" forIndexPath:indexPath];
        HeaderCell *headerView = (HeaderCell*)[cell viewWithTag:10];
        if (!headerView) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HeaderCell" owner:cell options:nil];
            headerView = nib[0];
            headerView.frame = cell.bounds;
            [cell addSubview:headerView];
            headerView.tag = 10;
        }
        [headerView.header setImageWithURL:[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/55e736d12f2eb93890a739fbd7628535e4dd6ff4.jpg"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        headerView.name.text = user.userName;
        headerView.diolague.text = user.nickName;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"2" forIndexPath:indexPath];
        NSArray *arr1 = settingArray[indexPath.section-1];
        NSArray *arr = arr1[indexPath.row];
        UIImageView *imageV = (UIImageView*)[cell viewWithTag:10];
        [imageV setImage:[UIImage imageNamed:arr[0]]];
        UILabel *title = (UILabel*)[cell viewWithTag:11];
        title.text = arr[1];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return;
    }
    NSArray *arr1 = settingArray[indexPath.section-1];
    NSArray *arr = arr1[indexPath.row];
    [self performSegueWithIdentifier:arr[2] sender:self];
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
