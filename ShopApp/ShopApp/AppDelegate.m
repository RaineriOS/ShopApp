/**
 ==================================================
 描述:AppDelegate
 开发:BigKiang
 时间:2015-08-12 15:59:48
 ==================================================
 */

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LeftViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    
    
    HomeViewController *homeVc=[[HomeViewController alloc]init];
    BKNavigationCtr *navCtr=[[BKNavigationCtr alloc]initWithRootViewController:homeVc];//侧滑返回+抽屉式交互
    navCtr.navigationBarHidden=YES;
    self.window.rootViewController=navCtr;
    LeftViewController *leftVc=[[LeftViewController alloc]init];
    [navCtr setLeftViewController:leftVc withDelegate:leftVc];
    BKLog(@"%f",BKDeviceWidth);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
