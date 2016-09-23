//
//  AppDelegate.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/19.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import <AFNetworking.h>

@interface AppDelegate ()
@property(nonatomic, strong)UIAlertController * alertVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController * viewVC = [[UIViewController alloc] init];
    viewVC.view.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = viewVC;
    [_window makeKeyAndVisible];

    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            MyTabBarViewController * myTab = [[MyTabBarViewController alloc] init];
            _window.rootViewController = myTab;
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            _alertVC = [UIAlertController alertControllerWithTitle:@"当前使用的是3G/4G网络" message:@"是否进入应用" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                ZZQLog(@"OK");
                [self initForRoot];
            }];
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [_alertVC addAction:ok];
            [_alertVC addAction:cancel];
            [viewVC presentViewController:_alertVC animated:YES completion:nil];
        }else{
            _alertVC = [UIAlertController alertControllerWithTitle:@"当前无网络" message:@"是否进入应用" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                ZZQLog(@"OK");
                [self initForRoot];
            }];
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [_alertVC addAction:ok];
            [_alertVC addAction:cancel];
            [viewVC presentViewController:_alertVC animated:YES completion:nil];
        }
    }];
    
    
    
    return YES;
}

-(void)initForRoot{
    MyTabBarViewController * myTab = [[MyTabBarViewController alloc] init];
    _window.rootViewController = myTab;
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
