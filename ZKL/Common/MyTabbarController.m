//
//  MyTabbarController.m
//  ZYYG
//
//  Created by EMCC on 14/11/19.
//  Copyright (c) 2014年 EMCC. All rights reserved.
//

#import "MyTabbarController.h"

@interface MyTabbarController ()

@end

@implementation MyTabbarController

- (void)awakeFromNib
{
    UIViewController *view1 = [self viewControllerFormStoryboard:@"SelfControl"];
//    view1.tabBarItem = [self tabBarItemWithTitle:@"平价交易" image:[UIImage imageNamed:@"fairGray"] selectedImage:[UIImage imageNamed:@"fairRed"]];
    
    UIViewController *view2 = [[UIViewController alloc] init];//[self viewControllerFormStoryboard:@"PersonCenter"];
    [UserInfo shareUserInfo].homeAddImage = [Utities homeAddImage];
    [UserInfo shareUserInfo].backImage = [self myBackImage];
    UITabBarItem *item2 = [self tabBarItemWithTitle:nil image:[UserInfo shareUserInfo].homeAddImage selectedImage:[UserInfo shareUserInfo].homeAddImage];
    item2.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    item2.tag = 10;
    view2.tabBarItem = item2;
    
    
    UIViewController *view3 = [self viewControllerFormStoryboard:@"Club"];
//    view3.tabBarItem = [self tabBarItemWithTitle:@"个人中心" image:[UIImage imageNamed:@"personGray"] selectedImage:[UIImage imageNamed:@"personRed"]];
    self.viewControllers = [NSArray arrayWithObjects:view1,view2, view3, nil];
}

- (UIImage*)myBackImage
{
    CGFloat width = 22;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, width), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color = [UIColor colorWithRed:235.0/255.0 green:247.0/255.0 blue:239.0/255.0 alpha:1.0];
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    CGContextSetLineWidth(context, 2);
    CGFloat radius = 5;
    CGContextMoveToPoint(context, width/2+radius, width/2- 3*radius);
    CGContextAddLineToPoint(context, width/2-radius*2, width/2);
    CGContextAddLineToPoint(context, width/2+radius, width/2+3*radius);
    //    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITabBarItem*)tabBarItemWithTitle:(NSString*)title image:(UIImage*)image selectedImage:(UIImage*)selectImage
{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectImage];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIColor redColor], NSForegroundColorAttributeName,
                                  nil] forState:UIControlStateSelected];
    return item;
}

- (UIViewController*)viewControllerFormStoryboard:(NSString*)name
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    return vc;
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
