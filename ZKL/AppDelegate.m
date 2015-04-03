//
//  AppDelegate.m
//  ZKL
//
//  Created by EMCC on 15/1/20.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeView.h"
#import "MyNavigationController.h"
#import "EditTime.h"

@interface AppDelegate ()
<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[SQLManager shareUserInfo] openDB];
    
    [UserInfo shareUserInfo];
    UITabBarController *VC = (UITabBarController*)self.window.rootViewController;
    VC.delegate = self;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"inter background");
    [self backgroundRunning];
}

#define kRunningState       @"running state"
#define kRunningDate        @"running date"

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"foreground");
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [SQLManager shareUserInfo].runningState = [[userInfo objectForKey:kRunningState] boolValue];
    [SQLManager shareUserInfo].runningBeginTime = [userInfo objectForKey:kRunningDate];
    if ([SQLManager shareUserInfo].runningState) {
        [SQLManager shareUserInfo].running = YES;
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)backgroundRunning
{
    if ([SQLManager shareUserInfo].runningState) {
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        [userInfo setObject:[NSDate date] forKey:kRunningDate];
        [userInfo setObject:@([SQLManager shareUserInfo].runningState) forKey:kRunningState];
        [userInfo synchronize];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"termi");
    [self backgroundRunning];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (viewController.tabBarItem.tag == 10) {
        [self presentHomeView];
        return NO;
    }
    
    return YES;
}

- (void)presentHomeView
{
    HomeView *homeview = (HomeView*)[self.window viewWithTag:1];
    if (!homeview) {
        homeview = (HomeView*)[Utities viewAddContraintsParentView:self.window subNibName:@"HomeView"];
        homeview.tag = 1;
        homeview.alpha = 0;
    }
    [homeview selfAlpha:1];
    [homeview startAnimationHV];//AddreamVC
    homeview.doBut = ^(NSInteger type){
        switch (type) {
            case 0:{
                
            }break;
            case 1:{
                [self presnetAddreamVC];
            }break;
            case 2:{
                [self presentEditTimeView];
            }break;
            case 3:{
                [self presentCalendarVC];
            }break;
            default:
                break;
        }
        
    };
}

- (void)presentEditTimeView
{
    EditTime *editTime = (EditTime*)[self.window viewWithTag:10];
    if (!editTime) {
        editTime = (EditTime*)[Utities viewAddContraintsParentView :self.window subNibName:@"EditTime"];
        editTime.tag = 10;
    }
    editTime.hidden = NO;
}

- (void)presnetAddreamVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SelfControl" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"AddreamVC"];
    MyNavigationController *nVC = [[MyNavigationController alloc] initWithRootViewController:vc];
    [nVC awakeFromNib];
    UITabBarController *VC = (UITabBarController*)self.window.rootViewController;
    [VC presentViewController:nVC animated:YES completion:nil];
}

- (void)presentCalendarVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CalendarVC" bundle:nil];
//    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CalendarVC"];
    MyNavigationController *nVC = [storyboard instantiateInitialViewController];//[[MyNavigationController alloc] initWithRootViewController:vc];
    [nVC awakeFromNib];
    UITabBarController *VC = (UITabBarController*)self.window.rootViewController;
    [VC presentViewController:nVC animated:YES completion:nil];

}

@end
